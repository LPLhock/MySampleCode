# UI绘制原理&异步绘制


* [view.layer setNeedDisplay]

## UI绘制流程
* [UIView setNeedsDisplay]
  当调用此方式时, 并不会立即进行绘制, 系统会自动调用 layer 的 setNeedsDisplay 相当于打上一个标记, 等到了相应时机当前 runLoop 将要结束时, 系统会自动调用 CALayer 的 display,   调用此方法会自动  layer.delegate respondesTo@selector(displayer:) 如果我们实现了此方法,则会进入异步绘制流程, 如果不实现则自动实现系统绘制流程。
 ![绘制流程](https://img.mukewang.com/szimg/5ae1ce09000167cd19201080.jpg)

## 什么是系统绘制

![系统绘制](https://img.mukewang.com/szimg/5ae1ce9b0001ca5f19201080.jpg)
当进入系统绘制时, layer.delegate 是否存在的, 如果不存在则调用 CALayer DrawinContext 否则直接 layer.delegate drawLayer:inContext 在调用 UIView 的 DrawRect:  方法,  此时 CALayer 会把 backingStore 上传到 GPU.


## 什么是异步绘制

当 layer.delegate 实现了 displayLayer 方法, 则会自动进入异步绘制方法, 我们需要自己生成 backingStore,

流程大概如下:
Async 发出一个信号时, App 这边进入系统的绘制流程中, 此时 CALayer 调用 display 方法, 询问是否实现代理方法, displayer, 如果实现则进入异步绘制, 此时还在主线程中,然后我们可以切切换到一个全局队列中, 去进行异步的生成上下文, 主要通过 CGBitmap 等相关函数实现。

![异步绘制](https://img.mukewang.com/szimg/5ae1d59300011cd819201080.jpg)
## 我们可以利用异步绘制做什么

## 如何实现异步绘制

## 处理使用异步绘制, 还有什么方案可以提高流畅性

## 异步绘制需要注意什么

## 视图的第一帧, 有什么好的处理方案。



[UI绘制原理](https://leoliuyt.github.io/2018/05/26/UI%E7%BB%98%E5%88%B6%E5%8E%9F%E7%90%86/)
[](https://blog.csdn.net/yangyangzhang1990/article/details/52452707)

## 参考
[](http://sonnewilling.com/blog/2016/10/19/iostu-xing-yuan-li-yu-chi-ping-xuan-ran/)

[](https://zsisme.gitbooks.io/ios-/content/chapter15/offscreen-rendering.html)

[](http://vanney9.com/2017/03/24/something-about-iOS-drawing/)

[](http://zxfcumtcs.github.io/2015/03/21/CoreAnimation/)

