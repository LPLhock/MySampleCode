# NSOperation

## 简介

其也是 Apple 为多线程提供的另一种解决技术, 主要是基于 GCD 进行的一个更上层的封装, 使其完全面向对象, 并且相对 GCD 也丰富了更多的特性, 比如 执行状态监听, 任务之间添加依赖关系等等。

## 相对 GCD 而言

由于其实通过 GCD 进行的封装, 所以 GCD 的概念上基本是没有太大的变化的, 只不过 NSOperation 不在像 GCD 一样使用 同步, 异步的方式来管理任务, 而是在 任务单出分离出来, 也就是我们常说的操作(Operation), 与 GCD 而言也就是 block 内的任务。  GCD 的队列的概念是继承了下来, 通过 NSOperationQueue 来表示,  其实 NSOperation 也有串行和并行的机制, 通过设置 队列的 **maxConcurrentOperationCount** 属性, 来执行串行与并行的操作。

所以总而言之,  GCD 的概念机制等都是得以保留了下来, 只是实现的是纯 OC 代码, 完全面向对象, 代码也更加的简洁易读,  同时 Apple 为 NSOperation 也添加了 GCD 难以实现的功能, 比如 操作之间的依赖关系, 对 操作的执行状态监听, 并且手动去控制, 更方便的去修改 操作的优先级等等。 

### 优点

	1.	可添加完成的代码块，在操作完成后执行。
	2.	添加操作之间的依赖关系，方便的控制执行顺序。
	3.	设定操作执行的优先级。
	4.	可以很方便的取消一个操作的执行。
	5.	使用 KVO 观察对操作执行状态的更改：isExecuteing、isFinished、isCancelled。
   作者：行走少年郎

## 参考 

[iOS 多线程：『NSOperation、NSOperationQueue』详尽总结](https://www.jianshu.com/p/4b1d77054b35)

