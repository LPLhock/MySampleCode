# SDWebImage

## 架构简介

![AEUHsK.jpg](https://s2.ax1x.com/2019/03/15/AEUHsK.jpg)

核心类是 SDWebImageManage, 由一个单例构成, 里面包含 SDWebImageCache 负责查看内存和磁盘, SDWebImageDownloader 负责网络下载.


## 如何计算图片大小
```
FOUNDATION_STATIC_INLINE NSUInteger SDCacheCostForImage(UIImage *image) {
#if SD_MAC
    return image.size.height * image.size.width;
#elif SD_UIKIT || SD_WATCH
    return image.size.height * image.size.width * image.scale * image.scale;
#endif
```

## 内存缓存 SDImageCache

SDImageCache 是其管理内存和磁盘缓存的核心类, 里面的 SDMemoryCache 是专门负责内存缓存的管理类.

SD 使用继承 NSCache 作为管理内存缓存的对象 SDMemoryCache

* SDImageCache 里面对 系统通知做了两个类型监听, 一个是 App 将要终止, 另一个是 App 将要切换到后台。
* SDMemoryCache 主要对 App 收到内存警告时做监听, 如果收到警告则清除缓存


## 怎样设计一个图片换框架

Manage: 
MemoryManage:
DiskMemoryManage:
NetworkingManage:
CodeManage: 包括 图片压缩,图片解码

1. 图片通过什么方式读写,过程如何
   可以以图片对应的 URL 单向 Hash 作为 Key 来进行访问.
   
2. 关于内存设计中需要注意什么问题
   * 内存存储空间 Size: 可以将图片的 0 - 10Kb 的图片来进行管理 100张, 在以 10 - 100KB 开辟个 20 张, 大于 100Kb 的 10张左右。
   * 存储的对象 Count
   * 淘汰策略: 使用队列的方式来进行淘汰, 先进先出.  或者模拟 LRU 算法来进行淘汰, 比如 30分钟内未使用过则进行淘汰。 查找的方案可以在: 每次进行读写时检测, 每次前后台切换时。
### 磁盘设计

* 存储方式: 和 Memory 一直使用 URL Key 来查找 保存
* 存储大小: 100MB
* 淘汰策略: 一般以天数来进行一个淘汰,  SD 使用的是 7天。

## 网络设计

* 图片请求最大并发数
* 超时策略
* 请求优先级

## 图片编解码

* 需要针对不通过格式的图片采用编解码方式: 应用策略模式来应对 不同的图片格式进行编解码。
* 在那个阶段做解码: 在图片读取成功后, 或者网络请求成功后, 因为系统在显示图片之前会在主线程进行解码操作, 我们可以在读取成功之后, 可以提前在子线程进行解码。


## 线程处理




