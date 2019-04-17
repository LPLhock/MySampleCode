# iOS 管理导航栏与TabBar

##背景

一般项目中都是使用一个 rootViewController 也就是 UITabBarController 管理相应的 TabBar item 下每个 ViewController. 并且每个 ViewController 可能会有 UINavigationController 作为其 rootViewController 来进行控制器的管理。 每个不同的页面可能会出现需要隐藏 navigationBar 或者 导航栏线以及 TabBar 的 BottomBar 等情况,  一般的做法是在相应的控制器 将要进入控制器与将要推出此控制器时, 添加相应的实现。但是觉得这样做起来太多重复的代码了, 也不太易于管理等。 所以想寻找更高效便捷的方法来实现。

## BaseNavigationController 与 BaseViewController

使用基类的设计模式来进行统一管理, 通过基类重写 **ViewWilleAppear:(BOOL)animated** 与 **- (void)viewWillDisappear:(BOOL)animated**, 然后在基类上添加一个 Bool 属性, 子类只需要再 **- (void)viewDidLoad** 设置一下这个属性即可.  这样即可完成统一的管理,  不需要每次在子类中单独写两次显示与隐藏的逻辑。

以及对 BaseNavigationController, 重写其 **- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated** 方法来添加相应公共逻辑。

## 续

利于弊.

## 

## Dome 

后续有时间补上。...

