# 如何确保一个 View 准确拿到 Frame

## 纯代码布局

手动修改 frame 之后, 可直接获取到真实宽高等。

## Storyboard

View 在 ViewDidload 即可得到屏幕真实大小, 会随着不同屏幕变化

## Xib

View 得到的 Frame 是 Xib 真实大小, 不会随着屏幕不同而改变, 直到 - (void)viewDidLayoutSubviews 方法调用多次之后才会得到真正的大小。
super viewDidLayoutSubviews 方法内部会依次调用 subView 的 setNeedsLayout 方法来进行布局。 
## masonry

原理和  Xib 等一样, 其都是使用 Autolayout 来进行的约束, 所以刚刚设置完约束完之后并不会直接获取到真实布局, 其都是相对布局, 直到  - (void)viewDidLayoutSubviews 方法才会依次计算子控件真实位置。


## Tip
*  如果使用的约束布局, 则直接在进行完约束之后, 调用 [self.view layoutIfNeeded]; 强制刷新即可 拿到真实 Frame.
*  可以在 - (void)viewWillAppear:(BOOL)animated 或者 - (void)viewDidAppear:(BOOL)animated 进行调用, 这里也可以拿到真实 Frame
*  使用 StoreBorad 与 Xib 获取到真是Frame 不一致,  Xib 与使用纯代码 Autolayout 与 Masonry 原理一致, 分别到了 ViewWillLayoutSubViews 分别依次多次的调用子视图布局。 所以最终我们应该到 ViewWillAppear 中去读取。

## 推荐

[设置约束后 如何获取正确的frame](https://blog.csdn.net/allanGold/article/details/57083070)

[iOS开发笔记 | 由使用Masonry布局不能立即获取到frame想到的一些问题](https://www.jianshu.com/p/e71bcc7a569e)
[高级自动布局工具箱](https://www.objc.io/issues/3-views/advanced-auto-layout-toolbox/)

