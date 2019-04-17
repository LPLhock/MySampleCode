#iOS App Icon 启动图尺寸配置总结

##前言

近期在开发新项目, 然后针对 App Icon 与 App LaunchScreen 都需要重新切一套, 需要把相应尺寸大小跟 UI 说明一下, 为了让自己以及 UI 同事能更好的去了解 iPhone 不同尺寸特意整理了一下。

## App LaunchScreen(启动图)

下面分别罗列出当前所有 iPhone 不同机型尺寸所需 LaunchScreen Size, 其中 iPhone 6 7 8 尺寸一致, iPhone 6 7 8 P 尺寸一致, 所以分别切两种即可. 另外新出的 iPhone X XR XS XSMAX, 除了 X和 XS 尺寸一致外, 都需要分别对应不同尺寸。 其他的也就是 小屏的如 iPhone 4 5 SE 等。


Device       |     横屏尺寸      |   竖屏尺寸      
---------    |   ------------   |  -----------
iPhone XS Max |  1242px × 2688px | 2688px × 1242px 
iPhone XS     |  1125px × 2436px | 2436px × 1125px
iPhone XR     |  828px × 1792px  | 1792px × 828px
iPhone X      |  1125px × 2436px | 2436px × 1125px
iPhone 8 Plus |  1242px × 2208px | 2208px × 1242px
iPhone 8      |  750px × 1334px  | 1334px × 750px
iPhone 7 Plus |  1242px × 2208px | 2208px × 1242px
iPhone 7      |  750px × 1334px  | 1334px × 750px
iPhone 6s Plus|  1242px × 2208px | 2208px × 1242px
iPhone 6s     |  750px × 1334px  | 1334px × 750px
iPhone SE     |  640px × 1136px  | 1136px × 640px

## APP Icon 

如果只是针对 iOS 移动端来说, 对 iphone 做配置的话, 按照下面指的这五种分别切图即可. 
iPad Pro. iPad, iPad Mini 尺寸需另切。

主要包括五种类型图片, 分别是 手机上直接展示的 App Icon,搜索栏 App Icon, 设置栏 App Icon, 通知栏 App Icon, 另一个是 AppStore 上需要的。

Device or context | Icon size 
------------------| --------
iPhone App Icon |180px × 180px (60pt × 60pt @3x)
 |120px × 120px (60pt × 60pt @2x)
iPhone Spotlight Icon(搜索框下展示图标)| 120px × 120px (40pt × 40pt @3x)
 |80px × 80px (40pt × 40pt @2x)
iPhone Settings Icon (设置栏里面展示图标)|87px × 87px (29pt × 29pt @3x)
  |58px × 58px (29pt × 29pt @2x)
iPhone Notification icon| 60px × 60px (20pt × 20pt @3x)
  |40px × 40px (20pt × 20pt @2x)
App Store |1024px × 1024px (1024pt × 1024pt @1x)

参考: [Apple Icon](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/)

设置完 Spotlight Icon 之后不会立即更新, 需要设备重启。

>希望此篇文章对您有所帮助，如有不对的地方，希望大家能留言指出纠正。谢谢！！！！！
>学习的路上,与君共勉!!!








