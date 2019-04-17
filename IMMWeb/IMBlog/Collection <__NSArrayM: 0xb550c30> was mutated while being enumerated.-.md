# Collection <__NSArrayM: 0xb550c30> was mutated while being enumerated.-

## 简介

在使用 for in 循环中去查找指定 object ,然后直到找到之后, 将其删除掉, 当 NSArray 超过一个之后, 或者这个 object 不属于最后一个下标, 然后执行了删除则会报错.

## 例如

```
NSMutableArray * arrayTemp = xxx; 

    NSArray * array = [NSArray arrayWithArray: arrayTemp];  

    for (NSDictionary * dic in array) {        

        if (condition){            

            [arrayTemp removeObject:dic];

        }       
    }
```


## 原因

当程序出现这个提示的时候，是因为你一边便利数组，又同时修改这个数组里面的内容，导致崩溃，网上的方法如下：

## 解决

使用 enumerateObjectsUsingBlock 来遍历
## 参考
[解决Collection <__NSArrayM: 0xb550c30> was mutated while being enumerated.-](https://blog.csdn.net/piaodang1234/article/details/11902541)

