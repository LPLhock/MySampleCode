# 常用关键字 static、const、 extern、define 

## static

**引用[Effectuve Objective-C]**
**static 修饰则意味着该变量仅在定义此变量的编译单元中可见, 不会导致其他单元重复导致命名冲突, 当编译器编译到此单元时, 就会输出一份 "目标文件"(object file)**

其可用于修饰常量变量或函数, 延长其生命周期, 被修饰的数据类型会保存到 bbs段(静态区) 中, 内存由编译器分配, 一般随程序结束后清除释放, 被修饰的数据类型, 系统只会为其分配一次内存地址, 所以用于修饰数据类型时, 不管执行多少次, 被修饰的数据类型只会初始化一次。
* 修饰全局变量

```
static NSTimeInterval kAnimationDuration = 0.3; 
@implementation JSDAnimationVC
```
在全局变量前加static, 全局变量就被定义成为一个全局静态变量（全局变量和静态全局变量的生命周期是一样的, 都是在堆中的静态区, 在整个工程执行期间内一直存在) 
而静态全局变量则限制了其作用域, 即只在定义该变量的源文件内有效, 在同一源程序的其它源文件中不能使用它。
 **特点如下：**
1. 存储区：静态存储区没变（静态存储区在整个程序运行期间都存在)。
2. 作用域：全局静态变量在声明他的文件之外是不可见的。准确地讲从定义之处开始到文件结尾。非静态全局变量的作用域是整个源程序（多个源文件可以共同使用)。

**相对全局变量优点:**
> 作用域只在原文件内, 不会影响到其他文件, 同理也不受其他文件影响。
> 避免其他文件重定义导致命名冲突。

