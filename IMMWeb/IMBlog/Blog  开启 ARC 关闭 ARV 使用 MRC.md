# iOS, Xcode 关闭 MRC

ARC 是 Apple  WWDC 2011 年提出的解决内存管理的机制, 使用其来替代 MRC.

现在项目创建默认都是对所有文件开启了 MRC 机制, 但是有时候我们在使用其他库或者很久以前别人写的模块的时候可能会发现其使用的是 MRC 机制.  里面会有很多  retain release 等调用.   所以导致项目编译期间就会报错.  因为在 ARC 下系统不允许使用这些 内容管理关键字, 系统会通过 runloop + runtime 自动帮我们插入相应代码段. 

解决 Xcode  某些文件使用 MRC 方法, 到 Project -> Build Phases  -> Compile Sources 找到相应文件, 然后在 Compile Flags 添加相应关键字 : **-fno-objc-arc**  即可.

如果想要在 MRC 模式下开启 ARC 则是 **objc-arc**

 Project -> Build Settings 搜索关键字:automatic  即可看见 Xcode 是默认启动 ARC 的.  关闭之后项目相当于使用 MRC, 如果想对单个文件使用 MRC 的话类似上面说的, 添加  Flags : **-fobjc-arc** 


