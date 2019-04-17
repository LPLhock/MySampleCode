# NSComparisonResult
 
## 详解
我们都知道 NSComparisonResult  是一个枚举值。

```
typedef NS_CLOSED_ENUM(NSInteger, NSComparisonResult) {
    NSOrderedAscending = -1L,
    NSOrderedSame,
    NSOrderedDescending
};
```

根据命名能想到的是, 上升 相等 下降, 但是每次都很容易困惑, 是怎么做的比较, 是左边比右边大呢, 还是右边比左边大呢。 看了下网上资料, 找到这张图。 还是很有权威的.

![Apple NSComparisonResult](https://img-blog.csdn.net/20151104165503919?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

## 参考 
[芒果iOS开发之NSComparisonResult比较结果](https://blog.csdn.net/CrazyZhang1990/article/details/49638703)