* 修饰局部变量
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (NSInteger i = 0; i < 100; i++) {
        static int count = 10;
        count++;
    };
}
```

1. 延长局部变量的生命周期, 程序结束才会销毁。
2. 局部变量只会生成一份内存, 不管方法执行多少次, 其只会初始化一次。  
3. 存储区域从**栈**移动到**bbs**。

- 修饰函数

与修饰变量作用同理。

## const

const 表示常量, 被修饰之后的数据类型, 由变量转为常量, 其不可以被修改, 在编译阶段会执行检查, 其存储区域位于**常量区**, 常用于配合 static 或 extern 使用。

* 修饰全局静态变量

```
static const NSTimeInterval kAnimationDuration = 0.3; 
@implementation JSDAnimationVC
```

上面的全局变量表示的是动画执行时间, 虽然其不会受外部文件影响, 但是在内部文件是可以直接对其进行重新赋值的, 这明显不符合我们需求, 在变量前面加上关键字 **const**即可. 

kAnimationDuration 全局静态变量被修饰后变成全局静态常量, 其内存区域由 **bbs**移动到**常量区**。
* 修饰全局变量

**用法:**

```
extern NSString* const JSDLoginManagerDidLoginNotification;
@interface JSDLoginManagerVC : ViewController
@end
NSString * const JSDLoginManagerDidLoginNotification = @"JSDLoginManagerDidLoginNotification";
@implementation JSDCrashVC
```

包括在 .h .m 文件内声明的变量, 都属于全局变量, 除非 **@implementation** 作用域内声明的, 所以这些全局变量都有可能由外部进行访问, 并修改导致获取不到意料的结果, 我们可以使用 const 来对其限制。
当外部文件访问时需要使用关键字 **extern** 并且指明常量声明的类型来使用, 否则编译器默认以 **int** 类型来处理。应该是与运行时有关。
  
* 修饰局部变量

在**@implementation** 实现中, 方法实现内进行声明
主要用于修饰 C 或 OC 数据类型, 使声明的变量定义为常量。
下面列举下三种修饰写法, 导致不同的结果。
```
const NSString * name = @"Jersey";
使 *name 指针地址不可变, 实际指向内容不受影响, 修改指针地址编译器报错。
NSString const * name = @"Jersey";
同上面写法一致, 修饰了 name 指针地址使其不可变
NSString * const name = @"Jersey";
使 *name 指针指向内容不可变, 指针地址不受影响, 修改内容则编译报错。
```

**总结:**  const 修饰其后面内容

## extern

**这个单词翻译过来是"外面的, 外部的"。 顾名思义, 它的作用是声明外部全局变量。这里需要特别注意 extern 只能声明, 不能用于实现。**
当使用 extern 来声明变量时, 其会先在编译单元内部进行查找, 如果没有则继续到外部进行查找, 如果缺少实现并且使用到了此数据时会导致编译不通过。

**用法:**
* 使用其来声明供外部使用。

最常用也是最常见的实现一般是, .h 用 extern 修饰可供外部使用, .m 实现
```
extern NSString* const JSDLoginManagerDidLoginNotification;
@interface JSDLoginManagerVC : ViewController
@end
NSString * const JSDLoginManagerDidLoginNotification = @"JSDLoginManagerDidLoginNotification";
@implementation JSDCrashVC
```
* 使用其来声明引用外部全局变量等。

这种比较少见, 比如使用三方库时, 三方库定义了全局变量或常量, 但是并没有在 .h 用 extern 修饰其声明出来, 这时候如果我们想要去使用时, 可以直接在 .h 对其进行修饰即可直接使用
```
extern NSString* const JSDLoginManagerDidLoginNotification;
@interface JSDManager : NSObject
@end
```
主要配合关键字 **const** 使用, 类似用法一。

## define

简单说其实就是字符替换, 系统会在调用的地方进行文本替换, 可用于修饰数据, 函数, 结构体, 方法等, 系统不会对其做类型检查。

在预处理器里进行文本替换, 没有类型, 不做任何类型检查, 编译器可以对相同的字符串进行优化。只保存一份到 **.rodata** 段。甚至有相同后缀的字符串也可以优化, 你可以用 **GCC** 编译测试, **"Hello world"** 与 **"world"** 两个字符串, 只存储前面一个。取的时候只需要给前面和中间的地址, 如果是整形, 浮点型会有多份拷贝, 但这些数写在指令中。占的只是代码段而已, 大量用宏会导致二进制文件变大。

## define 与 const 选择

宏定义是在预编译期间处理, 在使用时系统直接进行的方法替换, 静态变量等则是在编译期间进行的。
宏定义不会系统不会做编译检查, 所以类型错误也能通过编译, const 则会做编译检查。 
能显式的声明数据类型, 并且不会出现自己定义的宏被其他人员更换,导致出现难以排查的 Bug。
不过宏不仅能对数据类型进行定义, 还能对函数, 结构体, 方法等进行定义相对比起常量来说作用会更多一些。

**总结**
1. 编译时刻：宏是预编译, const是编译阶段
2. 编译检查：宏不做检查, 有错误不会提示, const会检查, 有错误会提示
3. 宏的优点：高效,灵活,可用于替换各种 函数,方法,结构体,数据等;
4. 宏的缺点：由于在预编译期间完成, 大量使用宏, 容易造成编译时间久
5. const优点：编译器通常不为普通 **const** 常量分配存储空间, 而是将它们保存在符号表中, 这使得它成为一个编译期间的常量, 没有了存储与读内存的操作, 使得它的效率也很高, 相当于宏更加高效, 并且容错率很低。
6. const缺点：const 能定义的内容非常有限, 只能用于定义常量
7. 宏定义所定义的生命周期与所在的载体的生命周期有关
8. const修饰具有就近性, 即 **const** 后面的参数是不可变的, const修饰的参数具有只读性, 如果试图修改, 编译器就会报错
9. 苹果官方不推荐我们使用宏, 推荐使用const常量

**建议:**
在实际开发中, 对于能使用常量定义完成的, 尽量使用常量能实现, 而不要考虑使用 宏。
**读 [Effective Objective-C] 第四条: 多用类型常量, 少用 #define 与处理指令, 苹果也推荐我们在开发中尽量使用常量。**

## 最后

>希望此篇文章对您有所帮助，如有不对的地方，希望大家能留言指出纠正。谢谢！！！！！
学习的路上,与君共勉!!!
>>**本文原创作者:[Jersey](https://www.jianshu.com/u/9c6bbe968616). 欢迎转载，请注明出处和[本文链接](https://www.jianshu.com/p/c1714707c065)**

**参考**

[OC中关键字extern、static、const探究](https://www.jianshu.com/p/3fa703e80720)

[如何正确使用const,static,extern](https://www.jianshu.com/p/2fd58ed2cf55)

[iOS 宏(define)与常量(const)的正确使用](https://www.jianshu.com/p/f83335e036b5)



