# iOS 项目架构篇  MVC 演变 MVVM, ReactiveCocoa
 
## 架构
 
## MVC

Model-View-Controller
### 简介
是比较早就推出的项目架构模式, 也相对很实用, 将整体划分为三个主要的模块,并且各执其职, Model 层主要负责数据处理, View 层则是用户直接呈现到用户的视图层. Controller 是 Model 与 View 层的核心枢纽. 主要负责将网络数据获取下来将其解析到 Model 层之后, 传输到 View 层去进行一个展示。 

  * Model 
  * View 
  * Controller 
### 优点

1. 功能模块化, 使整个项目更加简洁清晰, 每个模块各执其职
2. 学习成本相对较低
3. 高重用性和可使用性, View 和 Model 层基本可以复用
4. 低耦合, 
### 缺点

1. 由于 C 层的特殊性, 随着版本迭代, 功能复杂之后, 很容易导致 C 层代码冗余, 变成 胖 VC。
2. 没有真正实现解耦, 虽然 C 层在 MVC 中承担着  M 与 V 的枢纽, 但是实际上 C 和 V 是耦合度非常高的。
3. View 的构建, 初始化都写在了 C 层.
4. 大量的业务逻辑, 相应逻辑都写在了 C 层。


### 改造 MVC

想要改造 MVC 首先从 胖 C 开始说起, 因为导致 MVC 模式影响最大的无非就是, 写着写着发现 C 层代码太过于冗余, 导致后期不已测试, 更新迭代等等。

1. 添加专门的 网络请求类 Server 层, 用来处理网络请求, 分担 C 层职责. 并且使网络请求可复用起来。
2. 专门的 Util 层来处理公共的业务逻辑处理。将这部分代码从 C 层划分出来。 因为这些代码都是可复用了。应该单独抽取出来。
3. 如果视图过于复杂, 界面拼接抽象到专门的类中。
4. 借鉴 MVVM 实现一个 ViewModel 层, 虽然传统的 MVC 中并没有 VM 的模块, 但是我们可以将 MVVM 优良的模块借鉴到 MVC 上来使用, 丝毫不会影响到整个架构, 并且还能达到锦上添花的效果。 如果遇到过于庞大的 C 层, 则可以灵活借鉴, 引用 VM 层来解决。
5. 


## MVVM 

### 简介

MVVM 最早是微软架构师在 2005 年推出, 主要是又 MVC 衍生出来, 也是对 MVC 的一种优良改进。它促进了 UI 代码与业务逻辑的分离。

其将项目划分为 Model, View(Controller View), ViewModel, , 简称 MVVM,   Model 和 原始的 Model 并无差异, 由于在 MVC 中, VC本身其实就是 C 与 V 关联在一起的, 因为每个 V 都是在 C 容器里面, 所有在 MVVC 里面 V 即表示了 C 和 V , ViewModel 是其关键的模块, 主要用于分担 C 大量冗余逻辑, 数据模块处理等等。 大量减轻 C 负担。

### ViewModel

一般在 MVC 中, 从网络层获取到 数据之后, 可能由于数据与展示数据并不是完全相符, 可能还需要我们对其进行一层加工转换等, 比如我们从后台上获取到相应的日期时间, 但是后台定义的是时间戳的方式, 来进行传输, 还有例如从后台获取到的是移动端与后台定义好的一套枚举来代表一个视图的不同展示类型等等, 类似这种还需要我们移动端去做特殊转换处理的数据, 以前我们都是在 C 层直接写好, 转换之后在保存到 Model 层, 这样一旦一个 C 中出现过多的案例, 则很容易导致 C 层的逻辑冗余, 不仅除了需要出 Model 层数据做特殊处理, 还有其他交互相应的逻辑等等, 全部加起来, 想要让 C 层代码简洁都难。

这时候 ViewModel 层的优点就能体现出来了, 我们将所有需要额外处理的数据逻辑, 都迁移到了 ViewModel 层来实现, 然后 ViewModel 在公开出相应的 Api 让 C 层来进行调用, 将其直接赋值到 View 层即可, 一般 一两行代码即可完成。 这样就能大量减轻了 C 层负担。 实现对 C 层廋身的效果。

## Binder

既然说到 MVVM 就无疑不会缺少 Binder , 可以说其是一个隐式的共识, 在 MVVM 中能体现的更加淋漓尽致, 做到 Model 层变化即时通知到 View 层, 将 View 层与 Model 层进行一个双向绑定的机制。

一般实现 Binder 的方式有两种:
KVO 与 ReactiveCocoa

## KVO

利用 KVO 观察者模式即可完成, 数据与 View 层的双向绑定, 对 Model 层的相应 属性进行监听观察, 发现其数据发生改变时, 通知到 View 层做出相应的刷新改变。 即可实现 View 层与 Model 层的实时动态更新。

## RAC

尽管，在 iOS 开发中，系统并没有提供类似的框架可以让我们方便地实现 binder 功能，不过，值得庆幸的是，GitHub 开源的 RAC ，给了我们一个非常不错的选择。
RAC 是一个 iOS 中的函数式响应式编程框架，它受 Functional Reactive Programming 的启发，是 Justin Spahr-Summers 和 Josh Abernathy 在开发 GitHub for Mac 过程中的一个副产品，它提供了一系列用来组合和转换值流的 API 。如需了解更多关于 RAC 的信息，可以阅读我的上一篇文章《ReactiveCocoa v2.5 源码解析之架构总览》。
在 iOS 的 MVVM 实现中，我们可以使用 RAC 来在 view 和 viewModel 之间充当 binder 的角色，优雅地实现两者之间的同步。此外，我们还可以把 RAC 用在 model 层，使用 Signal 来代表异步的数据获取操作，比如读取文件、访问数据库和网络请求等。说明，RAC 的后一个应用场景是与 MVVM 无关的，也就是说，我们同样可以在 MVC 的 model 层这么用。

## 总结 

总结
首先，我们从理论出发介绍了 MVC 和 MVVM 各自的概念以及从 MVC 到 MVVM 的演进过程；接着，介绍了 RAC 在 MVVM 中的两个使用场景；最后，我们从实践的角度，重点介绍了一个使用 MVVM 和 RAC 开发的开源项目 MVVMReactiveCocoa 。总的来说，我认为 iOS 中的 MVVM 可以分为以下三种不同的实践程度，它们分别对应不同的适用场景：
	•	MVVM + KVO ，适用于现有的 MVC 项目，想转换成 MVVM 但是不打算引入 RAC 作为 binder 的团队；
	•	MVVM + RAC ，适用于现有的 MVC 项目，想转换成 MVVM 并且打算引入 RAC 作为 binder 的团队；
	•	MVVM + RAC + ViewModel-Based Navigation ，适用于全新的项目，想实践 MVVM 并且打算引入 RAC 作为 binder ，然后也想实践 ViewModel-Based Navigation 的团队。
写在最后，希望这篇文章能够打消你对 MVVM 模式的顾虑，赶快行动起来吧。


## 参考 

[MVVM](http://blog.leichunfeng.com/blog/2016/02/27/mvvm-with-reactivecocoa/)
[ReactiveCocoa 讨论会](https://blog.devtang.com/2016/01/03/reactive-cocoa-discussion/)

