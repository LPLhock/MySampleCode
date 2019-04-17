# UIView 和 CALayer

[toc]

## 本质区别

* UIView 负责提供显示的内容, 以及负责响应 触摸等交互事件, 参与响应链传递触发。
* CALayer 负责实际显示内容 Contents。
* UIView主要是对显示内容的管理而 CALayer 主要侧重显示内容的绘制。
* 在做 iOS 动画的时候，修改非 RootLayer的属性（譬如位置、背景色等）会默认产生隐式动画，而修改UIView则不会。

## Apple 为什么会这样设计

* 猜想

1. 第一反应想到的是单一职责的设计原则, 显示的内容全部交给 CALayer, 响应等功能放在 UIView 上.

之前介绍UIView时我们知道，UIView有层级关系，同样，CALayer也有层级关系：
	1.	layer也可以通过addSublayer添加子层；
	2.	layer层级会继承view的层级关系。这是什么意思呢，就是如果有个视图层级关系viewA包含viewB，那么同样，在关联图层中也会有这样的层级关系，layerA包含layerB。
为什么iOS要基于 UIView 和 CALayer 提供两个平行的层级关系呢？为什么不用一个简单的层级来处理所有事情呢？
原因在于要做职责分离，这样也能避免很多重复代码。在iOS和Mac OS两个平台上，事件和用户交互有很多地方的不同， 基于多点触控的用户界面和基于鼠标键盘有着本质的区别，这就是为什么iOS有 UIKit和 UIView ，但是Mac OS有AppKit和 NSView 的原因。他们功能上很相似，但是在实现上有着显著的区别。
绘图，布局和动画，相比之下就是类似Mac笔记本和桌面系列一样应用于iPhone 和iPad触屏的概念。把这种功能的逻辑分开并应用到独立的Core Animation框架， 苹果就能够在iOS和Mac OS之间共享代码，使得对苹果自己的OS开发团队和第三方开发者去开发两个平台的应用更加便捷。
实际上，这里并不是两个层级关系，而是四个，每一个都扮演不同的角色，除了 视图层级和图层树之外，还存在呈现树和渲染树.(后面介绍动画时会有提到这个)


## 参考

[《爽爆天移动开发之 - iOS开发大全》 -- CALayer基础](https://luochenxun.com/ios-calayer-overview/)

