# iOS 关键字 #pragma  忽略 警告

 
	1.	#pragma clang diagnostic ignored "-W警告名”   
	2.	例如针对代码中有没有使用过的变量系统会提示Unused variable 'variable',这是就可以使用'-Wunused'或者'-Wunused-variable'来忽略该警告! 
	3.	#pragma clang diagnostic ignored "-Wdeprecated”    可以忽略 API版本警告 问题 
	4.	#pragma clang diagnostic push   
	5.	#pragma clang diagnostic ignored "-Wdeprecated"   
	6.	    [NSURLConnection connectionWithRequest:request delegate:self];   
	7.	#pragma clang diagnostic pop       下面这个是 分段 忽略、 

补充、 
#pragma clang diagnostic push 
#pragma clang diagnostic ignored “”    此警告相对应的 常量
#pragma clang diagnostic pop 

此篇文章 包含挺完整的Clang API 对应 警告 常量值 
http://fuckingclangwarnings.com/


在工程中有警告的地方，右键选择Review in log，然后就能看到类似[Wnonnull]这样的警告， 

然后在工程buildSettings中的Other Warning Flags中添加 -Wno-nonnull就可以去掉这种类似的警告了。
规则为：-Wno-类型
	1.	#error This is a error   
	2.	
	3.	 
	4.	#warning this is a warning   
	1.	
	2.	 

## 参考

[iOS中#pragma的使用](http://blog.csdn.net/willluckysmile/article/details/53571954)


