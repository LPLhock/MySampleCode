# 深入理解 Runloop


一、 RunLoop的概念 
简要概述理解： 一般一个线程执行一个任务、 但是执行完任务之后、我们为了让其不占用更多系统资源。我想让他自动退出、或者休眠的状态、等待随时指令。 去唤醒他。     这样以来 可以避免 我们创建更多的线程、 浪费资源。 还能使资源利用更大化。  在不使用到的时候 让其 保持休眠、 或者让其退出。 等需要的时候 在唤醒它 。    
基于这个想法，我们想到的可能 是通知的原理。  就是在这个线程中 注入 一个 对象，然后 我们去监听 这个对象、  通过 这个对象来了解 当前 线程 所执行 任务的状态  以及 这个任务的 一些信息  来更加 精准的 观察。  当前线程正在 执行的事件是怎么样的一种状态。  
所以、 由此Apple 应用了这种机制 RunLoop、 循环圈。 来协助 线程的工作、 使线程 工作更加高效、并且达到 降低 浪费资源的效果。 来提高线程的工作效率。 
     如果我们需要一个机制，让线程能随时处理事件但并不退出，通常的代码逻辑是这样的： 

2
3
4
5
6
7
function loop() {
    initialize();
    do {
        var message = get_next_message();
        process_message(message);
    } while (message != quit);
}

无限循环着、 直到收到了 停止的消息。 然后停住 。。 

它属于一种 模型、 这种模型通常 称为  Event Loop。  在很多系统和 框架中都用应用到、 比如 Node.js 的事件处理，比如 Windows 程序的消息循环，再比如 OSX/iOS 里的 RunLoop。   想要实现这种 事件 循环的机制 、   最关键的点 在于、  我们如果 得知 该事件 运行结束、 然后让其 休眠状态、 直到有消息时、该 如何去 唤醒 这个待命 状态的线程。   

所以 实际上 RunLoop 就是一个 对象、  其 包含了管理 需要处理的事件和 消息等 。并且 提供一个 对外的函数、 已接收 消息  和 事件， 立即 函数 内部的实现逻辑等等。 

线程执行了这个函数后，就会一直处于这个函数内部 “接受消息->等待->处理” 的循环中，直到这个循环结束（比如传入 quit 的消息），函数返回。
 
目前在 OSX/iOS 系统中、  提供了两个 直接使用的RunLoop 对象 、  一个是 C语言实现的  CFRunLoop  和 OC 封装 C 得到的 NSRunLoop 。 
区别在于 CFRunLoop 是线程安全的 、 NSRunLoop是 线程 不安全的 、 这个得注意一下 
CFRunLoopRef 是在 CoreFoundation 框架内的，它提供了纯 C 函数的 API，所有这些 API 都是线程安全的。
NSRunLoop 是基于 CFRunLoopRef 的封装，提供了面向对象的 API，但是这些 API 不是线程安全的。

CFRunLoopRef 的代码是开源的，你可以在这里 http://opensource.apple.com/tarballs/CF/ 下载到整个 CoreFoundation 的源码来查看。

二 、  RunLoop 与 线程的关系

Apple  不允许 直接 创建 RunLoop 、 其只提供了 两个 C函数 获取的 API. 
CFRunLoopGetMail();
CGRunLoopGetCurrent();
 一个 是获取 主线程 对应 RunLoop .  一个是获取当前线程 对应 RunLoop . 
 下面这段代码 是 对这两个函数大致逻辑实现原理
/// 全局的Dictionary，key 是 pthread_t， value 是 CFRunLoopRef
static CFMutableDictionaryRef loopsDic;
/// 访问 loopsDic 时的锁
static CFSpinLock_t loopsLock;
 
/// 获取一个 pthread 对应的 RunLoop。
CFRunLoopRef _CFRunLoopGet(pthread_t thread) {
    OSSpinLockLock(&loopsLock);
    
    if (!loopsDic) {
        // 第一次进入时，初始化全局Dic，并先为主线程创建一个 RunLoop。
        loopsDic = CFDictionaryCreateMutable();
        CFRunLoopRef mainLoop = _CFRunLoopCreate();
        CFDictionarySetValue(loopsDic, pthread_main_thread_np(), mainLoop);
    }
    
    /// 直接从 Dictionary 里获取。
    CFRunLoopRef loop = CFDictionaryGetValue(loopsDic, thread));
    
    if (!loop) {
        /// 取不到时，创建一个
        loop = _CFRunLoopCreate();
        CFDictionarySetValue(loopsDic, thread, loop);
        /// 注册一个回调，当线程销毁时，顺便也销毁其对应的 RunLoop。
        _CFSetTSD(..., thread, loop, __CFFinalizeRunLoop);
    }
    
    OSSpinLockUnLock(&loopsLock);
    return loop;
}
 
