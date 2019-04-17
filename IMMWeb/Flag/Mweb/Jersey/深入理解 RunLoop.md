#深入理解 RunLoop
  
  参考: 
    [runloop 详解](https://blog.csdn.net/wzzvictory/article/details/9237973)
    [YYKit RunLoop](https://blog.ibireme.com/2015/05/18/runloop/)
    [RunLoop 原理和核心机制] (https://www.cnblogs.com/zy1987/p/4582466.html)
    [Apple RunLoop](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html#//apple_ref/doc/uid/10000057i-CH16-SW20)
    
   [TOC]
## 运行循环  

**核心**: 
 一般来说, 线程执行完一个任务之后如果没有任务继续, 则会退出, 否则严重占用系统资源. 如果我们需要一种机制, 那么通过无限循环的方法, 可以让线程一直常驻不会退出, 然后随时使用的时候直接调用。
 
 RunLoop 与 多线程 是一一对应的, 其是线程框架基础的一部分, RunLoop 是一个不断循环运行的机制, 其可以让线程在有任务的时候保持运行(通过 While 循环方式), 在没有任务的时候进入休眠状态而不退出(通过 While 在实现里面判断当前是否有任务进行, 如果无则进入休眠状态), 这样做不仅能大大节省了性能开销问题, 还可以提高线程工作效率, 总而言之大大提升了 多线程 资源访问.

RunLoop 是一个对象,  这个对象要干的事就是处理不断循环中,  接收消息 -> 等待消息 -> 处理。 简单来说 其就是 处理消息和事件, 并提供循环内逻辑实现. 想要实现这些功能那么这个对象 **必须要有相应的状态（Observer）. 以及不同消息能力和事件的不同类型(RunLoopMode).**

RunLoop 并不是完全自动启动的, 除了主线程的 RunLoop 是在 UIApplicationMail 函数创建,与主线程启动。 其他子线程的 RunLoop 还需要我们手动获取并启动. 不过我们并不需要创建这个 RunLoop 对象,  Apple 会为我们隐式生成, 一个线程只能对应一个 RunLoop对象(一对多的形式是,一个线程对应的一个 RunLoop 下在这个 RunLoop 里面又获取多个RunLoop), 所以如果我们想在新开辟的子线程中 开启当前 RunLoop 可以通过 Cocoa 或 CoreFundation 提供的 Api 来进行配置 启动. 

## 运行循环的剖析

###运行循环模式

 
    
##疑问

  看了很多关于 RunLoop 原理, 理论的讲解文章, 一些使用方法和 runLoop 的一些特性, 有了一定了解, 但是一直有一个问题就是, RunLoop 是不断循环的工作,  通过 while 循环条件判断 线程未结束, 就不断的循环运行, 或者判断语句是 App 是否是启动状态。 使 这个循环一直保持下来, 然后具体实现则是 首先判断当前是否有什么事情做, 假如没有, 那么让其进入一个休眠的状态,  假如有则要将 runLoop 唤醒去工作.
  简单说这就是 RunLoop 整体的运行机制,  有事情干的时候唤醒, 去工作, 没有事情干的时候使其进入休眠状态。 但是 RunLoop 的休眠 与 唤醒 如何进行的呢, 以及它除了 休眠 和  唤醒状态还有什么状态存在？   
  * RunLoop  主要做了什么, 它有分类吗. 
  * RunLoop     
    


## YYKit RunLoop 对外的接口

RunLoop 有五种类型.   CFRunLoopRef. CFRunLoopModeRef. CFRunLoopSourceRef. CFRunLoopTimerRef. CFRunLoopObserverRef。

![RunLoop](https://blog.ibireme.com/wp-content/uploads/2015/05/RunLoop_0.png)

作者将 RunLoop 解释成包含若干个 Mode.然后每个 Mode 包含 Source Set. Timer NSArray. Observer NSArray. 每次启动 RunLoop 只能在一个 Mode 上面运行, 如果想要切换 Mode, 则需要退出,在重新进入 指定一个 Mode.  主要是为了不影响其他Mode。

**CFRunLoopSourceRef**: 指的是事件产生的地方. 有两个版本 Source0。 Source1.
* Source0: 只包含一个回调(函数指针),它并不能主动触发事件,使用时需要先调用 CFRunLoopSourceSignal(source) 来对这个 Source 时间进行标记, 然后在通过 CFRunLoopWakeUp(runloop) 来对其唤醒.让其处理事件。
* Source1: 包含一个 mach_port 和一个回调, 主要用于内核和其他线程通讯消息, 这种 Source 可以主要唤醒 RunLoop。
**CFRunLoopTimerRef**: 指的是基于时间的触发器. NSTimer 是基于其来封装的, 所以这两个类是 toll-free Bridge 的, 可以混用。  它主要包含一个 时间长度和 回调,  当其加入 Runloop 时, RunLoop 会基于时间长度 注册一个时间段, 在到达时间段是 唤醒 RunLoop 进行回调.
**CFRunLoopObserverRef**: 指的是观察者, 表示当前运行状态.  每个 Observer 都是包含一个回调,当状态发生改变时, 观察者就通过这个回调来获取当前 Runloop 的状态.
```
typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
    kCFRunLoopEntry         = (1UL << 0), // 即将进入Loop
    kCFRunLoopBeforeTimers  = (1UL << 1), // 即将处理 Timer
    kCFRunLoopBeforeSources = (1UL << 2), // 即将处理 Source
    kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入休眠
    kCFRunLoopAfterWaiting  = (1UL << 6), // 刚从休眠中唤醒
    kCFRunLoopExit          = (1UL << 7), // 即将退出Loop
};
```
上面的 Source/timer/observer/ 三者被统一称为  Mode item, 一个 item 可以同时加入多个 Mode, 但一个 item 被同时加入重复 Mode 并不会有什么效果, 并且一个 RunLoop 运行时只能选择 一个 Mode. 加入一个 Mode 中一个 item 都没有, 则RunLoop自动退出,不进行循环. 

## RunLoop 的 Mode

CFRunLoopMode 和 CFRunLoop 的结构大致如下：
```
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
```
Apple 对外提供的两个 Mode 为: NSRunLoopDefaultModel 和 UITrackingRunLoopMode, 一般这两个模型基本可以解决所有事件和 UI 问题。 还有一个 NSRunLoopCommonModes, 这个是一个 RunLoopMode 集合, 包含上面两种.
Cocoa 定义的四中 Mode。 向外提供 2种。

**NSRunLoopDefaultModel:** 默认模式是用于大多数操作的模式。大多数情况下，您应该使用此模式启动运行循环并配置输入源。
**NSEventTrackingRunLoopMode:** Cocoa使用此模式在鼠标拖动循环和其他种类的用户界面跟踪循环期间限制传入事件.
**NSModalPanelRunLoopMode:** Cocoa使用此模式来识别用于模态面板的事件。
**NSConnectionReplyMode:** Cocoa将此模式与NSConnection对象结合使用以监视回复。您自己应该很少需要使用此模式。。
**NSRunLoopCommonModes:** 这是一组可配置的常用模式。将输入源与此模式相关联也会将其与组中的每个模式相关联。对于Cocoa应用程序，此集合默认包括默认，模态和事件跟踪模式。Core Foundation最初只包含默认模式。您可以使用该CFRunLoopAddCommonMode功能将自定义模式添加到集合中。


## RunLoop 内部逻辑

参考 Apple 文档 + YYkit 解释: [Apple](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html#//apple_ref/doc/uid/10000057i-CH16-SW20)

1. 通知 observer 已经输入运行循环.
2. 通知 observer 让 timer 准备好启动.
3. 通知 observer 让 Source0 准备处理事件
4. 通知 observer 让 Source1 准备处理事件
5. 如果基于端口的输入源准备就绪并等待触发，请立即处理该事件。转到第9步。
6. 通知 observer 即将进入睡眠.
7. 将线程置于睡眠状态, 直到其中这几个事件触发:
   * Source 到达, 处理相应事件。
   * Timer 启动, 处理定时器。
   * 为运行循环设置的超时值到期。
   * 运行循环被明确唤醒。
8. 通知 observer 唤醒
9. 处理待处理事件:
   * 	如果触发了用户定义的计时器，则处理计时器事件并重新启动循环。转到第2步。
   * 如果输入源被触发，则传递事件。
   * 如果运行循环被明确唤醒但尚未超时，请重新启动循环。转到第2步。

10. 通知 observer 退出运行循环。

## 什么时候使用运行循环？

根据Apple 文档表示, 只有在子线程外才需要启动 RunLoop, 但是在一般情况下, 我们都不需要去启动 RunLoop, 运行循环适用于您希望与线程进行更多交互的情况,不过在一些特殊情况下我们还是会用到的, 例如

	•	使用端口或自定义输入源与其他线程通信。
	•	在线程上使用计时器。
	•	使用performSelectorCocoa应用程序中的任何...方法。
	•	保持线程以执行定期任务。
如果您确实选择使用运行循环，则配置和设置非常简单。与所有线程编程一样，您应该有一个在适当情况下退出辅助线程的计划。最好通过让它退出而不是强制它终止来干净地结束一个线程。有关如何配置和退出运行循环的信息，请参阅[使用运行循环对象](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html#//apple_ref/doc/uid/10000057i-CH16-SW5)。

## Apple 对RunLoop 应用

###AutoreleasePool

App 启动时，Apple 在主线程 RunLoop 里面注册了两个 Observer, 其回调都是_wrapRunLoopWithAutoreleasePoolHandler().

第一个 Observer 主要负责监听 即将进入 RunLoop(应该是出现对象初始化时), 然后进行回调, 调用_objc_autoreleasePoolPush() 创建一个自动释放池, 优先级最高，保证创建释放池发生在其他所有回调之前。

第二个 Observer 负责监听两个事件: BeforeWaiting(准备进入休眠) 时调用_objc_autoreleasePoolPop() 和 _objc_autoreleasePoolPush() 释放旧的池并创建新池；Exit(即将退出Loop) 时调用 _objc_autoreleasePoolPop() 来释放自动释放池。这个 Observer 的 order 是 2147483647，优先级最低，保证其释放池子发生在其他所有回调之后。

在主线程执行的代码，通常是写在诸如事件回调、Timer回调内的。这些回调会被 RunLoop 创建好的 AutoreleasePool 环绕着，所以不会出现内存泄漏，开发者也不必显示创建 Pool 了。

###事件响应

苹果注册了一个 Source1 (基于 mach port 的) 用来接收系统事件，其回调函数为 __IOHIDEventSystemClientQueueCallback()。

### 手势识别

### 界面更新
苹果注册了一个 Observer 监听 BeforeWaiting(即将进入休眠) 和 Exit (即将退出Loop) 事件，回调去执行一个很长的函数：
_ZN2CA11Transaction17observer_callbackEP19__CFRunLoopObservermPv()。这个函数里会遍历所有待处理的 UIView/CAlayer 以执行实际的绘制和调整，并更新 UI 界面。

###定时器

NSTimer 其实就是 CFRunLoopTimerRef，他们之间是 toll-free bridged 的。一个 NSTimer 注册到 RunLoop 后，RunLoop 会为其重复的时间点注册好事件。例如 10:00, 10:10, 10:20 这几个时间点。RunLoop为了节省资源，并不会在非常准确的时间点回调这个Timer。Timer 有个属性叫做 Tolerance (宽容度)，标示了当时间点到后，容许有多少最大误差。

假如定时器的时间间隔很短, 但是中间执行逻辑又很长, 占用时间超过了间隔时间, 那么这次回调不会延后, 会直接跳过去。

CADisplayLink 是一个和屏幕刷新率一致的定时器（但实际实现原理更复杂，和 NSTimer 并不一样，其内部实际是操作了一个 Source）。如果在两次屏幕刷新之间执行了一个长任务，那其中就会有一帧被跳过去（和 NSTimer 相似），造成界面卡顿的感觉。在快速滑动TableView时，即使一帧的卡顿也会让用户有所察觉。Facebook 开源的 AsyncDisplayLink 就是为了解决界面卡顿的问题，其内部也用到了 RunLoop，这个稍后我会再单独写一页博客来分析。

###PerformSelecter

实际上我们在调用 此类 方法时,一般会在当前 RunLoop 添加一个定时器, 然后到了间隔时间在去执行此段代码, 假如在一条新的线程执行此类代码, 我们又没有让 当前 RunLoop 运行起来, 则这段代码是失效的。
performSelecter:afterDelay:
performSelector:onThread:

###关于GCD


###关于网络请求


## RunLoop 实际应用

### AFNetWorking

AFURLConnectionOperation  这个类是基于 NSURLConnection 进行构建, 其希望代理回调能再后台处理, 创建了一个常驻的子线程, 一般来说子线程如果没有任务, 会自动退出掉, 避免占用内存空间。
然后在当前子线程中启动 RunLoop。

```
+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"AFNetworking"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}
 
+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    return _networkRequestThread;
}
```

我们还看到 AF 将 [NSMachport port] 端口添加到 RunLoop, 主要原因是 RunLoop 运行循环条件是必须至少有一个 Source/timer/Observer.所以 AFNetworking 在 [runLoop run] 之前先创建了一个新的 NSMachPort 添加进去了。 这个端口实际是并没有做什么情况, 只是为了让循环进行 不退出而已。
通常情况下，调用者需要持有这个 NSMachPort (mach_port) 并在外部线程通过这个 port 发送消息到 loop 内；但此处添加 port 只是为了让 RunLoop 不至于退出，并没有用于实际的发送消息。

```
- (void)start {
    [self.lock lock];
    if ([self isCancelled]) {
        [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    } else if ([self isReady]) {
        self.state = AFOperationExecutingState;
        [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }
    [self.lock unlock];
}
```
当需要此线程执行任务时, AF 直接将任务丢到这个后台线程去执行即可。

### 滑动页面添加定时器

###

###TableView中实现平滑滚动延迟加载图片
利用CFRunLoopMode的特性，可以将图片的加载放到NSDefaultRunLoopMode的mode里，这样在滚动UITrackingRunLoopMode这个mode时不会被加载而影响到。

```
UIImage *downloadedImage = ...;
[self.avatarImageView performSelector:@selector(setImage:)
     withObject:downloadedImage
     afterDelay:0
     inModes:@[NSDefaultRunLoopMode]];
     
```





 




