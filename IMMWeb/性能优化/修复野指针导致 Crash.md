# 浅谈野指针异常

## 前言
工程师们苦 Crash 久矣，尤其是用户感知最为明显的客户端。那居高不下的崩溃率、数不胜数的用户反馈、迟迟无法完成的 KPI，折磨着每一位客户端的开发同学。


> 加断点再Debug，堆栈瞬间就爆炸，日志输出如雨下，看到异常就害怕；调试一夜没人陪，心想这锅该归谁？回想当初心后悔，不该重构这地雷；翻日志查半天，博客看了千百遍，低头又点一根烟，闪退还是没复现。

上面这段文字很形象的描述了一位深夜排查闪退问题的工程师。那么 Crash 为何如此难以解决且反复发作，它究竟难在哪里，从客户端工程诞生至今一直困扰着无数的工程师。

## 线程 And RunLoop

**Q：执行以下代码，打印结果是什么？**
```
dispatch_queue_t cQueue = dispatch_queue_create("JSD", DISPATCH_QUEUE_CONCURRENT);
dispatch_async(cQueue, ^{
   NSLog(@"Perform: 1");
   [self performSelector:@selector(testPerformSelector) withObject:nil afterDelay: 0];
   NSLog(@"Perform: 3");
});

- (void)testPerformSelector {
    NSLog(@"Perform: 2");
}

```

打印结果为 1、3。原因是：
1. performSelector:withObject:afterDelay: 的本质是拿到当前线程的 RunLoop 往它里面添加 timer
2.RunLoop 和线程是一一对应关系，子线程默认没有开启 RunLoop
3.当前 performSelector:withObject:afterDelay: 在子线程执行, 所以 2 不会打印。


## 野指针

>野指针是指指向一个已删除的对象或未申请访问受限内存区域的指针, 访问野指针是不会Crash的，只有野指针指向的地址被写上了有问题的数据才会引发Crash

**Obj-C的野指针最常见的一种栈是objc_msgSend**

看了一下 Firebase 崩溃信息收集, 历史遗留问题最多当属野指针和多线程相关的异常。
野指针崩溃为什么如此难以排查, 最主要是原因是其随机性较高, 在测试阶段很难浮出水面, 往往需要等到上线后, 用户量覆盖足够多之后, 问题才会暴露出来。

**两大类型:**

1. 跑不进出错的逻辑，执行不到出错的代码，这种可以提高测试场景覆盖度来解决。
2. 跑进了有问题的逻辑，但是野指针指向的地址并不一定会导致Crash，这好像要看人品了？

**为什么会随机**
因为dealloc执行后只是告诉系统，这片内存我不用了，而系统并没有就让这片内存不能访问。
现实大概是下面几种可能的情况：

1. 对象释放后内存没被改动过，原来的内存保存完好，可能不Crash或者出现逻辑错误（随机Crash）。
2. 对象释放后内存没被改动过，但是它自己析构的时候已经删掉某些必要的东西，可能不Crash、Crash在访问依赖的对象比如类成员上、出现逻辑错误（随机Crash）。
3. 对象释放后内存被改动过，写上了不可访问的数据，直接就出错了很可能Crash在objc_msgSend上面（必现Crash，常见）。
4. 对象释放后内存被改动过，写上了可以访问的数据，可能不Crash、出现逻辑错误、间接访问到不可访问的数据（随机Crash）。
5. 对象释放后内存被改动过，写上了可以访问的数据，但是再次访问的时候执行的代码把别的数据写坏了，遇到这种Crash只能哭了（随机Crash，难度大，概率低）！！
6. 对象释放后再次release（几乎是必现Crash，但也有例外，很常见）。

