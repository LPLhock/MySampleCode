# Material Design ViewController 深入了解 initializer

## 简介



## ViewController 常用 API

`parentViewController`
`modalViewController`
`presentedViewController`
`presentingViewController`

_https://developer.apple.com/documentation/uikit/uiviewcontroller/1621362-parentviewcontroller?language=objc_


## init 

`- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil` 
init  方法内部会自动调用 此方法。
`- (instancetype)initWithCoder:(NSCoder *)aDecoder;`
使用 Xib 进行初始化时, 会自动调用此方法。


_https://developer.apple.com/documentation/uikit/uiviewcontroller/1621403-initwithcoder?language=objc_

_https://zhaoxinyu.me/2017-07-16-iOS-initializers/_
_https://www.cnblogs.com/smileEvday/p/designated_initializer.html_


