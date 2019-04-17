# UIWindow、makeKeyAndVisible makeKeyWindow 你真的搞懂了吗？




2018-03-27 17:09:16.565 WarmCafe[15221:4641841] Warning: Attempt to present <UIViewController: 0x7ff5e6c0d3e0> on <JSCLaunchVC: 0x7ff5e6c080f0> whose view is not in the window hierarchy!

Attempt to present ViewController whose view is not in the windows hierarchy


大致 、 此视图不处于Window的窗口。 

代码逻辑如下、

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; 
    JSCLaunchVC* launchVC = [[JSCLaunchVC alloc] init];
    self.window.rootViewController = launchVC; 
    [self.window makeKeyAndVisible];

然后 在 JSCLaunchVC 里的
- (void)viewDidLoad {
     
   [self presentViewController:vc animated: Yes completion:nil];

}

可以切换 但是出现警告。

然后我将 代码移动到 ViewDidApper 里面 执行即可。。。

原因如下。

https://stackoverflow.com/questions/40304405/attempt-to-present-viewcontroller-whose-view-is-not-in-the-windows-hierarchy/49509025#49509025


Xcode error significance for roughly: this view is not in the Window of the view hierarchy. 

What I don't think the above answer questions, but maybe you might have wondered why this would happen. 

But I find that you are the reasons for this problem is likely to be in the ViewController life cycle at ViewDidLoading switch view Code execution inside. 

Reason is probably that, when the ViewController implementation allco init during initialization, it will be executed asynchronously viewWillLoad - > viewDidLoad... -- -- -- -- > viewDidApper. Then may be in code execution to the viewDidLoad. The ViewController may not assign values to the Window. The rootViewController. So we directly use [self presentViewController:] will appear this error. 

It is recommended that you move the code of the switch to ViewDidApper. 

Another possibility is that the current view is not the rootViewController for Windows. At this point, we get the rootViewController from the current Window through the simple method. 

I hope it will help you. 





简介： UIWindow  是UIView 子类、    相对 UIView 多了  设置 层级属性、  以及 管理视图 等功能 。     比较常用的 方法有 
- (void)becomeKeyWindow;                               // override point for subclass. Do not call directly 
- (void)resignKeyWindow;                               // override point for subclass. Do not call directly 

- (void)makeKeyWindow;
- (void)makeKeyAndVisible;  
@property(nonatomic,strong) UIScreen *screen NS_AVAILABLE_IOS(3_2);  // default is [UIScreen mainScreen]. changing the screen may be an expensive operation and should not be done in performance-sensitive code 

@property(nonatomic) UIWindowLevel windowLevel;                   // default = 0.0 

 其中  UIWindowLevel 是一个枚举、 系统定义有 3种 
UIKIT_EXTERN const UIWindowLevel UIWindowLevelNormal; 
UIKIT_EXTERN const UIWindowLevel UIWindowLevelAlert; 
UIKIT_EXTERN const UIWindowLevel UIWindowLevelStatusBar __TVOS_PROHIBITED;    
其对应 的值 分别为 0  1000 2000 、 
当值越高表示其位置越高层。   默认创建的是 UIWindowLevelNormal   == 0
- (void)makeKeyWindow;
- (void)makeKeyAndVisible
这两个方法的区别在于、 第一个 方法是 直接展示 在界面上 、 
第二个是做个系统的使用窗口。 一般在使用代码初始化在 UIAppdelegate的 应用加载完成方法中 使用到 。   
调用此方法之后、 此Window 将作为 应用程序 主窗口绑定 、展示在界面上 。
一般一个应用程序只有一个UIWindow 除非特殊情况、 如系统弹框、 人为密码锁。消息推送框等。 

12.2  为UIWindow 增加 UIView 
 由于UIWindow是应用的主窗口、  其不仅可以管理视图、 还可以设置一个 rootViewController. 并且设置成root之后、窗口会自动管理当前控制器的View。 相当于该窗口引用了 此控制器、 
方法二：因为UIWindow是 UIView子类 所以也可以使用 addSubView 的方法添加进来也可以。

12.3 系统对 UIWindow 的使用
 最常见的系统对其使用就是、我们调用系统的UIAlertView 进行弹框的时候、 此时 我们可以 打开 可视化界面 Debug View Hierarchy 观看视图层级 、  我们可以发现 系统创建了 一个 UITextEffectsWindow 、

正常只有一个UIWindow主 窗口 、  系统在弹框的时候 创建了一个 与其同层级、 覆盖在其上面。    由于我们创建的 UIWindow 的 UIWindowLevel 初始值为0 、 其使用的是UIWindowLevelAlert 、 所以能覆盖在其上面 。 这样就能有效的遮盖主当前界面。  

还有电池电量不足、 收到来电或短信等也是应用此原理！！！！


12.3.1 WindowLevel
默认有三个枚举值、 typedef CGFloat UIWindowLevel;

UIKIT_EXTERN const UIWindowLevel UIWindowLevelNormal; 
UIKIT_EXTERN const UIWindowLevel UIWindowLevelAlert; 
UIKIT_EXTERN const UIWindowLevel UIWindowLevelStatusBar __TVOS_PROHIBITED; 
 
其值的越大 、  层级就会越高 、  不过我们不能滥用此属性。导致混乱。



12.3.2 手工创建UIWindow
通过系统对UIWindow的 应用、我们可以借助这个原理来使用、 我们可以使用 创建一个 UIWindow然后设置 其 UIWindowLevel 值更高 。使其遮住当前页面。  来实现我们要临时展示的东西 、  列入 屏锁、 弹框。 推送消息等等 。 
但是在创建 UIWindow时 要谨慎 使用 不能滥用其 导致 后期维护困难。
 创建的 UIWindow 直接调用 其 [self makeKeyWindow] 
方法即可 。
 隐藏则 调用  [self resignKeyWindow]
或者 我们也可以通过  [UIApplication sharedApplication].delegate.window  取到我们的 根window 。 
然后直接在上面进行一个展示。 也可以起到 同样的效果 。 

我们可以单独创建一个UIWindow 子类或者分类来进行 扩展、 
比如我们有个需求是、当用户在启动应用程序时，点击Home间 、 然后回到应用时候、要输入一次密码。 
我们可以在 UIAppdelegate 里面的 
  
-(void)applicationDidBecomeAction:(UIApplication *)applecation 
{
   //  初始化。我们的页面 、 进行展示 。 
  // 即可简单的实现。
}

Test 、 
如果我们创建的主 Window 、  然后去设置 其  UIWindowLevel 值 。 设置成 100 。
然后我们想在展示一个覆盖 此Window 的 UIWindow。 但是没有去设置其 值 。 
 这样我们临时创建的 UIWindowLevel 为0 。 
当我们调用 [self makeKeyWindow]时 。  其并不能把主Window 覆盖掉 。 因为其水平度  低于 主 。 