CFRunLoopRef CFRunLoopGetMain() {
    return _CFRunLoopGet(pthread_main_thread_np());
}
 
CFRunLoopRef CFRunLoopGetCurrent() {
    return _CFRunLoopGet(pthread_self());
}

RunLoop是 与线程 一一对应的。 如果我们在创建线程的时候、 没有去主动获取 当前线程的RunLoop、 其是不会创建的。 保存的方法 是用的 一个全局 字典去当 Key值、 并使用 一个 Lock. 做Key、 防止 多次创建 并添加到 线程中。 确保 一个线程只对应一个 RunLoop。
从上面的代码可以看出，线程和 RunLoop 之间是一一对应的，其关系是保存在一个全局的 Dictionary 里。线程刚创建时并没有 RunLoop，如果你不主动获取，那它一直都不会有。RunLoop 的创建是发生在第一次获取时，RunLoop 的销毁是发生在线程结束时。你只能在一个线程的内部获取其 RunLoop（主线程除外）因为获取RunLoop、的函数不提供参数、  默认只是传 当前所在线程 。


三、 RunLoop 对外的接口。 
在 CoreFoundation 里面关于 RunLoop 有5个类:
CFRunLoopRef 

CFRunLoopModeRef 

CFRunLoopSourceRef 

CFRunLoopTimerRef 

CFRunLoopObserverRef
ypedef CFStringRef CFRunLoopMode CF_EXTENSIBLE_STRING_ENUM;

typedef struct CF_BRIDGED_MUTABLE_TYPE(id) __CFRunLoop * CFRunLoopRef; 

typedef struct CF_BRIDGED_MUTABLE_TYPE(id) __CFRunLoopSource * CFRunLoopSourceRef; 

typedef struct CF_BRIDGED_MUTABLE_TYPE(id) __CFRunLoopObserver * CFRunLoopObserverRef; 

typedef struct CF_BRIDGED_MUTABLE_TYPE(NSTimer) __CFRunLoopTimer * CFRunLoopTimerRef; 

/* Reasons for CFRunLoopRunInMode() to Return */
其中 CFRunLoopModeRef 类并没有对外暴露，只是通过 CFRunLoopRef 的接口进行了封装。

一个RunLoop 里面 都会包含 若干个。 Mode、   每个 Mode 里 包含  一个 Source 集合、 Observer 数组、 Timer 数组、  一个RunLoop 运行 只能 指定 其中 一个 Mode 去 运行、  并且 在运行中、想要切换的话  必须要退出 当前 RunLoop、 然后在进行切换 之后运行 才可以。  这样做的原因是：  要分离不同组的 Source/Timer/Observer 。 让其互不影响。 
CFRunLoopSourceRef ： 主要是管理 事件的产生的 地方 、  比如 触摸、 点击、 旋转等、Source有两个版本：Source0 和 Source1。
· Source0 只包含了一个回调（函数指针），它并不能主动触发事件。使用时，你需要先调用 CFRunLoopSourceSignal(source)，将这个 Source 标记为待处理，然后手动调用 CFRunLoopWakeUp(runloop) 来唤醒 RunLoop，让其处理这个事件。
· Source1 包含了一个 mach_port 和一个回调（函数指针），被用于通过内核和其他线程相互发送消息。这种 Source 能主动唤醒 RunLoop 的线程，
CF_EXPORT void CFRunLoopSourceSignal(CFRunLoopSourceRef source);
CF_EXPORT void CFRunLoopWakeUp(CFRunLoopRef rl);
CF_EXPORT void CFRunLoopStop(CFRunLoopRef rl); 
· Source0 只包含了一个回调（函数指针），它并不能主动触发事件。使用时，你需要先调用 CFRunLoopSourceSignal(source)，将这个 Source 标记为待处理，然后手动调用 CFRunLoopWakeUp(runloop) 来唤醒 RunLoop，让其处理这个事件。

CFRunLoopTimerRef 是基于时间的触发器，它和 NSTimer 是toll-free bridged 的，可以混用。其包含一个时间长度和一个回调（函数指针）。当其加入到 RunLoop 时，RunLoop会注册对应的时间点，当时间点到时，RunLoop会被唤醒以执行那个回调。
CFRunLoopObserverRef 是观察者，每个 Observer 都包含了一个回调（函数指针），当 RunLoop 的状态发生变化时，观察者就能通过回调接受到这个变化。可以观测的时间点有以下几个：


