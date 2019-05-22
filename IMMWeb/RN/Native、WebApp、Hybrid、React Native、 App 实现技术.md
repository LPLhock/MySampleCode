# Native、WebApp、Hybrid、React Native、 App 实现技术

## 简介

随着互联网的发展, 移动端在智能手机浪潮的推动下兴起, 已经到了不可缺少的程度, 确实人们已经在不知不觉中已经和 App 形成紧密的练习, 回忆过来移动端已经发展了有 8年以上 的时间, 在技术上不断升级, 迭代, 层出不穷的新技术推出, 大大加速了 移动端的发展！

## 技术实现

先从 Native说起, 至今实现 App 的方式有很多种, 都是为了解决业界存在的痛点而生, 并且在不同的立场不同的场景下都有各自的优缺点.  目前实现 App 的技术大致分为  Native, Web, Hybrid,  react Native。这四大类型。

## Native

原生 App. 通过 iOS 或者 Android 官方平台推出的 IDE 以及 语言, 来实现.
iOS:  语言 OC/Swift, 也可以兼容 C 和 C++  IDE: Xcode
Android:  语言 Java, 同样兼容 C 和 C++ IDE: Android Studio。 

## WebApp

可以理解成一个 网页 App. 就像我们使用浏览器打开某个网页一样的感觉, 一般只需要 HTML + CSS + JS 实现一个 前端页面, 然后在将其分别 打包到 iOS 和 Android 平台上, 分别由 iOS 和 Android 提供一个壳, 里面使用一个  WebView 来作为容器提供展示网页。

优点: 
缺点: 性能相对不是特别好, 并且消耗的流量要相对  Native 更多. 并且加载速度上也较为缓慢。 一些原生的功能无法提供

## Hybrid

Hybrid App. 就像我们原生 App 里面包含某个 H5 页面,  然后相应的 iOS 和 Android 提供一套  Api 供 Web 调用。  然后 页面的 UI 还是依靠 HTML + Css  来渲染。 

## React Native

主要为了解决 Hybrid  UI 渲染过慢, 以及交互较差的原因.  严重依赖 JSBridge。  UI 交互等都是依靠 原生提供一套 统一 Api 来提供其调用。


## 总结

[移动端实现技术](https://segmentfault.com/a/1190000011154120#articleHeader2)
[思维导图](http://naotu.baidu.com/file/6af15fcbb72f89926043779811b1ea44?token=df0378691ecdcef2)


