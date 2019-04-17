# UIWindow 详解, makeKeyAndVisible、makeKeyWindow、becomeKeyWindow、resignKeyWindow.你真的懂了吗？


<!-- TOC -->

- [UIWindow 简介](#uiwindow-简介)
    - [UIWindow 概述](#uiwindow-概述)
    - [我们可以使用 UIWindow 来作什么？](#我们可以使用-uiwindow-来作什么)
    - [makeKeyAndVisible 与 makeKeyWindow](#makekeyandvisible-与-makekeywindow)
    - [becomeKeyWindow 与 resignKeyWindow](#becomekeywindow-与-resignkeywindow)
    - [希望此篇文章对您有所帮助，如有不对的地方，希望大家能留言指出纠正。谢谢！！！！！](#希望此篇文章对您有所帮助如有不对的地方希望大家能留言指出纠正谢谢)
    - [学习的路上, 与君共勉!!!](#学习的路上-与君共勉)

<!-- /TOC -->
## UIWindow 简介

**UIWindow** 
> 是 UIView 的子类,其在 UIView 添加了一些视图层级,管理视图,转发 UIEvent 对象的属性和 Method。 
其官方定义是这样的: *The backdrop for your app’s user interface and the object that dispatches events to your views.*

> 大意就是: 其是应用程序界面的背景,和将事情分配到视图的对象。

* 程序背景:因为 UIWindow 是应用程序视图层级最顶层的视图, 一般使用一个 rootViewController 管
* 理着视图. 其还有一项很艰巨的任务, 就是手势,点击等需要传递到最佳响应 subView 的事件, 都是通过 Applicatin -> UIWindow -> subView 分配到真正响应此事件的子视图。

## UIWindow 概述

 **Apple 文档定义:**
 > Windows work with your view controllers to handle events and to perform many other tasks that are fundamental to your app’s operation. UIKit handles most window-related interactions, working with other objects as needed to implement many app behaviors.

**大致理解:**  
> UIWindow 与 控制器一起工作, 基本都是设置一个 rootViewController, 来配置一个根控制器, 它能处理大多数响应事件并基本能执行应用程序里面至关重要的任务。监听键盘通知,处理应用程序里面的手势,点击等交互相关事件。 UIKit处理大多数与窗口相关的交互，根据需要与其他对象一起工作以实现许多应用程序行为。这是后面一段话的翻译,没太理解清楚,以免误人子弟,就暂时不写了,理解能力强的指点一下。

通常在一个应用中,只有一个 UIWindow 管理着整个应用程序界面,一般我们通过 Xib 或者 StoreBorad 创建项目时, 都会在 Custom Class 里面的 Class 选项填写上相应的控制器, 这样系统就会自动帮我们制定其为 UIWindow 的根控制器。 否则我们通过纯代码的方式加载的话,都需要手动赋值一个 rooViewController。

## 我们可以使用 UIWindow 来作什么？

除了上面介绍的使用 UIWindow 来管理视图, 相应应用程序事件外, 系统还为我们推荐了几种使用方法。

1. 通过设置 不同窗口的属性 **windowLevel(默认值是 0,值越高就展示在越前面)** 来实现覆盖. 切换窗口等。
2. 显示window并使其成为键盘事件的目标。
3. 将坐标值转换为window坐标系。
4. 更改当前窗口根控制器。
5. 更改窗口所显示的屏幕。

上面说的几点,可能一下子想象不到具体应用场景,我这里收集了一下分别列举一下: 

* 比如系统弹框, 手势密码, UIAlertView, 电量不足弹框, 等系统级别的弹框, 系统会创建一个 UIWindow 然后通过设置其 windowLevel, 在调用 makeKeyWindow 或 makeKeyAndVisible, 都可以起到直接展示到当前窗口, 为应用程序主窗口的效果。  我们可以 打开 可视化界面 Debug View Hierarchy 观看视图层级 、  我们可以发现 系统创建了 一个 UITextEffectsWindow 、
* 我们有时候需要跟换 rootViewController, 可以直接通过其 set 方面来进行更换实现。
* 有时候我们需要监听键盘状态, 可以通过 UIWindow 里面的通知常量来进行监听、以便做出相应执行。 

## makeKeyAndVisible 与 makeKeyWindow

**makeKeyAndVisible** : 显示当前窗口,用于显示当前窗口并将其放置在同一级别或更低级别的所有其他窗口的前面。如果只想显示的话,我们还可以通过设置其属性hidden为 NO 即可。 
其做了两件事使当前窗口显示出来,并使其成为主要窗口,即可相应应用程序相关事件。
**makeKeyWindow**: 只做了一件事使当前窗口成为主要窗口。 并不负责将其显示出来。 即时其 windowLevel 值在高都一样。 

## becomeKeyWindow 与 resignKeyWindow

**becomeKeyWindow:** 自动调用以通知窗口它已成为关键窗口。  我们不要主动调用此方法, 此方法是系统自动调用的来发通知的.让窗口知道它何时成为主要窗口。此方法的默认实现不执行任何操作，但子类可以覆盖它并使用它来执行与成为关键窗口相关的任务。

**resignKeyWindow:** 类似becomeKeyWindow, 其是调用以通知窗口它将要注销掉关键窗口的身份. 
同样的切勿直接调用此方法。系统调用此方法并发布帖子，让窗口知道它何时不再是键。此方法的默认实现不执行任何操作，但子类可以覆盖它并使用它来执行与重新签名关键窗口状态相关的任务。

参考资料: [官方文档UIWindow](https://developer.apple.com/documentation/uikit/uiwindow?language=objc)

##希望此篇文章对您有所帮助，如有不对的地方，希望大家能留言指出纠正。谢谢！！！！！
##学习的路上, 与君共勉!!!










 



