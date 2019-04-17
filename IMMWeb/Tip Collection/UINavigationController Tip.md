# UINavigationController Tip

## 修改导航栏字体.  必须要自定义的才可以直接通过此方法修改.
```
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(backPreviousPage)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal]; 
    
修改此处只会与这个页面下的导航按钮相关, 并不会影响到其他页面.
```
##  @property(nonatomic,assign,getter=isTranslucent) BOOL translucent  导航栏透明属性
```
5. navgationController.navigationBar.translucent = NO;    NS_AVAILABLE_IOS(3_0) UI_APPEARANCE_SELECTOR; // Default is NO on iOS 6 and earlier. Always YES if barStyle is set to UIBarStyleBlackTranslucent 
其透明会导致严重的离屏渲染.
透明时, View 的 Frame 不会受其影响 下移 64 像素, 如果不透明时 View 会自动下移 64像素.  
 ```

## self.navigationBar.backgroundColor 

修改这个属性后其会被 imageView 遮挡住, 所有直接设置这个没有用。```
[self.navigationBar setBarTintColor:[UIColor yzh_backgroundDarkBlue]]; // 全局设置 对其他控制器想特殊修改需要调用此方法进行修改.
```
或者
```
 [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_backgroungImage"] forBarMetrics:UIBarMetricsDefault]; 进行修改. 
```
设置了 tintColor 之后直接在导航控制器里设置背景图, 无效. 到了子控制里面设置则可以把 tintColor 挡住。

![i3BAr6.png](https://s1.ax1x.com/2018/10/03/i3BAr6.png)
![i3BEqK.png](https://s1.ax1x.com/2018/10/03/i3BEqK.png)

## 状态栏字体风格 颜色
```
- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}
通过此方法设置即可.
```
默认风格是黑色, 另一种则为 白色, 其他的在 iOS 7 弃用。
info.plist 
key View controller-based status bar appearance    则表示可以通过控制器重写此方法来修改 TODO



