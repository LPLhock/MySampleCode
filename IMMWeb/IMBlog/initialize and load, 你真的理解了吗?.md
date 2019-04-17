#initialize and load, 你真的理解了吗?



##initialize:     
原理：可以理解为懒加载的初始化方法、 当项目运行时、类第一次接收到消息的时候， 首先去先去调用父类的此方法，然后顺着在调用子类、在到分类。   加入子类没有实现此方法的时候，会多次触发 父类调用此方法 。  所以 如果我们为了避免父类 多次重复调用此方法时，  可以在此方法中加一个判断。  如果非类则 进行....、否则。。。 这样可以有效得避免多次重复的调用。 
实际应用：一般这个方法里面可以写 一些 初始化 属性、一个类里面有一个 字典或者 数组等、 我们可以在里面写 这个数组 或者 字典的 初始化。   还可以写一些 想要在 此类 初始化之前 应该设置的一些 对应 配置 等等 …..     此方法是在 主线程中调用的 

##load:  
原理：此方法会在项目运行前就会调用了 、 调用顺序会按照 项目文件里的 Build Phases ——> Compile Sources  依次往下执行、  并且每个类只会执行 依次 。   我们也可以理解成这个 方法 肯定会在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions  此方法前就会运行了 。  
然后 也是同样的 子类首先去会调用父类方法。 然后依次执行下来、  父类 到 子类 然后 才到分类 。  不想 initialize那样、 分类会把子类给覆盖掉。   但是此方法 不管如何 它只会运行一次！！！
实际应用 ：  由于这个方法是处于项目运行前 就会执行的 、所以说环境可能跟我们平时写代码不太一致。   可能很多类 还处于nil 的状态 、 所以为了避免出错，我们最好不要在此类里面添加什么逻辑。    我们可以在此方法里面 写一些 添加通知、  方法交换、 等 。  因为他的运行时机特别早、  可以确保我们在使用到此类的时候 、  我们 添加的通知 以及 进行的方法交换 肯定是 已经执行好的了！！！  

##load使用示例

load使用示例1, 见 @sunnyxx 大神的博客 Notification Once, 用于给 AppDelegate 瘦身。
load使用示例2, 见博客 Method Swizzling 和 AOP 实践, 在UIViewController的 +load 时期执行IMP替换，实现AOP。

## initialize:

可以用来执行懒加载, 比如这个类里面包含一些静态容器, 可以把其数据初始化写到这里来进行。

## 参考: 
[liumh](http://liumh.com/2015/07/29/ios-load-and-initialize/)   [stackoverflow](https://stackoverflow.com/questions/13326435/nsobject-load-and-initialize-what-do-they-do)

