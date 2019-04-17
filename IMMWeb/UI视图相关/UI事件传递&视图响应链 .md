# UI事件传递&视图响应链

## 事件传递流程

点击屏幕 -> UIApplication -> UIWindow -> hitTest:withEvent: -> pointInside:withEvent: -> subViews -> subViews(依次取出子视图 倒序遍历) -> hit -> view != nil -> 结束 

## 事件传递原理

* ``- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent* )event;`` 
* ``- (BOOL)pointInside(CGPoint)point withEvent:(UIEvent* )event;``

两个方法实现原理: 
hitTest:
首先判断当前 View.hidden && view.userInteractionEnabled && view.alpha > 0.01, 如果得到 Yes -> point -> 循环遍历当前 View 的子视图, 调用 hitTest 直到找到相应的 View, 如果循环结束最终没有找到则直接返回 顶层 View.
 
## 视图响应原理

首先由事件传递链, 找到最佳响应此事件的视图。
假如说最佳响应的视图不处理此事件, 则在从当前视图由下往上逐级找到 UIApplication -> UIApplicationDelegate。 直到最后如果没有一个视图来响应此事件也不会发生任何异常。

## 视图响应原理

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

## 如何扩大视图点击范围

根据事件传递流程, 我们了解到其查找最佳响应视图的原理,从而我们可以通过重写其  hitTest 方法来扩大视图自身的点击范围。 实现一些特殊的需求。

## 如果视图响应找不到接收者, 如发生什么

无任何异常, 并不会产生 Crash 等。

## RunLoop 与 相应关系


Public


