# 读 Apple 资源编程指南 Resource Programming Guide

##Nib Files

Apple 对使用 Nib 与 code 方式实现的建议
注意：  虽然您可以在不使用nib文件的情况下创建Objective-C应用程序，但这样做非常罕见，不建议这样做。根据您的应用程序，避免使用nib文件可能需要您替换大量的框架行为才能获得与使用nib文件相同的结果。


参考 : [资源编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/LoadingResources/Introduction/Introduction.html#//apple_ref/doc/uid/10000051i)
[Bundle Programming Guide](https://developer.apple.com/library/archive/documentation/CoreFoundation/Conceptual/CFBundles/Introduction/Introduction.html#//apple_ref/doc/uid/10000123i)



2018-09-22 12:22:51.136316+0800 YZHYolo[53934:5641512] [framework] CUICatalog: Invalid asset name supplied: ''
2018-09-22 12:22:51.136516+0800 YZHYolo[53934:5641512] Could not load the "" image referenced from a nib in the bundle with identifier "www.YZHBlockChain.YZHYolo"
2018-09-22 12:22:51.137624+0800 YZHYolo[53934:5641512] [framework] CUICatalog: Invalid asset name supplied: ''
2018-09-22 12:22:51.137789+0800 YZHYolo[53934:5641512] Could not load the "" image referenced from a nib in the bundle with identifier "www.YZHBlockChain.YZHYolo"
2018-09-22 12:22:51.144113+0800 YZHYolo[53934:5641512] [framework] CUICatalog: Invalid asset name supplied: ''
2018-09-22 12:22:51.144271+0800 YZHYolo[53934:5641512] Could not load the "" image referenced from a nib in the bundle with identifier "www.YZHBlockChain.YZHYolo"
2018-09-22 12:22:51.145255+0800 YZHYolo[53934:5641512] [framework] CUICatalog: Invalid asset name supplied: ''
2018-09-22 12:22:51.145448+0800 YZHYolo[53934:5641512] Could not load the "" image referenced from a nib in the bundle with identifier "www.YZHBlockChain.YZHYolo"

