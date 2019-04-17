# 深度剖析 Weak 实现机制, 延展 Strong copy

参考: [iOS 底层解析weak的实现原理（包含weak对象的初始化，引用，释放的分析）](https://www.jianshu.com/p/13c4fb1cedea)
     [runtime 如何实现 weak 属性](https://dayon.gitbooks.io/-ios/content/chapter8.html)


##Weak 实现原理的概括

runtime 维护一个 weak 表, 主要用于存储某个对象的 weak　指针, weak 表其实是一个 Hash 表, key 表示对象的地址, value 表示 weak 指针的地址(这个地址的值是所指向对象指针的地址).

##weak 的实现原理可以概括一下三步






