#深入剖析 WebKit

参考: [深入剖析 WebKit](https://xiaozhuanlan.com/topic/6912403587)

[TOC]

##浏览器发展

1990 开始至今。
1990年WorldWideWeb 问世,后改名 Nexus, 1991 年公布源码.
1993年Mosaic, 1994 Netscape Navigator 网景浏览器, 后还成立了知名的网景公司。
1995 Microsoft 推出  Internet Explorer, 最终赢得当时整体市场份额, 成为霸主。
1998年网景公司成立了 Mozilla 基金会组织，同时开源浏览器代码，2004年推出有多标签和支持扩展的 Firefox 火狐浏览器开始慢慢的占领市场份额。
2003 safari 以 Apple 2005 开源的 WebKit 为核心源码, 后续 Chrome 在其基础上进行开发.
2012 才正式推出 HTML5 技术规范, 主要包含 10 个大类别.
完整的浏览器发展史可以在这里看：[浏览器历史](https://en.wikipedia.org/wiki/Timeline_of_web_browsers)

##WebKit 全貌

###架构

到后期浏览器技术的发展基本都是基于 WebKit 开发的。

![WebKit](https://diycode.b0.upaiyun.com/photo/2018/368e8e918a1b6cc470f141c5a9ab1ef9.png)

###WebKit 源代码结构说明

###WebKit 代码风格

参考 : [](https://webkit.org/code-style-guidelines/)

###WebKit 的设计模式

* Single: WebKit 里的 Loader 管理 CacheResource 采用单例设计模式.
* Tool: 可以在 WebKit 源码里搜索结尾是 Factory 的代码，它们一般都是用的工厂模式。
* KVO: 名称结尾是 Client 都是观察者模式，比如 FrameLoaderClient 可以看成是观察者类，被观察者 FrameLoader 会向 Client 观察者类通知自身状态的变化。
* 组合模式: 用于树状结构对象，比如 DOM Tree，Render Tree，组成它们的类 ContainerNode 和 RenderObject 可以看成组合模式。
* 命令模式: DOM 模块的 Event 类和 Editing 模块的 Command 类都是命令模式。

## 主要类

### 整体

![overall](https://diycode.b0.upaiyun.com/photo/2018/0d3cca13a6819d88e0a8d3fa224b4e45.png)

	▪	Frame：中心类，通过它找其它类
	▪	FrameLoader：加载资源用的
	▪	Document：具体实现是 HTMLDocument
	▪	Page：窗口的操作
	▪	EventHandler：输入事件的处理，比如键盘，鼠标，触屏等
	

### WebCore::Frame

![Frame](https://diycode.b0.upaiyun.com/photo/2018/b19b222d23d60be41e7444899703e244.png)
	
	▪  FrameTree：管理父 Frame 和子 Frame 的关系，比如 main frame 里的 iframe。
	▪	FrameLoader：frame 的加载
	▪	NavigationScheduler：主要用来管理页面跳转，比如重定向，meta refresh 等。
	▪	DOMWindow：管理 DOM 相关的事件，属性和消息。
	▪	FrameView：Frame 的排版。
	▪	Document：用来管理 DOM 里的 node，每个 tag 都会有对应的 DOM node 关联。
	▪	ScriptController：管理 js 脚本。
	▪	Editor：管理页面比如 copy，paste和输入等编辑操作。
	▪	SelectionController：管理 Frame 里的选择操作。
	▪	AnimationControlle：动画控制。
	▪	EventHandler：处理事件比如鼠标，按键，滚动和 resize 等事件。
	

###渲染引擎

![render engine](https://diycode.b0.upaiyun.com/photo/2018/38653c9e8802a125116cde828f847231.png)

渲染过程:

![render process](https://diycode.b0.upaiyun.com/photo/2018/b363a6d6f9d79e948331f7f8835e1faf.png)

## Frame 的主要接口

###Create

###CreateView

###setDocument

##WTF

###Smart ptr 智能指针

##RefPtr

##Assert 断言的实现和应用

##内存管理

##容器类

##Vector 动态数组

##HashTable 哈希表

##线程

##Loader

##Loader 的资源













