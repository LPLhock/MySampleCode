#iOS 性能优化篇.

主要参考：[UIKit性能调优实战讲解](https://bestswifter.com/uikitxing-neng-diao-you-shi-zhan-jiang-jie/)  

文章一四问： 
	1.	为什么要把控件尽量设置成不透明的，如果是透明的会有什么影响，如何检测这种影响？   答: 假如不设置成不透明的状态,  即其 Alpah 值不为1.  则有可能会出现图层混用的情况. 也就是会导致 GPU 要对混合图层进行计算 得出一个新的 RGBA 值, 这样相对来说占用了没有必要的性能开销。 特别是在滚动视图的情况下, 涉及到 FPS. 用户就能从肉眼视觉中感受出来卡顿.
	2.	为什么cell中的图片，尽可能要使用正确的大小、格式，如果错误会有什么影响，如何检测这种影响？
	3.	为什么设置阴影和圆角有可能影响滑动时流畅度？
	4.	shouldRasterize和离屏渲染的关系是什么，何时应该使用？

## 图层混用

由于多个视图层层叠在一起, 假如每一个层次都是不同的 RGB 背景颜色, 那么对于 GPU 来说也是有一定负载压力的, 以及对图层的 Alpha 值为不透明状态时, 也同样会造成影响,  所以如果当多个图层混合在一起的时候, 如果可以最好将不同图层的 background 和 alpha 值分别设置为 white　和　％100, 可以有效避免图层混用造成的性能瓶颈。

## 光栅化

光栅化是将一个 layer 预先渲染成位图(bitmap), 然后加入缓存中, 如果对于阴影 圆角等效果这种比较消耗资源的的静态资源内容进行缓存, 可以得到一定幅度的性能提升。
比如对于 label.layer.shouldRasterize = true;  
使用 debug-UIView-Color Hits Green and Misses Red, 它表示图层命中缓存显示为绿色,  红色则为未缓存直接渲染. 
三个相对重要的点：
1. 上下小幅度滑动时, 一直是绿色.直接读取缓存. 
2. 上下大幅度滑动时, 新出现的label 显示红色, 稍后变成绿色. 
3. 静止 1S 之后进行滑动, 刚开始滑动显示红色.  缓存时间导致！

由于缓存中的对象有效期仅为 100ms  0.1S, 之后自动销毁, 所以当静止 1S 之后, 在进行滑动时显示红色。 

由于缓存本身就是消耗时间的, 需要先写入后读取. 所以在针对不是特别复杂的视图的时候, 没有必要打开视图的光栅化。

还有严重的光栅化 容易导致离屏渲染, 我们需要注意。

## 颜色格式

Color Copied Images
Color Non-Standrad Surface formats
Color Imagediately

![wwdcImage](http://images.bestswifter.com/UIKitPerformance/pipeline.png)

![image](http://images.bestswifter.com/UIKitPerformance/commit.png)


## 图片大小

Color Misaligned Images 它表示如果图片需要缩放则标记为黄色，如果没有像素对齐则标记为紫色。
当 ImageView 的大小小于或则大于原 Image　则在进行展示的时候会出现缩量或者拉伸的状况.  会占用一定的性能。

我们需要保证在读取写入图片对 Image 的时候保持尺寸大小与其要一致, 避免系统压缩图片占用时间,影响性能. 


特别是在列表里面展示的图片, 如果所展示图片像素大小与控件 Frame 大小不一致, 然后通过压缩的方式展示出来,这样也会一定程度增加系统运算负担,影响性能。

## 离屏渲染

离屏渲染主要是因为 GPU 遇到复杂的图形, 不能直接按照正常的渲染通道完成图像的绘制,比如对于一个设置阴影的图像,一般 GPU 会分成三步去渲染, 分别拿到两分图像纹理,但是这两个渲染结果并不能直接放到渲染通道的最后一步 Render Buffer中,要等到第三次 渲染通道,将这两组纹理组合起来之后才能放到 Render Buffer 里面,相比起正常的图形渲染来说,增加了很多性能消耗,严重时会导致卡顿.

实际是我们使用 layer 层来画圆角, 并不会直接产生离屏渲染, 主要原因是因为调用了, maskToBounds 导致.解决的方案是尽量避免设置圆角, 如果一定要设置的话, 我们可以通过底层绘图的方法来实现, 还可以通过光栏化将图片缓存起来。
```
// 设置圆角
label.layer.masksToBounds = true  
label.layer.cornerRadius = 8  
label.layer.shouldRasterize = true  
label.layer.rasterizationScale = layer.contentsScale 
```


Color Offscreen-Rendered Yellow
以下情况可能会导致触发离屏渲染：
	1.	重写drawRect方法
	2.	有mask或者是阴影(layer.masksToBounds, layer.shadow*)，模糊效果也是一种mask
	3.	layer.shouldRasterize = true

## 快速路径

“Color Compositing Fast-Path Blue”用于标记由硬件绘制的路径，蓝色越多越好。

## 变化区域

“Flash updated Regions”用于标记发生重绘的区域。一个典型的例子是系统的时钟应用，绝大多数时候只有显示秒针的区域需要重绘：


#总结

**避免图层混用**

1. 将图层 opaque 属性设置为 true。 确保父视图与子视图  backgroundColor 一致。 
2. 尽量将 alpha 值设置成 %100。
3. 确保 image 没有 alpha 通道.

**避免临时转换**

1. 确保图片大小与 存放图片View frame 保持一致。不要在滑动的时候缩放图片。
2. 确保颜色格式被 GPU 支持, 避免 CPU 去进行转换工作.  

**慎用离屏渲染**

1. 绝大多数重写 drawRect 都会触发离屏渲染, 如果不是非常复杂的视图, 尽量不要使用. 
2. 设置圆角、阴影、模糊效果，光栅化都会导致离屏渲染。
3. 设置阴影效果是加上阴影路径。
4. 滑动时若需要圆角效果，开启光栅化。
5. 发生离屏渲染的时候, 一定要进行位图缓存。这样在下一次读取的时候将相对更加快速。


## 
	绘制像素到屏幕上，原文：[Getting Pixels onto the Screen](https://www.objc.io/issues/3-views/)
	2.	[Advanced Graphics and Animations for iOS Apps](https://developer.apple.com/videos/play/wwdc2014-419/)：这是2014年WWDC Session 419，强烈建议看一遍。
	3.	[如何正确地写好一个界面](http://oncenote.com/2015/12/08/How-to-build-UI/)
	4.	[Mastering UIKit Performance](https://yalantis.com/blog/mastering-uikit-performance/)














