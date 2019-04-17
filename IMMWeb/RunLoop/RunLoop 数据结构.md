# RunLoop 数据结构

 NSRunLoop 是对 CFRunLoop 的封装, 提供了面向对象的 API.
 
 CF 开头的都是通过 C 语言进行编写, 位于 CoreFoundation 框架下, 代码都是开源的。
## CFRunLoop

包含 pthread, currentMode, model, commonModels,commonModeLtems

![CFRunLoop](https://img.mukewang.com/szimg/5afa7a4a0001ceca19201080.jpg)
 
## CFRunLoopMode

![RunLoopMode](https://img.mukewang.com/szimg/5afab8710001698e19201080.jpg)

* Source0  需要手动唤醒线程, 
* Source1  具备唤醒线程的能力,

## Source/Timer/Observer


![Source](https://img.mukewang.com/szimg/5afab9d50001318a19201080.jpg)
![Timer](https://img.mukewang.com/szimg/5afaba630001ee2e19201080.jpg)
![Observer](https://img.mukewang.com/szimg/5afb8f320001234a19201080.jpg)
![](https://img.mukewang.com/szimg/5afb97a6000136e219201080.jpg)
* kCFRunLoopBeforeWaiting  将要休眠, 用户态将要切换到内核态
* kCFRunLoopAfterWaiting   刚刚从用户态切换到内核态时间不久。
* kCFRunLoopExit           已经退出

* Timer
* Observer 

## 各个数据结构之间的关系

![](https://img.mukewang.com/szimg/5afb97e00001140e19201080.jpg)


## CommonMode 的特殊性

其并不是一种真正存在的 Mode。 但是其又与 
* 其是同步到 Source/timer/Observer 到多个 Mode 的一种技术方案。


## 事件循环的实现机制

![循环机制](https://img.mukewang.com/szimg/5afbaeb80001029f19201080.jpg)

1. RunLoop 将要进入时, 首先发一个通知给 Observer。 2. 将要处理 Timer/Source0 事件 3.处理 source0 , 4. 如果有 要处理的 Source1 事件, 5. 线程将要休眠. 6. 休眠, 等待唤醒。 -> (@1. Timer 事件, @2 Source1 事件, @3 外部手动唤醒) 7. 线程被唤醒 8. 处理唤醒时收到的消息。
## RunLoop 核心

![Kernel](https://img.mukewang.com/szimg/5afbb6450001384319201080.jpg)

## RunLoop 与 NSTimer

![Mode 切换](https://img.mukewang.com/szimg/5afbbbad000110b819201080.jpg)

通过 CFRunLoopAddTimer 函数 将当前 RunLoop 与 Timer 添加到 commondMode 上面

## RunLoop 与 多线程

通过源码分析,  RunLoop 内部结构里面都会包含一个 thread.
所以 RunLoop 是与线程一一对应的。

* 常驻线程 
  我们可以为当前线程开启一个 RunLoop, 为该 RunLoop 中添加一个 Port/Source 等维护 事件循环的事件。
  启动该 RunLoop
  
  *     [NSRunLoop currentRunLoop]; CFRunLoopGetCurrent();  
    通过这两个方法都可以获取到当前 线程的一个 RunLoop, 内部实现会自动判断当前线程是否有, 如果没有则会自动创建一个 
   

 

