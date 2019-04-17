# UIButton 等响应事件无法正常传递.

1.  userInteractionEnabled
2.  响应链,  frame
3. UIButton不能点击情况的第三种是，你在button上添加了一个View，然后这个View能响应事件。但是这个View并没有响应的点击触发事件。所以当你在点击button的时候，是将触发事件传递给View，而button本需要触发的事件则被忽略了。解决办法是，让添加的这个View的userInteractionEnabled设为NO即可。 --------------------- 本文来自 walkerwqp 的CSDN 博客 ，全文地址请点击：https://blog.csdn.net/walkerwqp/article/details/78771219?utm_source=copy 

