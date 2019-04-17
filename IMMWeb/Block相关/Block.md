# Block


# 简介

Block 是将函数及其执行上下文封装起来的对象
使用 clang -rewrite-objc 查看 编译成 C++ 源码实现,


## 如何封装

Block 实际上是一个 类似对象的 obje_object 的结构体, 
里面包含 isa 指针  Flags 和 一个函数指针, 此函数指针即是 block 的实现代码封装。
```
struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};
```
所以说 block 实际上是一个对函数进行封装的对象。 真正是一个结构体。

当我们声明一个 block 时, 系统会声明一个我们同名的 block 结构体,  里面还会包含捕获变量等参数

## 截获变量

我们都知道 block 有截获变量的特性, 但是其又对不同类型的变量有不相同的截获方式。
* 对于基本数据类型只会截获其 值
* 对于对象类型的局部变量则会连同所有权修饰符一起截获
* 以指针形式截获静态变量
* 对全局静态以及全局变量不做截获。

### 局部变量

* 基本数据类型
* 对象类型

### 静态局部变量

### 全局变量

### 静态全局变量


### __block 修饰符(栈声明的 block)

* 一般情况下, 在对截获变量进行赋值操作时, 需要对其进行 __block 修饰. 因为这跟 Block 在封装实现对 变量引用的特性有关。
**赋值** != **使用**

* 无论其是基本数据类型, 还是对象类型,
* 对静态局部变量和静态变量和全局静态,都不需要进行修饰。 因为 block 对静态和全局者两个变量都没有做任何引用。 对 静态局部变量只是做了 地址引用。 不会对其做 修饰所有权引用。
* 当使用 __block 修饰时, 基本数据类型会变成对象。其内部会封装成一个类似对象的结构体, 会包含isa 指针等。 **栈 Block**

```
struct __Block_byref_block_number_0 {
  void *__isa;
__Block_byref_block_number_0 *__forwarding;
 int __flags;
 int __size;
 int block_number;
};
```

## __forwaiding 指针作用(疑惑)

无论在什么位置, 都可以使用其来访问。
由于在栈上 block copy 时则会到 堆上。
其都可以顺利的访问同一个 __block 变量

## block 的类型

impl.isa = &_NSConcreteStackBlock;

* extern "C" __declspec(dllexport) void *_NSConcreteGlobalBlock[32];
* extern "C" __declspec(dllexport) void *_NSConcreteStackBlock[32];
* _NSConcreteMallocBlock

主要分三种, 全局,栈,堆。

## 不同类型 block 的 copy 操作。 


## 循环引用问题

当 self 持有此 block 时,  在block 内部如果使用到 self 相关, 或者 self 的 属性等等, 都会导致循环引用。 

由于 block 对于对象的截获特性, 其会截获对象类型的 修复所有权导致也会引入到 self

* __block 修饰导致循环引用问题
* 



