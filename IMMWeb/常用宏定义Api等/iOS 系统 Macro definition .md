# iOS 系统 Macro definition 


## NS_DESIGNATED_INITIALIZER 与 NS_UNAVAILABLE  

* File: NSObjCRuntime.h  usr/include -> objc/NSObjeCRuntime.h 

* `NS_DESIGNATED_INITIALIZER`:  一般我们在继承中想要重新指定初始化方法时会用其, 写到方法声明后面, 让开发者使用其来类进行初始化, 然后在配合 `- (nonnull instancetype)init NS_UNAVAILABLE;` , 如果开发者依然使用 init 则会受到编译器报错 `'init' is unavailable`。 不过在 NS_DESIGNATED_INITIALIZER 声明的方法实现里面一般要使用 父类定义的 DESIGNATED 来进行初始化构建。`self = [super initWithNibName:nil bundle:nil];`
* `NS_UNAVAILABLE`: 用来标记不可直接使用的方法。
* `NS_REQUIRES_SUPER`:  此宏可定义在方法声明后面, 当子类覆盖此父类方法时, 如果没有调用 super method 此编译器报错。

**可参考:**_https://blog.csdn.net/zcube/article/details/51657417_