1
2
3
4
5
6
7
8
typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
    kCFRunLoopEntry         = (1UL << 0), // 即将进入Loop
    kCFRunLoopBeforeTimers  = (1UL << 1), // 即将处理 Timer
    kCFRunLoopBeforeSources = (1UL << 2), // 即将处理 Source
    kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入休眠
    kCFRunLoopAfterWaiting  = (1UL << 6), // 刚从休眠中唤醒
    kCFRunLoopExit          = (1UL << 7), // 即将退出Loop
};

上面的 Source/Timer/Observer 被称为 一个 mode item 、   一个Mode 可以同时包含多个 mode item 。  但是一个 Mode 同时添加多个相同 的 mode item 时不会产生叠加效果 。    加入 一个 Mode 里面 没有 一个 mode item。   则 当前 RunLoop 会直接退出 。停止循环。 

四 、RunLoop 里的  Mode 。


CFRunLoopMode 和 CFRunLoop 的结构大致如下：


1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
struct __CFRunLoopMode {
    CFStringRef _name;            // Mode Name, 例如 @"kCFRunLoopDefaultMode"
    CFMutableSetRef _sources0;    // Set
    CFMutableSetRef _sources1;    // Set
    CFMutableArrayRef _observers; // Array
    CFMutableArrayRef _timers;    // Array
    ...
};
 
struct __CFRunLoop {
    CFMutableSetRef _commonModes;     // Set
    CFMutableSetRef _commonModeItems; // Set<Source/Observer/Timer>
    CFRunLoopModeRef _currentMode;    // Current Runloop Mode
    CFMutableSetRef _modes;           // Set
    ...
};

这里有一个 概念叫做 CommonModes 、  一个 Mode 可以将自己标记为 Common 属性。、 通过将 （通过将其 ModeName 添加到 RunLoop 的 “commonModes” 中）。每当RunLoop、内容发生了变化之后， 其会自动将 _commonModes 里的 // Set&lt;Source/Observer/Timer 同步到具有 “Common” 标记的所有Mode里。 
具体应用场景 、分析的没太看懂 。 
在项目中的 代码实现一般是这样的 。 
        self.productTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(productCountDown:) userInfo:nil repeats:YES]; 
        [[NSRunLoop currentRunLoop] addTimer:self.productTimer forMode:NSRunLoopCommonModes]; 
 
  
五 、RunLoop 的内部逻辑。

源码实现有点儿复杂 、   涉及到的基本都是 C 里面 CFRunloop 函数、 看了YY 的猜测 源码实现。有点长。。。。。 

大概根据图中 理解大意是 这样的 

进入：1、 通知 对象 即将 进入到 一个 RunLoop中 、 
循环
2、通知 对象 将要处理 Timer、 （Timer） 不知道是不是指超时时间 和 定时等。
3、通知 对象 将要 处理 Source0、
4、对象 去处理 Source0、
5、判断是否 有Source1 、有则 跳 第九步 没太明白？  当时 对 Source1 定义是说其 主要作用是 唤醒 线程  定义 ： 包含了一个 mach_port 和一个回调（函数指针），被用于通过内核和其他线程相互发送消息。这种 Source 能主动唤醒 RunLoop 的线程。
6、 时间处理完成、 通知对象、线程即将休眠。
7、 休眠、等待唤醒。
8、 通知对象、 线程刚被唤醒。
9、 处理唤醒时 收到的消息，然后调回第二步 循环。。。
退出：10、通知对象、即将退出Loop。

六 RunLoop 的底层实现

Apple 把  整个操作系统分成 四层：
最上层： 应用层、  即用户直接接触到的App等 
应用框架层：Cocoa框架。。。
核心框架层：CoreImage。 OpenGL等  更底层的框架 。
Darwin 即操作 系统 的核心底层 包括 系统的 内核、 Shell、 驱动等内容

汇编指令。
八、苹果用RunLoop实现的功能
可以看到，系统默认注册了5个Mode:
1. kCFRunLoopDefaultMode: App的默认 Mode，通常主线程是在这个 Mode 下运行的。
2. UITrackingRunLoopMode: 界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响。
3. UIInitializationRunLoopMode: 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用。
4: GSEventReceiveRunLoopMode: 接受系统事件的内部 Mode，通常用不到。
5: kCFRunLoopCommonModes: 这是一个占位的 Mode，没有实际作用。
1.刚启动时注入RunLoop。
2.AutoreleasePool
3.事件响应
4.手势识别
5.界面更新
6.定时器
7.PerformSelecter
8.GCD
9.关于网络请求。

 通过 RunLoop 理解 AutoreleasePool。  
 现在已经不在需要 手写 AutoreleasePool、  原理在于 App 启动后，  Apple 在主线程 RunLoop里 注册了两个 Observer 、  去进行回调。  
 


