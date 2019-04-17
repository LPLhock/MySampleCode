#  CALayer 简介

## 概念

 CALayer  是数据 QuartzCore 框架里面的 、相对于 UIKit 框架 更于底层、   其主要功能是 负责显示视图和动画、CALayer和UIView 在除了不能响应事件上 功能外、  不过因为其 更加底层 所以 CALayer 有一些接口、 UIView 里面没有。 
 
## 动画
 
   有时候我们可以直接通过操作CALayer 去修改视图。但是要注意 隐式动画的发生,CAlayer有对应的 类方法 可以去把隐式动画关闭。
 ```[CATransaction setDisableActions:YES]; ```
   我们看到的动画 、实际上在运动的是 CALayer 在动,UIView 并没有参加。 
   因为CI层操作的是CA层. CGImageRef、CGColorRef两种数据类型是定义在CoreGraphics框架中的.
UIColor、UIImage是定义在UIKit框架中的。

- 什么是隐式动画？
当对非Root Layer的部分属性进行修改时，默认会自动产生一些动画效果
而这些属性称为Animatable Properties(可动画属性)
在CALayer.h中属性被Animatable修饰的就是会可动画的

## Framework

   QuartzCore框架和CoreGraphics框架是可以跨平台使用的，在iOS和Mac OS X上都能使用
Ø但是UIKit只能在iOS中使用
 • 为了保证可移植性，QuartzCore不能使用UIImage、UIColor，只能使用CGImageRef、CGColorRef
• 在iOS中，你能看得见摸得着的东西基本上都是UIView，比如一个按钮、一个文本标签、一个文本输入框、一个图标等等，这些都是UIView
 • 其实UIView之所以能显示在屏幕上，完全是因为它内部的一个图层
 • 在创建UIView对象时，UIView内部会自动创建一个图层(即CALayer对象)，通过UIView的layer属性可以访问这个层
 • 当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的图层上，绘图完毕后，系统会将图层拷贝到屏幕上，于是就完成了UIView的显示
 • 换句话说，UIView本身不具备显示的功能，是它内部的层才有显示功能 

   因为CALayer 是一种更轻量级别的 视图、所以如果不需要响应点击事件的时候 。可以直接使用其去显示即可以提升性能。
   
   ##  @property 简介
   
   ```
•宽度和高度
@property CGRect bounds;  

•位置(默认指中点，具体由anchorPoint决定)
@property CGPoint position; 

•锚点(x,y的范围都是0-1)，决定了position的含义
@property CGPoint anchorPoint; 

•背景颜色(CGColorRef类型)
@property CGColorRef backgroundColor; 

•形变属性
@property CATransform3D transform; 

•边框颜色(CGColorRef类型)
@property CGColorRef borderColor; 

•边框宽度
@property CGFloat borderWidth; 

•圆角半径
@property CGFloat cornerRadius; 

•内容(比如设置为图片CGImageRef)
@property(retain) id contents; 

•阴影颜色
@property CGColorRef shadowColor; 

•阴影不透明(0.0 ~ 1.0) 
@property float shadowOpacity; 

•阴影偏移位置
@property CGSize shadowOffset; 

•@property CGPoint position; 
```
用来设置CALayer在父层中的位置
以父层的左上角为原点(0, 0)
```
•@property CGPoint anchorPoint; ```
称为“定位点”、“锚点”
决定着CALayer身上的哪个点会在position属性所指的位置
以自己的左上角为原点(0, 0)
它的x、y取值范围都是0~1，默认值为（0.5, 0.5） 



## 参考

[Apple](https://developer.apple.com/reference/quartzcore/calayer CALayer)
[Animation](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html#//apple_ref/doc/uid/TP40004514-CH11-SW5)


