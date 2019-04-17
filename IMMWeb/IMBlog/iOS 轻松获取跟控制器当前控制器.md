# iOS 获取根控制器当前控制器.

##背景

在开发过程中,经常需要获取当前 window, rootViewController, 以及当前 ViewController 的需求. 如果 .m 实现不是在当前视图情况下, 我们需要快速的获取到当前控制器, 这种情况就需要先做好一层封装,我一般是通过 UIViewController 写的一个 Category 来实现, 实现起来也非常简单, 只需要我们对 控制器几个方法掌握便可。

##获取根控制器

```
+ (UIViewController *)jsd_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}
```

这里很简单, 通过单例获取到当前 UIApplication 的 delegate 在通过  window 即可轻松拿到 rootViewController。

##获取当前页面控制器

```
+ (UIViewController *)jsd_getCurrentViewController{
    
    UIViewController* currentViewController = [self jsd_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
          UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
          UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}
```
这里讲一下实现思路, 我们想要与控制器无耦合的情况下, 想要直接获取到当前控制器, 基本都是通过 **rootViewController** 来查找的, 通过上面的方法拿到 **rootViewControoler** 之后, 我们先看 **presentedViewController**, 因为控制器呈现出来的方式有 push 与 present, 我们先查看它是否是 present 出来的, 如果是则通过此属性能找到 present 出来的当前控制器, 然后在检查是否属于 **UINavigationControler** 或 **UITabBarController** ,如果是则通过查找其子控制器里面最顶层或者其正在选择的控制器。
最后在判断当前控制器是否有子控制器的情况, 如果有则取其子控制器最顶层, 否则当前控制器就是其本身。

这里主要是查找当前 应用程序基于 UITabBarController 和 UINavigationControler 下管理的视图控制器, 如果还有其他控制器则需要添加 if 条件来进行判断。

##presentedViewController

[Apple 文档 presentedViewControlle](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621407-presentedviewcontroller?language=objc)

通过此方法可以查找到通过 presented 模态方式(显示与隐士) 方式推出的当前控制器。
例如:  AViewController --> BViewController 通过模态方式推出.
则使用 AViewController.presentedViewController 能获取到 BViewController。

## presentingViewController

[Apple 文档 ](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621430-presentingviewcontroller?language=objc)

通过此方法可以查找到通过 presented 模态方式(显示与隐士) 方式推出当前控制器的上层控制器。
例如:  AViewController --> BViewController 通过模态方式推出.
则使用 BViewController.presentingViewController 能获取到 AViewController。

## modalViewController 

查看文档发现此方法已在 iOS 6 后被弃用, 官方推荐直接使用 presentedViewController 替代即可.

## 参考资料与Dome

[UIViewController的presentedViewController，presentingViewController和parentViewController三个属性](https://blog.csdn.net/u011623532/article/details/47145933)
Dome: [轻松获取当前控制器](https://github.com/ZexiFangkong/MySampleCode/tree/master/JSDUIViewContorllerTool)


