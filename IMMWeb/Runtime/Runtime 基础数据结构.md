# Runtime 基础数据结构


## 简介
![runtime](https://img.mukewang.com/szimg/5ae49a510001eb6119201080.jpg)
![](https://img.mukewang.com/szimg/5ae49b090001416419201080.jpg)

## Objc_object 结构体

id = objc_object 


![objc_object](https://img.mukewang.com/szimg/5ae5591c00015b0919201080.jpg)

## objc_class 结构体

Class = objc_class

![objc_class](https://img.mukewang.com/szimg/5ae56f7400010ad619201080.jpg)

## isa 指针

C++ 里面的共用体 isa_t

共用体为 32 位 或 64 未 0和1,
包含**指针型**与 **非指针型**。

* 64 位
指针型 64位则表示 isa 的值代表 Class 地址。
非指针型  isa 的部分值代表 Class 的地址

* 32 位
指针型
非指针型


![isa](https://img.mukewang.com/szimg/5ae57ece00010c4319201080.jpg)

## isa 指向

* 对象
  指向其类对象.
* 类对象
  指向其元类对象.



## cache_t

![cache_t](https://img.mukewang.com/szimg/5ae5cf3b0001b49f19201080.jpg)

方法缓存,

* 主要用于快速查找执行函数。
* 可增量扩展的哈希表结构
* 是局部性原理的最佳应用

其实一个数组, 里面包含了 backet_t 的数据结构,  backet_t 其实就是一个哈希表, key 为 方法选择器 , Value 为方法实现 IMP 无类型函数指针。


## 局部性原理



## class_data_list_t

![](https://img.mukewang.com/szimg/5ae5d48c0001b0ea19201080.jpg)

主要是对 class_rw_t 的封装
## class_rw_t （readwrite）

其主要代表了类相关的读写相关信息, 其又是对 class_ro_t 的封装

![rw](https://img.mukewang.com/szimg/5ae5d54f0001daf519201080.jpg)

相对 or 多了  protocols 与 properties, methods. 因为其就是相当于一个分类一样。 所以我们分类能添加 协议, 属性, 方法等。 

protocols 与 properties, methods 都是list_array_tt   二维数组。

## class_ro_t  (readonly)

代表类的相关只读信息

![ro](https://img.mukewang.com/szimg/5ae5d75700016c8b19201080.jpg)

 *  name 类名
 *  ivars 实例变量
 *  properties
 *  protocols
 *  methodList

其  ivars 实例变量,properties,protocols,methodList 都是一维数组



## method_t

对方法的抽象说明

![method](https://img.mukewang.com/szimg/5ae5d9960001bb6619201080.jpg)


## Type Encodings

const* chat types   其是 Apple 对于函数返回值与参数的一种编码方式。



## 整体数据结构

![](https://img.mukewang.com/szimg/5ae5dbfa0001445819201080.jpg)



## 参考
[](https://draveness.me/isa)

[](https://developer.apple.com/documentation/objectivec/objective-c_runtime?language=objc)
[](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html?language=objc#//apple_ref/doc/uid/TP40008048)

