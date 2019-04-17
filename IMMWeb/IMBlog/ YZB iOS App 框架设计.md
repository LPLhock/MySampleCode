#  YZB iOS App 整体框架设计

参考: [iOS应用架构谈 view层的组织和调用方案](https://casatwy.com/iosying-yong-jia-gou-tan-viewceng-de-zu-zhi-he-diao-yong-fang-an.html)
[猿题库 iOS 客户端架构设计](http://gracelancy.com/blog/2016/01/06/ape-ios-arch-design/)  结合 MVC 与 MVVM 取其精华 弃其糟粕.
[浅析 iOS 应用网络层设计](https://skyline75489.github.io/post/2016-3-13_ios_networking_layer_design.html) 
[iOS应用架构谈 网络层设计方案](https://casatwy.com/iosying-yong-jia-gou-tan-wang-luo-ceng-she-ji-fang-an.html)
[iOS 视图控制器转场详解](http://blog.devtang.com/2016/03/13/iOS-transition-guide/)
##  文件模块划分规则

 文件模块划分主要还是以 App 涉及的 TabBarIterm 来进行划分, 然后如果还有一些相应的大的功能, 被 Iterm 包含在内的, 可以单独在创建一个文件夹管理, 其文件 Level 与 Iterm 平级. 除了这些大功能的模块外, 至少还会包含 Public. Tool. BaseClass. Object. BaseKit。  
 
* Public: 其是一个公共文件夹, 这里可以添加一些 定义的宏文件, PCH 文件. 一些项目共享经常使用到的功能。
* Tool : 其实一个包含工厂模式的类文件.
* BaseClass : 封装的基类文件。
* Object : 针对具体业务场景封装出来的对象. 但是其又不单单服务于某一个页面等等, 可以放到此, 方便管理 与 其他模块用来复用。
* BaseKit : 针对工具的封装, 比如 Button. Label等。 
* Fundation : 针对系统类的封装
* Router :  路由相关业务封装
* DateService :  网络层封装
* Debug :  调试等业务

##  代码层设计模式

 主要采用: MVC设计模式, 如出现某个页面业务过于复杂导致 C 层, 代码过于冗余, 可采用 MVVM 模式编写.   或者 MVP 等。。

##  代码层必须遵守的规范

 1. C 层有明确的代码 #Pragma mark -- 标明顺序,  以及调用顺序模板。
 2. 后续在定制相关规范文档

##  项目管理工具

1. Git
2. CocoaPod 管理 三方框架

##  任务进度管理

后续找一个项目进度管理工具, 将每次任务进度在上面进行一个划分和明确的管理.  
提高工作效率同时达到实时监控项目进度的效果

##  Git issues commit 等规范

 基本采用 Git-Flow 机制来进行. 
 默认 master 受保护分支 : 必须要等发版成功之后才将代码进行合并
 开发分支 developer : 每次开发都是从 developer 分支进行
 发布分支 release : 用于发布/等 developer 相关任务开发完之后合并到此来进行发布。
 
 每个分支必须以  issues编号-父分支名-相应功能点-name
 
 除了这三个分支外, 还可以创建一些后续版本等指定的分支。根据具体场景需求而定。
 
 issues 格式: Title: 主题即可. Description : 具体业务细分,明确说明。
 commit 格式: 根据每次创建的 issues 找到指定编号. 以这种格式来提交
 fix #509, 修复自动投资Bug 主题 
 换行
 1. 
 2.
 相应内容。
 

##  设计原则


##  需要思考的点归纳

1. 业务埋点统计.
2. 推送服务服务器选择与搭建?
3. 数据传输结构选择.
4. 项目崩溃率统计,跟踪 三方选择.
5. 项目上架审核问题.
6. 适配版本与型号等.
7. 防止过度架构,过度设计,不能因为架构而去架构.
8. 数据传输安全问题.
9. 本地数据存储的架构设计.这个非常重要！
10. 免密登录设计.

参考资料: [iOS 开发技术栈与进阶](https://blog.cnbang.net/tech/3354/)
[做一个 App 前需要考虑的几件事](http://www.cocoachina.com/ios/20161025/17849.html)
[onmyway133/fantastic-ios-architecture 设计模式架构思想汇总](https://github.com/onmyway133/fantastic-ios-architecture)
[老码农冒死揭开行业黑幕：如何编写无法维护的代码](http://blog.jobbole.com/80241/)
[不错开源项目, 框架学习](https://www.zhihu.com/question/26292022)
[再看知名应用背后的第三方开源项目](http://www.cocoachina.com/ios/20141017/9955.html)
[一个海量在线用户即时通讯系统（IM）的完整设计](https://mp.weixin.qq.com/s/Wa0u_ShRQ5_3jAD78i4nDQ)
## 当前疑问点

1. SmallTalk 选择
2. XMPPFrame
3. 客户端建立 长连接时机, 进入群聊 私聊什么时候发起连接最恰当。
4. 存储框架设计
5. 通讯间信息 是否需要加密,  HTTPS 建立连接通讯信息加密?
6. 短信验证问题 解决方案。



1. 本地服务器调试完成. 项目网络层框架搭建.完成一半
2. 今天继续做网络层框架搭建。 


 

