# 圆角处理

## 简介

在项目中设计到圆角处理的控件可能会很多, layer 层提供了最简单的绘制属性, 一般对 layer的 cornerRadius + masksToBound 即可很快速的实现圆角。 但是如果使用 masksToBound 会产生离屏渲染, 严重时导致掉帧。

## 离屏渲染

* 在屏渲染:  指 GPU 在当前屏幕缓冲区内进行渲染工作
* 离屏渲染:  指 GPU 由于渲染工作量过大, 还需要额外开辟一个缓冲区在当前屏幕直之外工作。 

  当图层属性的混合体被指定为在未预合成之前不能直接在屏幕中绘制时，屏幕外渲染就被唤起了。屏幕外渲染并不意味着软件绘制，但是它意味着图层必须在被显示之前在一个屏幕外上下文中被渲染（不论CPU还是GPU）。图层的以下属性将会触发屏幕外绘制：

	•	圆角（当和maskToBounds一起使用时）
	•	图层蒙板
	•	阴影

## 解决方案

* 使用 UIBezierPath + Core Graphics 来绘制
* 使用 CAShapeLayer 和贝塞尔曲线UIBezierPath 画圆角图片

可以有效的避免离屏渲染

* 直接使用 YYImage 来封装好的方法来绘制。


## 参考

[](https://www.jianshu.com/p/60cd5f8bb4cb)
[](https://zsisme.gitbooks.io/ios-/content/chapter15/offscreen-rendering.html)


