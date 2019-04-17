# 奇怪的试图控制器 Xib 问题


当从某个控制器 Present 出一个新控制器时, 就会报错. 

skpiToViewController:parameters:] <YZHCommunityViewController: 0x7f8520d0fe20> ---> <YZHLoginViewController: 0x7f8520f05a30>
2018-09-17 11:25:20.987865+0800 YZHYolo[25878:914985] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '-[UIViewController _loadViewFromNibNamed:bundle:] loaded the "YZHLoginView" nib but the view outlet was not set.'
*** First throw call stack:

 错误原因也是醉了,   我创建了 YZHLoginView Xib 文件, 然后好像自动跟 此控制器自动绑定在一起了一样。   删掉之后就可以运行。
 
 
 [Xib 加载](https://blog.csdn.net/u011723466/article/details/25241927)
 [Xib 剖析](https://blog.csdn.net/donhao/article/details/7088446)


