# CocoaPod 管理三方库 头文件搜索设置

通过 Cocoapod 导入下来的第三方库, 之前都是直接使用  import "" 导入,  最近在开发新项目的时候,  一直使用 import "" 发现找不到, 使用 import <> 才能搜索到这个库.

查了下相关资料, 然后到  Project --> Build Settings 搜索 User Header, 或者 Header 能看到管理 Search Path 的相关设置.

User Header Search Path 添加 $(PODS_ROOT)选择：recursive（会在相应的目录递归搜索文件）：  即可解决。


参考: [通过cocoapods导入的第三方库import时找不到文件](https://segmentfault.com/q/1010000005834283)
[使用cocoaPods import导入时没有提示的解决办法](https://blog.csdn.net/win_ann/article/details/38540047)


