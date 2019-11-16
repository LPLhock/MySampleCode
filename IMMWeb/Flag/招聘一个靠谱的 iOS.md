#招聘一个靠谱的 iOS


* 风格纠错题

* 优化部分

* 硬伤部分

* 什么情况使用 weak 关键字，相比 assign 有什么不同？

* 怎么用 copy 关键字？

* 这个写法会出什么问题： @property (copy) NSMutableArray *array;

* 如何让自己的类用 copy 修饰符？如何重写带 copy 关键字的 setter？

* @property 的本质是什么？ivar、getter、setter 是如何生成并添加到这个类中的

* @protocol 和 category 中如何使用 @property

* runtime 如何实现 weak 属性

* @property中有哪些属性关键字？/ @property 后面可以有哪些修饰符？

* weak属性需要在dealloc中置nil么？

* @synthesize和@dynamic分别有什么作用？

* ARC下，不显式指定任何属性关键字时，默认的关键字都有哪些？
    
  1. 基础数据类型: assign, atomic, readwrite;
  2. OC 对象: atomic,readwrite,strong

* 用@property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？如果改用strong关键字，可能造成什么问题？
  加入有可变类型的数据结构使用 Strong, 则会出现不确定性, 假如我们将一个可变对象赋值给这个不可变对象, 则此不可变对象会同时指向可变对象内存地址, 当这份可变对象变化时, 其内容跟着一块变化; 
  使用 copy 则会使其真正得到一份不可变的对象, 会先拷贝一份对象内容, 然后指针指向这份新的地址; 

* 对非集合类对象的copy操作

* 集合类对象的copy与mutableCopy

* @synthesize合成实例变量的规则是什么？假如property名为foo，存在一个名为_foo的实例变量，那么还会自动合成新变量么？

* 在有了自动合成属性实例变量之后，@synthesize还有哪些使用场景？

* objc中向一个nil对象发送消息将会发生什么？
  
  返回 0; 不会造成任何影响, weak 修饰的变量在释放之后系统会将其设置为 nil. 使其变得更安全, 防止出现野指针问题; 
  OC 方法调用在运行时, 会调用发送消息函数, 此函数会去先判断这个方法是实例方法还是类方法, 继而到该类去查找实现, 当发现此对象为 nil 时, 会直接返回; 

* objc中向一个对象发送消息[obj foo]和objc_msgSend()函数之间有什么关系？

* 什么时候会报unrecognized selector的异常？

* 一个objc对象如何进行内存布局？（考虑有父类的情况）

* 一个objc对象的isa的指针指向什么？有什么作用？

* 下面的代码输出什么？
* 
参考: [ChenYilong/iOSInterviewQuestions](https://github.com/ChenYilong/iOSInterviewQuestions)

