#WebView 与 JS 交互

 参考: [WebView与JS的几种交互](https://www.jianshu.com/p/0042d8eb67c0)
 
 分总分类: 协议拦截、JavaScriptCore 库、WKWebView、 自定义 NSURLProtocol 拦截、 WebViewJavascriptBridge、

## JavaScriptCore 库

其是 iOS7 引进的标准库.
Class and Protocol

* JSContext: 提供一个 JavaScript 上下文运行环境, 通过 -evaluateScript: 执行
* JSValue:
* JSManagedValue:
* JSVirtualMachine:
* JSExport:
* 对于JSContext和JSValue的更多使用方式可以看下这篇，介绍的比较完整[ios7 JavaScriptCore.framework](https://link.jianshu.com/?t=http://justsee.iteye.com/blog/2036713) 本文主要简单总结下交互相关内容。

## OC Call JS

涉及 Class JSContext 与 JSValue、 
涉及 Method: - (JSValue *)evaluateScript:(NSString *)script; 
				  - (JSValue *)callWithArguments:(NSArray *)arguments;
				  
都是会返回 JSValue 用于保存 JS 数据、

方法一:
一般直接 使用 JSContext  Call  evaluateScript 方法 参数传 JS Function , 得到一段 JS 方法、 然后可以直接通过 JSContext 通过 Function Name 作为 Key 取到这段 JS 方法, 在通过		callWithArguments　调用即可、

方法二:

直接通过 evaluateScript 执行, 首先为 JSContext 添加 Function。 然后继续通过 evaluateScript 添加 Function Name 即可直接调用. 

## JS Call OC

两种方式, 一种是通过 Block 另一种是通过 注入模型使用协议代理。

###Block: 通过 JSContext[@“funcName”] = ^(){};
      定义一段回调Block.  相当于在移动端 添加一个方法, 到上下文中, 供 Web 端直接调用.
      然后 Web 端 调用 funcName 移动端这边即自动调用此方法. 

###注入模型使用协议代理: 通过创建一个 @Protocol 然后必须遵守 JSExport 定义相应方法, 继而在移动端遵守此协议, 实现 Method.  Web 端调用同名方法即可。

疑问: 在移动端通过  JSContext 无法直接调用. 不知道少了哪一步, 文中未说明完整、

##JavaScriptCore使用注意

使用 WKWebView 在代理方法中获取 JSContext 崩溃. 
```
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSLog(@"获取网页内容完成%s",__func__);
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    2018-06-27 16:11:55.065763+0800 JSDWebView[30896:1387307] *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<WKWebView 0x7ff6d4866a00> valueForUndefinedKey:]: this class is not key value coding-compliant for the key documentView.'
*** First throw call stack:
```
在写 JS 调用 OC 方法中要确保方法在主线程中运行, 否则会引起闪退。 详见[JS Call OC](http://blog.csdn.net/quanqinyang/article/details/49516593)

[iOS与JS交互实战篇（ObjC）](https://link.jianshu.com/?t=http://mp.weixin.qq.com/s?__biz=MzIzMzA4NjA5Mw==&mid=214063688&idx=1&sn=903258ec2d3ae431b4d9ee55cb59ed89#rd)
[Objective-C与JavaScript交互的那些事](https://www.jianshu.com/p/f896d73c670a?utm_campaign=hugo&utm_medium=reader_share&utm_content=note&utm_source=weibo)      
	 	  
	 ## WebViewJavascriptBridge
	 
	 一个比较有名的 iOS 与 JS 交互的 三方库, 安卓也有一个同名的三方库, 最好统一使用, 否则 Web 需要写两套, 其主要原理是通过 拦截 WebView 请求方法, 做了完整的封装。
###初始化	 

self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
// 开启日志，方便调试
[WebViewJavascriptBridge enableLogging];

### Web端setupWebViewJavascriptBridge
```
function setupWebViewJavascriptBridge(callback) {
if (window.WebViewJavascriptBridge) { 
return callback(WebViewJavascriptBridge); 
}
if (window.WVJBCallbacks) { 
return window.WVJBCallbacks.push(callback); 
}
window.WVJBCallbacks = [callback];
var WVJBIframe = document.createElement('iframe');
WVJBIframe.style.display = 'none';
WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
document.documentElement.appendChild(WVJBIframe);
setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
}
```

###call setupWebViewJavascriptBridge
```
setupWebViewJavascriptBridge(function(bridge) { 
/* Initialize your app here */
 bridge.registerHandler('JS Echo', function(data, responseCallback{ 
 console.log("JS Echo called with:", data) responseCallback(data) }) bridge.callHandler('ObjC Echo', function responseCallback(responseData) { console.log("JS received response:", responseData) }) })

```

###ObjC API

OC 端通过 WebViewJavascriptBridge 初始化并定义 native 端的默认消息处理器。
优点: 两端各定义一次, 即可通过 bridge send() 触发默认定义 Function.

###OC 端 registerHandler 接收JS调用

通过 bridge registerHandler 完成类似 使用 JSContext block 添加 OC 回调的方式.
然后 JS 通过bridge.callHandler('Function') 即可调用相应 方法.

### OC端callHandler调用JS

同理, 也是 类似 JSContext evaluateScript 之后, OC 直接调用 JS 方法》
function: callHandler
[self.bridge callHandler:@"showAlert" data:@"Hi from ObjC to JS!"];

调用JS getCurrentPageUrl，在block中获取参数
[self.bridge callHandler:@"getCurrentPageUrl" data:nil responseCallback:^(id responseData) { NSLog(@"Current UIWebView page URL is: %@", responseData); }];

###还可设置代理监听

[bridge setWebViewDelegate:(UIWebViewDelegate*)webViewDelegate];


###Javascript API

同理使用到两个函数是 registerHandler 和 callHandler 。


## WKWebView - iOS8 or Later

iOS8，苹果新推出了WebKit，用WKWebView代替UIWebView和WebView。相关的使用和特性可以细读。
[WKWeb View](https://link.jianshu.com/?t=http://nshipster.cn/wkwebkit/)
[iOS 8 WebKit框架概览（下)](https://link.jianshu.com/?t=http://www.cocoachina.com/ios/20150205/11108.html)
[WKWebView特性及使用](https://link.jianshu.com/?t=http://mp.weixin.qq.com/s?__biz=MzIzMzA4NjA5Mw==&mid=400327803&idx=1&sn=2a09fa94dd605a9f03bbc16f998e5717#rd)

###WKWebView新特性

性能, 稳定性,相对 UIWebView 大幅度提升.
允许JavaScript的Nitro库加载并使用（UIWebView中限制）
支持了更多的HTML5特性
高达60fps的滚动刷新率以及内置手势
GPU硬件加速
KVO
重构UIWebView成14类与3个协议，查看官方文档

缺点: 貌似不支持NSURLProtocol和NSURLCache。不能做缓存的话，就蛋疼了。

关于WKWebView的代理方法 这篇有比较完整的介绍
[WKWebView Delegate](http://www.jianshu.com/p/1d7a8525ad16)

###下面是相关的交互方法

####app调js方法

WKWebView调用js方法和UIWebView类似，一个是evaluateJavaScript，一个是stringByEvaluatingJavaScriptFromString。获取返回值的方式不同，WKWebView用的是回叫函数获取返回值

```
//直接调用js webView.evaluateJavaScript("hi()", completionHandler: nil) //调用js带参数 webView.evaluateJavaScript("hello('liuyanwei')", completionHandler: nil) // 调用js获取返回值 webView.evaluateJavaScript("getName()") { (any,error) -> Void in NSLog("%@", any as! String) }

```
####js调app方法

UIwebView没有js调app的方法，而在WKWebView中有了改进。具体步骤分为app注册handler，app处理handler委托，js调用三个步骤

####使用用户脚本来注入 JavaScript
WKUserScript 允许在正文加载之前或之后注入到页面中。这个强大的功能允许在页面中以安全且唯一的方式操作网页内容。

##4. 拦截协议

通过 UIWebView 或 WKWebView 代理方法的 请求开始前 来拦截相关协议.
最简单也是最容易想到的一种
UIWebView的代理方法，web view发出请求后拦截，查看是否为约定的协议，采取处理。

```
UIWebView
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType { 
NSString *url = request.URL.absoluteString; if ([url rangeOfString:@"camera://"].location != NSNotFound) { // url的协议头是camera NSLog(@"callCamera"); return NO; } return YES;
 }

WKWebView
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler { 
NSString *url = navigationAction.request.URL.absoluteString; NSLog(@"%@",url); 
if (navigationAction.navigationType == WKNavigationTypeLinkActivated && [url rangeOfString:@"camera://"].location != NSNotFound) { 
// url的协议头是camera NSLog(@"callCamera"); decisionHandler(WKNavigationActionPolicyCancel); // dosomthing。。。 
} else { 
decisionHandler(WKNavigationActionPolicyAllow); 
} 
}
```

##NSURLProtocol拦截

这种方式也是最近才看到，原本利用自定义NSURLProtocol来做缓存处理。相关的文章可以看：
[NSURLProtocol和NSRunLoop的那些坑](https://link.jianshu.com/?t=http://www.cocoachina.com/ios/20141225/10765.html)
[iOS中的 NSURLProtocol](https://www.jianshu.com/p/0244e431fb3c)
在自定义的Protocol的- (void)startLoading方法中，可以拦截到请求。一般会在这里做缓存的判断与读取处理。在此处，也可以判断约定的协议，然后发送通知，客户端就可以接收到通知，执行相应的方法。

需要注意的是WKWebView貌似不支持NSURLProtocol和NSURLCache。不能做缓存的话，就蛋疼了。
相关参考 [iOS与JS交互实战篇（ObjC版）](https://link.jianshu.com/?t=http://mp.weixin.qq.com/s?__biz=MzIzMzA4NjA5Mw==&mid=214063688&idx=1&sn=903258ec2d3ae431b4d9ee55cb59ed89#rd) [Objective-C与JavaScript交互的那些事](https://www.jianshu.com/p/f896d73c670a)




个人总结: 在 App 中基本都会有涉及到与 H5 交互的地方, 一般就是进行一个 HTML5 的页面展示, 然后 H5 内相关内容相应原生 Native 端,  进而我们主要要完成的就是, 与 Web 同统一协议, 然后在 OC 端 register 相应 Function 供其 调用, 在 Function 中要注意其必须要在主线程中执行, 否则可能闪退、 同样的 OC 端有时候也需要调用 JS。 具体交互 可以 通过  UIWebView 和 WKWebView 的 evaluateJavaScript 和 stringByEvaluatingJavaScriptFromString 来完成, 以及 JSContext 通过 evaluateScript  和 callWithArguments 完成, 还有一个使用起来很方便的三方库  WebViewJavascriptBridge 来完成. 此三方库也对 其代理方法做了相应封装我们可以使用其来 进行拦截. 还有一个比较好用的就是  设置  默认消息处理器,   两端都设置好之后, 都可以通过 简单的一段代码来执行 默认设置好的 Function。











