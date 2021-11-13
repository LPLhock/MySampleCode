# iOS 崩溃符号化分析

**这里主要介绍  symbolicatecrash 和 atos 工具的使用, 两个工具都是 Xcode 自带, 使用 sh  脚本写的,  symbolicatecrash 实际上也是基于 atos 来进行符号化的, atos 可以针对模块方法进行符号化解析,  symbolicatecrash 是针对整个文件进行符号化**

目前有 3 种符号化的方法, 最简单方便的是直接把崩溃文件拖拽到 Xcode -> Device -> View Device Log 里面,  但是这里这种符号化有一个局限性, 就是当前崩溃的包必须是在当前机器打出来的, 系统才可以进行符号化。  

一般 dev/beta/product/ 包可能都不是在自己电脑 Arch 的, 所以我们需要把每次打出来包的 dsym 文件保存到统一的远程服务器, 这样每个开发可以去直接下载对应版本的 dsym, 在结合下面介绍的 2个工具进行符号化

## 一、symbolicatecrash

首先通过终端找到  symbolicatecrash 路径, 通过 ./symbolicatecrash 结合 dsym 和提供的 crash/ips/beta 文件来进行符号化。

**查找 symbolicatecrash 路径**

find /Applications/Xcode.app -name symbolicatecrash -type f

终端会输出当前  symbolicatecrash 不同系统平台路径, 我们使用 SharedFrameworks/DVTFoundation.framework/Versions/A/Resources 里面的 symbolicatecrash。

**使用:** 

& ./symbolicatecrash crashFilePath dsymPath > crashSymbolFilePath

脚本 -> 产生崩溃文件路径 -> dsym 路径 > 输出符号化文件路径

**遇到的问题**

1. **Error: "DEVELOPER_DIR" is not defined at ./symbolicatecrash line 69.**

   这是因为脚本有执行需要依赖环境宏定义 

   查看脚本代码

   if(!defined($DEVELOPER_DIR)) {
       die "Error: \"DEVELOPER_DIR\" is not defined";
   }

   执行 export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer 即可

2. **No crash report version in file**

   最近在符号化 iOS 15 以上的崩溃时, 总是提示找不到崩溃版本, 很诡异, 最后查了一下原因是 iOS 15 crash log 格式做了更新, 需要用到下面的 CrashSymbolicator.py 来进行符号化。 

3. **UUID 不一致**

   当不确定当前崩溃是否跟拿到的 dsym 是否为想对应的包时, 使用 dwarfdump --uuid dSYM文件路径 

   查看 dsym UUID: **dwarfdump --uuid dSYM文件路径** 

   **TODO:** 

   终端会列出当前 dsym 对应的 uuid 出来,  在到 crash 文件里面找到对应的 Binary Images/ Header 找到对应的 uuid 看看是否一致.

   这里看了网上资料说在 crashLog 里面有 Header,  里面有个 slice_uuid 标识当前文件 uuid, 用来和 dsym 的 uuid 对比, 但是看到现在的 crash 文件并没有此字段, 不知道是不是 Apple 做了格式更新导致的。

   

## 二、atos 

>  atos命令将十六进制地址转换为源代码中可识别的函数名称和行号

**使用方法**

`atos -arch <Binary Architecture> -o <Path to dSYM file>/Contents/Resources/DWARF/<binary image name> -l <load address> <address to symbolicate>`

atos -arch 指令集 -0 dsym -l 调用地址 符号模块地址

`*// explain parameters*`
`load adress:可执行指令部分相对镜像文件中的起始加载地址`
`address to symbolicate：调用函数的地址`


`atos -o xxx.app.dSYM/Contents/Resources/DWARF/xxx -l 0x00000001c4fe7000 -arch arm64`

`atos -arch arm64 -o xxx.app.dSYM/Contents/Resources/DWARF/xxx -l 0x00000001c4fe7000 0x00000001a2d6e29c`

`*// extension about xcrun*`
`*// xcrun can accept address to symbolicate on the way in command line.*`

`xcrun atos -o xxx.app.dSYM/Contents/Resources/DWARF/xxx -l 0x1040dc000 -arch arm64`
`0x1052c0464`
`__63-[GCDAsyncUdpSocket asyncResolveHost:port:withCompletionBlock:]_block_invoke.118 (in xxx) (GCDAsyncUdpSocket.m:1209)`
`0x104ba9094`
`-[BDAboutController tapButton:atIndex:] (in xxx) (BDAboutController.m:251)`



![图片](https://mmbiz.qpic.cn/mmbiz_png/qMicvibdvl7p24icma0icshuicTg669eRGEopXvWnTyiatdXvficS7pXTbJDk4TJfVMzy26UMsosWBFgCqqCNzicalEzJA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)



## 三、CrashSymbolicator.py

>  因为崩溃文件是 iOS 15 产生, 原来不知道 Apple 做了这一项调整, 一直在用 symbolicatecrash 进行解析, 终端报错  No crash report version in file, 查了下资料才发现新的文件格式得使用  CrashSymbolicator.py 解析

[Xcode13  crashLog Update](https://developer.apple.com/documentation/xcode-release-notes/xcode-13-release-notes)

> - To support the new JSON-format crash logs generated in macOS Monterey and iOS 15, Instruments includes a new `CrashSymbolicator.py` script. This Python 3 script replaces the `symbolicatecrash` utility for JSON-format logs and supports inlined frames with its default options. For more information, see: `CrashSymbolicator.py --help`. `CrashSymbolicator.py` is located in the `Contents/SharedFrameworks/CoreSymbolicationDT.framework/Resources/` subdirectory within Xcode 13. (78891800)

iOS 15 之后 Apple 对符号化文件格式进行了 JSON 支持, 所以针对 iOS 15 以上产生的崩溃文件, 写入方式应该是做了调整, 所以在对 iOS 15 以上崩溃文件进行符号化时, 直接使用 CrashSymbolicator.py 来解析, 否则会出现符号化失败, 报错  No crash report version in file 的问题。

**查找**

`find /Applications/Xcode.app -name CrashSymbolicator -type f`

和使用  symbolicatecrash 方式类似, 先找到其路径, 系统列出不同平台 sh, 切换到最后一个 /Applications/Xcode.app/Contents/SharedFrameworks/CoreSymbolicationDT.framework/Versions/A/Resources 

稍微和 symbolicatecrash 不同的是, 其调用方式可以支持参数的方式来排列文件顺序,并且其是用 python 写的脚本, 所以要使用 python3 来进行调用, 否则会报错。

-d '符号表路径' -o '输出符号化路径' -p '苹果给的崩溃日志'

**使用**

`python3 CrashSymbolicator.py -d /dSYMs -o /xxxSymbo.crash -p /xxxCrash.ips`



## 参考资料

[你真的了解符号化么？](https://mp.weixin.qq.com/s/6Odq8JTYXL0bA8xyWEO1Og)

[符号化](https://zuikyo.github.io/2016/12/18/iOS%20Crash%E6%97%A5%E5%BF%97%E5%88%86%E6%9E%90%E5%BF%85%E5%A4%87%EF%BC%9A%E7%AC%A6%E5%8F%B7%E5%8C%96%E7%B3%BB%E7%BB%9F%E5%BA%93%E6%96%B9%E6%B3%95/)

