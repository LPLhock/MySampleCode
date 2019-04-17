#WKWebView使用及注意点(keng)

参考: [WKWebView使用及注意点(keng)] (https://www.jianshu.com/p/9513d101e582)

iOS8 之后, Apple 推出最新框架 WKWebView 用来替代性能不佳的 UIWebView。 其在内存占用上有了大大的提升优化。 并且控件 API 也相对 UIWebView 得到很大的提升。 建议如果不需要做 iOS8 之前的适配的话, 最好都更新成最新的 WKWebView 框架来进行 JS 交互。

![WKWebView](https://upload-images.jianshu.io/upload_images/1192353-3b1b2a629853d8b2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700)

##WKWebView使用

###WKWebView简单介绍

WKWebView 默认就支持右滑和返回手势, allowsBackForwardNavigationGestures 和加载进度estimatedProgress 等一些UIWebView不具备却非常好用的属性。 有三种创建方式一种是默认的配置, 一种通过 - (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration )configuration 传入相应配置参数。 有一个要注意的点 当我们使用默认配置时, 有一个属性 **allowsInlineMediaPlayback** 默认是 NO, 所以其不 允许在线支持视频播放。 要注意。

###更改User-Agent

两种方式: 一种是通过 evaluateJavaScript 在回调中 回去到默认的 User-Agent 然后进行全局修改. 类似 UIWebView 的修改方法. 都是有全局影响的.
第二种方法: WKWebView 提供了一个 customUserAgent 属性, 我们可以很方便的直接修改此 属性,来做局部的 修改.  其是 iOS9 推出的特性。

###WKWebView的相关的代理方法

WKWebView的相关的代理方法分别在WKNavigationDelegate和WKUIDelegate以及WKScriptMessageHandler这个与JavaScript交互相关的代理方法。

* WKNavigationDelegate: 此代理方法中除了原有的UIWebView的四个代理方法，还增加了其他的一些方法，具体可参考我下面给出的Demo。
* WKUIDelegate: 此代理方法在使用中最好实现，否则遇到网页alert的时候，如果此代理方法没有实现，则不会出现弹框提示。
* WKScriptMessageHandler: 此代理方法就是和JavaScript交互相关，具体介绍参考下面的专门讲解。

常用的有5个: 请求URL前(decidePolicyForNavigationAction), URL将要加载(didStartProvisionalNavigation), 收到服务器相应(decidePolicyForNavigationResponse), 获取网页内容(didCommitNavigation), 获取内容完成(didFinishNavigation),
其实还有: 网页发生重定向(didReceiveServerRedirectForProvisionalNavigation) 、 网页内容获取失败 两个。 一个是访问 URL 错误,一个是网页内容框架错误等.didFailNavigation(内容解析网络失败) 、 didFailProvisionalNavigation(url 错误)。

###WKWebView使用过程中的坑


