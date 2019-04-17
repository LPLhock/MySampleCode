# Blog 关于 iOS 私有 API 扫描

https://github.com/SwiftOldDriver/iOS-Weekly/issues/710

链接
https://www.jianshu.com/p/24026b30975f https://www.jianshu.com/p/999f4cc7e1fc
理由
检索私有 API 扫描相关的文章，基本都提及网易游戏开源的 iOS private api checker 项目。但大部分文章都是简单的摘录该项目的 README 或者介绍下如何把该项目运行起来。对于其内在逻辑，以及存在的诸多问题，缺乏必要的剖析，所以写了第一篇文章。
构建私有 API 库需要先构建 documented API 数据集，而新版 Xcode 的 API 文档不再使用 docSet 这种格式。第二篇文章分享了 Xcode 9 在 Mac 上存储 documented API 的细节。
推荐人信息
Linkou Bian


