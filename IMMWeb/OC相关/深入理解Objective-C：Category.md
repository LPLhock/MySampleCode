#深入理解Objective-C：Category
[美团技术团队](https://tech.meituan.com/DiveIntoCategory.html)

###1、初入宝地-category简介

category 是objective-c 2.0 新增加的语言特征.  其作用是为已存在的类添加方法,特性等。除此之外还可以通过 category 减少单个类文件的体积. 将一个类不同模块功能划分开来。

**Apple 推荐使用场景**

* 可以将一个类的不同功能划分在各个分类模块化完成.  这样做的好处有 a)可以减少单个类文件的体积,防止代码过于冗余在一个文件里面,不便于阅读 使用。 b)把不同功能划分到不同的 category 组里面去, 每个 category 各执所职！c)便于多人共同开发完成同一个类。d) 按功能需求引入不同 category 即可, 防着文件体积过大编译耗时。
* 声明私有方法。

除了 Apple 推荐的做法意外, 大家还通过  Category 实现了其他功能
如: 模拟多继承。 把 framework 的私有方法公开。

typedef struct category_t {
    const char *name;
    classref_t cls;
    struct method_list_t *instanceMethods;
    struct method_list_t *classMethods;
    struct protocol_list_t *protocols;
    struct property_list_t *instanceProperties;
} category_t;

###2、连类比事-category和extension
  
  extension 看起来就像是一个少了实现文件的匿名分类, 其实这两个特性还是有挺大差别的, extension 是在编译期间完成的, category 是运行期间完成。  extension 和本类是一个整体在编译期间就会被写入到内存中去, 是类的一部分, 在编译器和头文件里面的 @interface 以及实现文件的 @implement 一起形成一个完整的类. 所以 extension 可以直接添加实例变量, 而要想在 category 直接添加属性则会导致系统运行报错, 因为编译期结束之后 本类结构体, 内存大小等都已经确定下来, 直接进行修改会破坏掉原有的类的内部结构. 
  
  extension 是类的一部分, 与本类共同编译完成, 共同消失,  其一般用来生成隐藏信息, 如私有属性, 要为一个 Class 添加 extension 必须要拿到这个类源码才可以直接添加. 
  
### 3、挑灯细览-category真面目

没看明白-.-

### 4、追本溯源-category如何加载

要点:　a)分类的方法没有把原类方法完全覆盖掉，只是在 objc_class 结构体里面的 method_list 里面将分类方法 插入到了最前面, 所以在方法调用的时候, 会最先调用分类的方法而已。
b) category 的方法会被放入到 原 Class objc_method_list　里面, 并且由最前下表的顺序插入, 这样在 objc 消息转发机制下, 当调用一个方法时, 会一次从 objc_method_list　里面按列表遍历查找一致的方法名, 进行转发调用 所以相同方法名, 最后一个编译的分类方法会被调用的原因。

### 5、旁枝末叶-category和+load方法

作者使用两个 category 的例子, 打印信息证明了 两个重要的信息。
1. 由于 category 是在运行期间决议的, 所以可以肯定的是 category 的 +load 同样会在 +load 执行之前就已经编译完成了。
2. +load 的调用顺序是 由 本类开始执行, 然后在到 category。 具体先执行那个 category 是由编译顺序决定。  Build Phases ---> compile Sources 文件添加顺序。

所以，对于上面两个问题，答案是很明显的： 1)、可以调用，因为附加category到类的工作会先于+load方法的执行 2)、+load的执行顺序是先类，后category，而category的+load执行顺序是根据编译顺序决定的。 目前的编译顺序是这样的：

对于 +load 方法, 为什么在执行顺序上, 与添加的方法不一样,  个人猜想。
+load 方法与其他添加的方法不一致, 其并不是在运行期才进行添加的,  其是在编译期间就会执行。 

### 6、触类旁通-category和方法覆盖

作者感觉前面的 category 实现代码分析, 得知其并没有覆盖掉 原 Class 方法, 继而顺着思路使用 runtime 相关函数 通过遍历查找的方法, 取到原 Class 被覆盖的方法, for 循环遍历 method_list 然后判断找到的 Method 是否与要找的一致, 一致则保存起来, 最后一个即是原 Class 被覆盖的方法了。

**重点:** IMP  SEL  Method class_copyMethodList method_getImplementation method_getName  C 指针函数理解。

```
    Class currentClass = [JSDCategory class];
    JSDCategory *my = [[JSDCategory alloc] init];
    
    if (currentClass) {
        
        unsigned int methodCount;
        Method* methodList = class_copyMethodList(currentClass, &methodCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        
        for (NSInteger i = 0; i < methodCount; i++) {
            Method method = methodList[i];
            NSString* methodName = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
            
            if ([@"wathareyou" isEqualToString:methodName]) {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
            }
        }
        typedef void (*fn) (id, SEL);
        
        if (lastImp != NULL) {
            fn f = (fn)lastImp;
            f(my,lastSel);
        }
        free(methodList);
    }
    
```

