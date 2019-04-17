# SetValue forKey  setValue forPath valueForKeyPath 与valueForKey


## setValue:forKey 与 valueForKey; valueForKeyPath:

针对 steValue 与 value

其是一对键值对编码的读与写方法.  主要是 NSObject 对象 Category   Foundation 框架下 NSKeyValueCoding.h 实现, 
所以所有继承与 NSObject 的对象都已经实现好了这个方法. 
调用之后会直接调用我们写的 get setter 方法
注意在 setValue forKey 中, 如果没有相应 key, 也就是此对象没有这个实例, 则会继续调用- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key  并Crash。
我们也可以通过重写此方法来进行拦截. 
value : 可以为 nil。
Key: 不可以为 nil
NSNull Null 为 NULL 对象, 并不是 nil。

## setObject:forKey 与 objectforKey

其是 Dictionary 实现的其类似 上述,

只不过 object 可以指向任何对象。

如果 setobject:forKey 其中 object 其中 object不可以为空否则报错, 因为字典无法存储空对象。

如果其调用 setvalue:forKey  value  为空时会自动调用 removeObject:forKey 并且报错.



## key 与 keyPath

除了可以通过  key 访问外, 我们还可以通过 keyPath的方式来进行访问.  其原理也就是可以依次的根据 keyPath 逐层向下对去.

比如字典里面的某个 value 包含是一个 字典, 我们可以通过  key.key 的方式依次访问下去。

其应该还是通过调用 valueForKey 的方式依次向下调用吧。  

[setValue和setObject的区别](https://blog.csdn.net/itianyi/article/details/8661997)
[stackoverFlow](https://stackoverflow.com/questions/4489684/what-is-the-difference-between-valueforkey-objectforkey-and-valueforkeypath)

[高效开发iOS -- 那些不为人知的KVC](https://www.jianshu.com/p/a6a0abac1c4a)
[IOS开发之——objectForKey与valueForKey在NSDictionary中的差异](https://blog.csdn.net/pjk1129/article/details/7572212)

