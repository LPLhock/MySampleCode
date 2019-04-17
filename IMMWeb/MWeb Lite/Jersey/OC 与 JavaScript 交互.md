#OC 与 JavaScript 交互

参考资料: [JavaScript和Objective-C交互的那些事](https://www.jianshu.com/p/939db6215436)
[JavaScript和Objective-C交互的那些事(续)](https://www.jianshu.com/p/939db6215436)
[WKWebView 使用及注意点](https://www.jianshu.com/p/9513d101e582)
[JavaScriptCore初探](https://hjgitbook.gitbooks.io/ios/content/04-technical-research/04-javascriptcore-note.html)
[iOS中JavaScript 与OC交互](https://www.jianshu.com/p/59242a92d4f2)

![OC与JS交互的那些事](https://upload-images.jianshu.io/upload_images/1192353-fd26211d54aea8a9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700)

##资料一概述[JavaScript和Objective-C交互的那些事](https://www.jianshu.com/p/939db6215436)

iOS 原生应用和 web 页面的交互大致分为几种, iOS7 之后 JavascriptCore(相互回调)、拦截协议(UIWebView、WKWebView 代理方法 shouldStartLoadRequest、 decidePolicyAction)、三方库 WebViewJavascriptBridge 等都可以完成, 一般我们可以 通过 JavascriptCore 来完成一系列, 这样与 android 相对统一, Web 只需要写一套框架, 两端一起遵守即可。 也可以通过 WebViewJavascriptBridge 来完成. android 也有一个 同名的框架。

###OC 执行 JavaScript 代码
相关方法
```
UIWebView : - (nullable NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;     可用于执行 JS 代码.
JSContext : - (JSValue *)evaluateScript:(NSString *)script;  
JSValue : - (JSValue *)callWithArguments:(NSArray *)arguments; 

// 获取当前页面的title NSString *title = [webview stringByEvaluatingJavaScriptFromString:@"document.title"]; // 获取当前页面的url NSString *url = [webview stringByEvaluatingJavaScriptFromString:@"document.location.href"];
```

###JavaScriptCore
iOS7之后苹果推出了JavaScriptCore这个框架，从而让web页面和本地原生应用交互起来非常方便，而且使用此框架可以做到Android那边和iOS相对统一，web前端写一套代码就可以适配客户端的两个平台，从而减少了web前端的工作量。
####web前端
在三端交互中，web前端要强势一些，一切传值、方法命名都按web前端开发人员来定义，让另外两端去做适配。在这里以调用摄像头和分享为例来详细讲解，测试网页代码取名为test.html，其代码内容如下：
#### 移动端

iOS 与 Android 两端最好等 Web 端将相关协议 方法名统一下来之后, 在根据其去写相应实现等, 这样后面就不用因为前端频繁 修改, 导致两端也要跟着修改, 我们使用 JavascirptCore 框架来完成, 与 JS 的交互。  
主要有两种方法, 一种是  block 一种是 使用 @protocol 模型注入的方式.

两种方法都是依赖  JSContext 来实现, 其原理都是一样的, 将 OC 方法注入到 JSContext 中。
Web 调用相应 Function 即可实现调用 OC 同名方法.

#####JavaScriptCore中类及协议：

	•	JSContext：给JavaScript提供运行的上下文环境
	•	JSValue：JavaScript和Objective-C数据和方法的桥梁
	•	JSManagedValue：管理数据和方法的类
	•	JSVirtualMachine：处理线程相关，使用较少
	•	JSExport：这是一个协议，如果采用协议的方法交互，自己定义的协议必须遵守此协议

#### 通过模型注入方案 ViewController 中的代码实现

其主要原理: 声明一些 @protocol 其必须要遵守 JSExport, 然后在 WebView 控制器中 遵守此 @protocol。直到 WebView 加载完成之后, 通过代理方法 didFinish 中通过 WebView 调用 JS 获取到  self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]; 但是在 WKWebView 中获取会失败. 要通过其他方法获取,  WKWebView 没有这个 documentView key。
然后要看 Web 端定义的 协议名称,  与 Android 统一实现, 将 ViewController 赋值到此 JSContext['key'] 'key' 表示的是每个JS 方法名点击事件的 方法头- 一般JS 一个按钮实现是这样 <input type="button" value="CallCamera" onclick="Toyun.callCamera()"> Toyun 代表这个 Key. 中, 完成 iOS 与 Web 端通信协议。  然后 根据 Web 端定义的方法名称来定义 @protocol 方法名称, 具体实现写到 ViewController 即可。

####JavaScriptCore使用注意

由于 JS 调用 OC 都是触发在 子线程中, 所以我们在 iOS 端要注意, 特别是涉及到 UI 视图更新相关处理, 必须要在 主线程中去执行, 否则导致闪退。


###拦截协议

拦截协议通常是在 代理方法 shouldStartLoadRequest URL 加载开始之前, 我们通过代理方法拿到 相关 URL , 做相应拦截处理即可。
## 资料二概述 [JavaScript和Objective-C交互的那些事(续)](https://www.jianshu.com/p/939db6215436)

主要介绍了两个点：　一个是使用　@protocol 通讯, 将 Self 赋值到 JSContext 中导致了内存泄漏问题解决方案,  还有一点就是 注入 JSContext 的时机, 我们一般在 代理方法 shouldStartLoadRequst 中注入,但是其是这个时候并非 JS 真正渲染完成, 所以在这个时刻进行注入, 有时候会出现问题.  
最直接的解决方法是采用 Block 方式注入, 注入时机在每次使用的时候都重新获取一次。 

###内存管理

####内存泄露问题
####解决办法
###合适时机注入交互对象
####UIWebView什么时机创建JSContext环境
####我的错误做法
####解决办法
####UIWebView-TS_JavaScriptContext的readme译文


## 遗留问题讨论。

* **关于线程:**不管是使用 @protocol 还是 block 回调的方式, 让 JS 回调 OC 代码, 都需要考虑线程的问题,  JS 调用 OC 默认是在 子线程中去执行。 那么在 OC 的执行逻辑中, 我们应该要注意了, 凡是关于 UI 更新相关的 一切要切回到主线程中去运行 才是合理的！！！