**参考下图:**
![野指针](https://upload-images.jianshu.io/upload_images/68070-cf1c2444137fa0db.png?imageMogr2/auto-orient/strip|imageView2/2/format/webp====)

## atomic
> @property 默认修饰符是 atomic, 原子性可以确保当前被修饰的属性 set get 按顺序执行而不被打断, atomic的作用只是给 getter 和 setter 加了个锁，atomic只能保证代码进入getter或者setter函数内部时是安全的，一旦出了getter和setter，多线程安全只能靠程序员自己保障了。


[Runtime-Property 源码](https://opensource.apple.com/source/objc4/objc4-493.9/runtime/Accessors.subproj/objc-accessors.m)

下面是 runtime 实现 @property set 方法: 
```
typedef uintptr_t spin_lock_t;
extern void _spin_lock(spin_lock_t *lockp);
extern int  _spin_lock_try(spin_lock_t *lockp);
extern void _spin_unlock(spin_lock_t *lockp);
PRIVATE_EXTERN void objc_setProperty_non_gc(id self, SEL _cmd, ptrdiff_t offset, id newValue, BOOL atomic, BOOL shouldCopy) {
    // Retain release world
    id oldValue, *slot = (id*) ((char*)self + offset);

    // atomic or not, if slot would be unchanged, do nothing.
    if (!shouldCopy && *slot == newValue) return;
   
    if (shouldCopy) {
        newValue = (shouldCopy == OBJC_PROPERTY_MUTABLECOPY ? [newValue mutableCopyWithZone:NULL] : [newValue copyWithZone:NULL]);
    } else {
        newValue = objc_retain(newValue);
    }

    if (!atomic) {
        oldValue = *slot;
        *slot = newValue;
    } else {
        spin_lock_t *slotlock = &PropertyLocks[GOODHASH(slot)];
        _spin_lock(slotlock);
        oldValue = *slot;
        *slot = newValue;        
        _spin_unlock(slotlock);        
    }

    objc_release(oldValue);
}
```


## Autoreleasepool

> @autoreleasepool 当自动释放池被销毁或者耗尽时，会向自动释放池中的所有对象发送 release 消息，释放自动释放池中的所有对象。

```
- (void)testAutoreleasepoolWithNumber:(NSUInteger)number {
    // largeNumber是一个很大的数
    for (NSUInteger i = 0; i < number; i++) {
        @autoreleasepool {
        NSString *str = [NSString stringWithFormat:@"hello -%04lu", (unsigned long)i];
        str = [str stringByAppendingString:@" - world"];
        NSLog(@"%@", str);
        }
    }
}
```

## 0x1 多线程

**Thread 37: EXC_BAD_ACCESS (code=1, address=0x1fcd8dbc9b50)
BAD_ACCESS
Thread 13: signal SIGABRT
objc_msgSend****


```
func testData() {
        DispatchQueue.global().async {
            for i in 0..<5000 {
                DispatchQueue.global().async {
                    self.lock.lock()
//                    NSLog("JerseyTTT当前正在循环: \(i), string: \(self.testDataString),  : thread:\(Thread.current)")
                    let random = Int.random(in: 0...1000)
                    self.testDataString = [random]
//                    let random2 = Int.random(in: 0...random)
//                    self.testDataString = [random, random2, random + random2]
//                    let random3 = Int.random(in: 0...random2)
//                    self.testDataString = [random, random2, random3, random + random2, random + random2 + random3]
                    NSLog("JerseyTTT当前正在循环: \(i), string: \(self.testDataString),  : thread:\(Thread.current)")
                    self.lock.unlock()
                }
            }
        }
    }
```

## Firebase 现存野指针未解决崩溃问题

* HTDetailChatModel 
* HTDetailChatViewController.m  -[HTDetailChatViewController setDataSource:] https://console.firebase.google.com/u/0/project/api-8207851731662405563-887232/crashlytics/app/ios:com.helloTalk.helloTalk/issues?time=last-ninety-days&issuesQuery=setDataSource&state=open&type=all&tag=all
* HTDatabaseConnect.m [HTDatabaseConnect asyncReadWithTransaction:completionBlock:]_block_invoke
  https://console.firebase.google.com/u/0/project/api-8207851731662405563-887232/crashlytics/app/ios:com.helloTalk.helloTalk/issues?time=last-ninety-days&state=all&type=all&tag=all&issuesQuery=HTDatabaseConnect
* [早期崩溃](https://console.firebase.google.com/u/0/project/api-8207851731662405563-887232/crashlytics/app/ios:com.helloTalk.helloTalk/issues?time=last-ninety-days&state=all&type=all&tag=early) 



### 总结

* 尽量避免复杂的多线程设计
* 使用多线程的时候要保持警惕, 尽量加上注释, 防止后面维护的人不清楚
* 使用串行队列, 锁, 原子性到对应的业务场景确保线程安全
* 用 Xcode Analyze 检测代码实现漏洞
* 使用 Xcode Memory Management 提高野指针复现率
* 如果不知道该用什么, 那就默认选择 serial dispatch_queue_t, 异步串行高效稳定, 可以不用考虑使用什么类型锁而烦恼, 因为认知缺陷,不合理的使用锁, 随之产生的性能, 死锁等一系列难以排查的问题。


## 参考
[如何定位Obj-C野指针随机Crash(二)：让非必现Crash变成必现](https://cloud.tencent.com/developer/article/1070512?from=article.detail.1070505)
[Swift 中的锁和线程安全](https://swift.gg/2018/06/07/friday-qa-2015-02-06-locks-thread-safety-and-swift/)
