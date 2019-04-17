# Xcode10 NS_ASSUME_NONNULL_BEGIN NS_ASSUME_NONNULL_END

## 前言

升级成 Xcode 10 之后每次 New File 看到 .h 基本都能看到 **NS_ASSUME_NONNULL_BEGIN** 和 **NS_ASSUME_NONNULL_END** 成对出现在 @interface 与 @end 上下, 包裹住它, 这两对关键字并非新特性, 只是 Xcode 10 之后系统默认实现了, 应该是考虑到与 Swift 混编, 为了更好兼容其 optional 与 non-optional。

## 原理

我们直接来看定义: NSObjectRuntime.h 
```
#ifndef NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#endif
#ifndef NS_ASSUME_NONNULL_END
#define NS_ASSUME_NONNULL_END   _Pragma("clang assume_nonnull end")
```

其表示由 NS_ASSUME_NONNULL_BEGIN 开始以下定义的 对象都是 __nonnull 不可为空的, 直到 NS_ASSUME_NONNULL_END 作用域。

例如:
```

NS_ASSUME_NONNULL_BEGIN

@interface YZHAddBookDetailsVC : YZHBaseViewController

@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSArray* array;

@end

NS_ASSUME_NONNULL_END

```
其表示  name 和 array 都是由  __nonnull  修饰, 不可为空,  当编译时如果为空会受到警告。
与其 对应的是 __nullable, 表示对象也可以为 nil。