## 7、更上一层-category和关联对象

通过 Category 添加实例变量实际上是 借助 runtime 里面的 AssociationsManager 完成、 此类负责管理 Class 关联对象的添加 存储 销毁。

当 Class 被销毁时， runtime 的销毁对象函数 objc_destructInstance 里面会判断这个对象有没有关联对象, 如果有会调用 _object_remove_assocations 做关联对象的清理工作。
    



##总结

看完整篇文章下来, 对 Category 又有了更深入一层面的了解, 也对 Runtime 有了浅入的了解。 

Class 与 extension 都是在项目编译期间决议, 编译器将其编译完成写入到 objc_class 结构体里面, 内存大小以及相应方法 实例变量都确定下来之后, 作者利用 clang -rewrite-objc 查看 编译 Category 执行源码. 发现在编译器会将 Category 整体结构编译确定下来, 编译顺序由 compile Resource 文件由上至下依次, 编译完成之后 编译器的工作基本结束, 在进入到 runtime, 系统才会运行 runtime 内置函数对 Category 进行加载。

runtime　加载　category 首先进入  void _objc_init(void) 函数 . 文章中有源码　一下子没看明白，待以后有时间在回过头来看。  通过 runtime 源码加载可以得出两个结论： **1. category 的方法并不会真正把原 Class 方法直接覆盖掉。 其只是会将编译的每个 category　方法插入到　原　class objc_class 里面的 method_list 最前面. 所以调用的时候同名方法总可以调用到分类里的方法   2. 分类的加载也是根据 compile resource 顺序来加载的,　所以如果有　３个同名方法的话, 最后一个加载的 category 排列在数组最前面, 由于OC 消息转发机制的原因, 发送消息的时候会 依次从 MethodList 进行遍历, 所以最前面的方法, 方法名一致则会直接调用, 消息发送完成并终止递归。 **

Category 与　+load 方法、  +load 方法是在运行之后才会执行, Category 则是在运行期间完成加载, 所以其如果不受其他因素影响的话 Category 应该是可以正常执行的。 如果有两个 Category 则执行顺序会是怎么样的呢 ？     作者用例子验证了 Category 可以正常运行, 并且得出运行顺序.
结果： 是有正常调用的,  因为附加 Category　是在项目运行期间就完成. 而 +load 是在项目运行初期。  Category 执行顺序是 先执行 原 Class 后执行 Category。 其顺序按 Compile resource 顺序排列.  

既然 Category 没有真正覆盖掉 原 Class 方法, 那么就通过 runtime　通过编译查找的方法把 原 Class Method 找出来并执行, 涉及到一些平时没怎么使用的 Type Api .   如 IMP SEL  C函数指针 Method class_copyMethodList method_getImplementation method_getName
sel_getName。

Category 与关联对象, Category 想要直接添加实例变量, 在访问起来是会报错的, 因为编译期间 Class objc_class 结构体已经构建完成了, 直接添加会破坏已有的结构。　必须通过　runtime 也就是在 Category　加载期间使用　关联函数将实例与　原 Class 进行关联。 

AssociationsManager 是专门管理关联对象的。  当对象被销毁时, runtime 的销毁对象函数 objc_destructlnstance 里面会先判断这个对象是否有关联对象, 如果有, 将会调用 _object_remove_assocations 做关联对象的清理。


### 疑惑点
1. 关联对象如何完成。
2. objc_class 底层实现细节。
3. Category 可以将一个 Class 划分为多个文件去执行各个模块功能, 虽然相对挺方便多人开发, 又可以减少一个文件体积, 但是如果要将 一个 Class 划分为多个模块功能,  为什么不直接多分为 不同的 Class 去完成呢 ？ 这样让每个 Class 功能更为专一, 各执所职。 不是更好吗？　
　Category 应该在这样的模式下去使用才比较合理, 比如系统或者其他同事已经写好的 Class, 后面由于业务需求 改动等, 我们不得已要在这个 Class 上进行功能扩展, 但是又不能随意改动 原 Class 功能, 这种情况是采用 Category 去解决的最佳方法.　Apple 设计 Category 方法直接插入到 数组最前的目前可能也是因为这一点吧。 
　不要为了 Category 而去 Category。 一个 Class 业务过于复杂, 也不是什么好事, 这样就违背了我们经常说的 编程思维, 高内聚低耦合！！！ 每个类更应该专注于自己的功能, 各尽其职即可。




