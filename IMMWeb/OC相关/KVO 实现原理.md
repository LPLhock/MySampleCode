# KVC 和 KVO

## 简介

KVO 是 Key Value Observing  的缩写。
KVO 是 OC 对观察者模式的又一种实现。
Apple 使用了 isa 混写的技术来实现。 isa-Swizzling

![isa](https://img.mukewang.com/szimg/5ae44453000152cb19201080.jpg)

## 实现原理

当我们对 A 类进行 addObserver 时, 系统会在动态运行时,  生成一个 NSKVONotifying_A 类, 然后此类会对 set get 方法进行重写, 并且将原  A 类的 isa 指针, 执行新生成的这个类. 这样在调用 set  get 方法时即会自动调用系统新生成的这个类。 继而在其 set  get  方法中发送一个通知到我们添加观察的类里面。

在重写 set 方法中添加的实现

```
- (void)willChangeValueForKey:
- super setValue
- (void)didChangeValueForKey:
```
在重写 get 方法中添加的实现

```
- (void)willChangeValueForKey:
- super valuer
- (void)didChangeValueForKey:
```

## 问题

1. 通过 KVC 设置 Value 能否触发 KVO, 能
   
   因为通过 KVC 方法即自动调用了其重写的 set  方法。

2. 通过成员变量直接赋值是否触发, 不能,  如果我们需要手动实现 KVO 可以在其 赋值前后添加 那两个方法。




## KVC 简介

其是 Apple 提供的一种 键值编码技术,  Value forKey 与 setValue forKey 一种是读取 一种是设置,  其还会延伸至  Value ForPath 等, 路径访问。

## 与面向对象思想的冲突

1. 由于其可以通过 key 来访问, 修改类内部的私有成员, 所有是有与 面向对象思想冲突的。



## 系统实现

* Value forKey

* setValue forKey

1. 判断是否有当前 key 的 set 或 get 方法, 如果有则直接调用结束。
2. 如果没有则继续判断是否存在 _key _isKey 或 key  isKey 这四个成员变量, 如果有则直接取
3. 如果这两个都没有则则调用 setValue: forUndefinedKey  在抛出异常。
4. 


## 参考

[KVC 和 KVO](https://objccn.io/issue-7-3/)
[键值观察编程指南简介](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html)
[键值观察实现细节](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/Articles/KVOImplementation.html#//apple_ref/doc/uid/20002307-BAJEAIEE)
[KVO 实现原理](https://www.jianshu.com/p/829864680648)


