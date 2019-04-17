# iOS 使用 InjectionIII 注入动态库实现快速调试

## 前言

最近在看 "戴老师" 专栏推出的 "App 如何通过注入动态库的方式实现极速编译调试？
" 感触很深, 相信每个 iOS 的小伙伴在写代码的时候, 都存在这个烦恼, 每次修改个小功能, 都需要重新 Build 一次, 才能运行, 当项目功能不断积累到一定程度时, 编译时间可能超乎我们想象, 每次修改个 Color, text 等等, 都要经历一次漫长的等待。 
真羡慕写 前端 Flutter 的同事呀, code 一修改好, 不到 1S 就能很快的看到修改结果.
原来在 iOS 上早就有大佬推出了 注入动态库的方式来解决由于 OC 采用 "编译器" VS "链接器" 特性进行编译链接导致的 调试周期过长的问题。

## 使用 InjectionIII 解决项目编译时间过长

使用 InjectionIII 可以加快调试的速度, 并且可以保证程序不需要重启, 即可达到源码修改后的效果。 并且其代码是完全开源的 [InjectionIII](https://github.com/johnno1962/InjectionIII)。

其实现原理大家可以直接跳转到 "戴老师" 专栏去查看  [App 如何通过注入动态库的方式实现极速编译调试？](https://time.geekbang.org/column/article/87188) 讲的非常详细.

## 安装方式

* 方式一: 直接通过 github clone 项目下来, 运行。 如果遇到签名报错, 可直接到 Build Setting 将 Code Signing Identity 将签名取消掉。
* 方式二: 直接到 App Store 搜索 InjectionIII 下载 运行即可。

运行之后点击应用图标选择  Open Project, 并且选择我们要注入动态库的应用. 
然后在我们注入的项目中 "AppDelegate" 的 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 添加代码 
```
#if DEBUG
 // iOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
#endif

XCode10 是这个
#if DEBUG
 // iOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle"] load];
#endif

```

最后到我们需要监听的页面里面重写这个方法即可

OC:
```
- (void)injected {
    
    [self viewDidLoad];
    [self viewWillAppear:YES];
    [self viewWillDisappear:YES];
}
```
Swift 
```
extension UIViewController {
  @objc func injected() {
    viewDidLoad()
    viewWillAppear(true)
    viewDidAppear(true)
  }
}
```

## 参考

[App 如何通过注入动态库的方式实现极速编译调试？](https://time.geekbang.org/column/article/87188)
[InjectionIII](https://github.com/johnno1962/InjectionIII)

## 最后

>希望此篇文章对您有所帮助，如有不对的地方，希望大家能留言指出纠正。
>谢谢！！！！！
>学习的路上,与君共勉!!!    
>>本文原创作者:[Jersey](https://www.jianshu.com/u/9c6bbe968616). 欢迎转载，请注明出处和[本文链接](https://www.jianshu.com/p/730a0619c339)

