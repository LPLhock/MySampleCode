#iOS 一些好用不太常见的技巧

1. makeObjectsPerformSelector  在看  [Chameleon](https://github.com/BigZaphod/Chameleon) 源码是看到使用来对 数组清除使用的一种方法.  其原理 类似 for 循环 
代码如下:
```
　　　／／　_cachedCells 与 _reusableCells 皆为 NSDicationary  里面包含多个 View 对象. 
　　　[[_cachedCells allValues] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_reusableCells makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_reusableCells removeAllObjects];
    [_cachedCells removeAllObjects]; 
    // 也可以直接使用 enumerateobjects　　枚举遍历的方法来进行.   但是这种方法写起来感觉没这个可以直接将 调用的 Method 直接当参数填入,  这种方法还可以多传入一个参数到 SEL 里面.  
        [[_cachedCells allValues] enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
```

2. 

