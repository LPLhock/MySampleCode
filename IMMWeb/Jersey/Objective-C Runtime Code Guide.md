#Objective-C Runtime Code Guide

**前言: 做了 iOS 开发接近 3年了, 但是对于 iOS 系统底层的实现, 还是有很多一知半解的地方, 虽然开发过程中也有用到一些相关知识点, 比如 runtime runloop GCD, 但是感觉自己还是只停留在简单的会用这个层面上, 具体底层实现, 内部原理让自己说出来都是含含糊糊, 由于最近在找工作, 很多公司都会问这方面知识点, 自己回答不够深入, 专业, 当时真后悔为什么之前没抽时间出来好好整理整理这一块知识点呢, 可能人就是这样吧, 非要到火烧眉毛的时候才意识过来。** 

网上讲 Runtime RunLoop 这些底层实现的 Blog 很多, 都可以看看提供参考. 我这里先以 Apple 文档来做参考, 这样学习起来相对会全面一点
  
  参考资料: [apple runtime](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtVersionsPlatforms.html#//apple_ref/doc/uid/TP40008048-CH106-SW1)
           [Runtime 源码](https://opensource.apple.com/tarballs/objc4/)
  [toc]
  
##介绍
 
 大家都知道 Objective-C 是一门动态运行语言, OC 语言从编译时间和链接时间到运行时推迟了很多决策。 只要有可能实现的, 都尽量往动态运行时去完成它。  所以这门语言不仅需要一个 编译器来完成编译 链接等工作, 还需要一个强大的 运行时系统来执行编译代码。 运行时系统作为 Objective-C 的一种操作系统, 这也是 Objective-C 属于一门动态运行语言的原因。
 
 
 
  

