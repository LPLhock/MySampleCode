# iOS 响应收到内存警告处理

## 简介

关于 iOS 应用程序内存管理上, 也许大家都知道当 App 收到内存警告时, 系统会通过三个 API 来通知我们进行警告的处理, 分别通过这三个 API 我们可以进行内存释放, 将强引用的 视图 内存 等进行释放来减少, 应用程序占用内存, 避免 App 因占用内存过多而直接强制退出。

## 系统提供的 API

通过查文档定义, 看到分别通过这三个 API 来通知应用程序。

UIKit提供了几种接收低内存通知的方法，包括：
	•	实现applicationDidReceiveMemoryWarning:应用程序委托的方法。
	•	覆盖didReceiveMemoryWarning自定义UIViewController子类中的方法。
	•	注册接收UIApplicationDidReceiveMemoryWarningNotification通知。
	
## 解决方法 



## 参考

[响应iOS中的低内存警告](https://developer.apple.com/library/archive/documentation/Performance/Conceptual/ManagingMemory/Articles/MemoryAlloc.html#//apple_ref/doc/uid/20001881-SW1)


