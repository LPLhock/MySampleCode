# Yolo iOS 对接资料

[toc]

## 简介

项目主要使用 Objective-c 编写, 不包含任何 Swift 语言, 三方库一致使用 CocoaPod 进行管理, 代码托管于 [码云](https://gitee.com/yzhchain/yoloim-ios) 平台。  当前支持 iOS 8.0.0 以上版本。
项目代码编写模式主要采用: MVC 模式, 如包含业务逻辑复杂等页面可采用 MVVC.

**网络架构**: **AFNetworking**
**页面跳转架构**: 使用路由进行管理, 对 **[JSRouter](https://github.com/joeldev/JLRoutes)** 上进行封装管理. 
**数据解析**: **[MJExtension](https://github.com/CoderMJLee/MJExtension)**  
约束屏幕适配: 主要使用 Xib AutoLayout 进行约束, 包括  Masonry, 核心聊天模块基本使用原生的 Frame 进行。
**聊天模块**:  使用云信提供的 **[NIMSDK_LITE](https://github.com/netease-im/NIM_iOS_UIKit)** , 官网[云信](https://yunxin.163.com/)
**代码规范**:  可参考此篇Blog [iOS Coding Style Guide 代码规范](https://www.jianshu.com/p/941389de03d6) 
**H5 交互**: 采用 WKWebView 加载 H5. 与 JS 交互采用 **WKUserContentController** 进行。
**数据统计**: 友盟

### 1. 项目集成

代码托管于: [码云](https://gitee.com/yzhchain/yoloim-ios)

1. 克隆项目.
2. 通过命令行先安装 CocoaPod.
3. 执行命令  pod install 等待项目三方库安装即可。 
4. 如遇到 CocoaPod 失败等原因 自行搜索替换 Ruby 源 [RubyGems source 域名变更https://gems.ruby-china.com/](https://www.jianshu.com/p/1f4a49127997)

### 2. 项目模块介绍

代码模块文件都包含在 Classes 内.
分别包含 7 大模块
1. Modules: 包含 Yolo TabBarItem 的 5 个模块外, 每个模块分别一个文件夹, 文件夹名称均对应相应模块. 另外包含  **UserAccount** 表示: 管理用户账户等相关信息.  **Launch**: 项目启动模块 
2. Public: 主要包含经常被复用, 提供使用的相应的组件里面的文件大多数会 #import 到 PCH 内, 使用时不需要额外引入。
3. Resources: 主要包含一些三方资源相关等文件。
4. BaseKit: 针对项目需求自行封装的类。
5. Base: 自行继承的基类,  YZHBaseViewController。
6. CategoryTool: 对系统相关类进行的分类封装等。
7. Debug: 真机运行在 Debug 模式下进行摇一摇时弹出相应的 提供测试配置的 服务器, 云信Key 等等信息。在 Relese 下会自动关闭.
8. 服务器相关配置参考:  Info.plist 文件

### 3. 代码规范

1. 项目内页面跳转请仔细参考 Classes -> Public -> Router 下面相关文件。 采用路由的架构方式来进行页面跳转。 
2. 普遍采用 MVC 的架构模型, ViewController 有一套相应的 Code template 参考 **[iOS 文件模板(.xctemplate)ViewController.m](https://www.jianshu.com/p/ba25d0211443)** 自行配置。
3. 文件, 类名, 分类等必须一直遵守 **YZH** 开头. 请保持一致。
4. 更详细的请参考这边 Blog [iOS Coding Style Guide 代码规范](https://www.jianshu.com/p/941389de03d6) 

### 4. 相关平台账号等资料

**App Store**
账号: shouming.wang@yzhchain.com
密码: YZHblock369
安全码: lalk-tqcr-ixkl-beoo

**网易云信 NIM**
账号：jianzhangup@163.com
密码：fighting1988**

**友盟 UMSDK**
账号: yzhchain
密码: 0okm9IJN

### 5. App 上传App Store 

1. 证书从 Apple Developer 均做好配置之后。 除开发, 生产证书外 包含推送证书。
2. 使用 Xcode Product -> Archive 进行打包即可. 
3. 打完完成之后, 将其上传到 App Store 上。
4. 到 Apple 开发者页面管理上, 按要求填写相应选项即可上传。

说明: 审核一般短则  1-2 天, 长则 3-7 天等.  普通 2 - 3 天左右。
防止审核被拒: 最好多参考一下审核指南介绍来进行规避。

### 6. git 代码管理规范
 
1.  git log 可查看历史提交记录
2.  主要使用 git flow 的模式来进行管理。
3.  git commit 要遵守历史提交规范来进行。 
4.  如     
fix #295, 修改群公告

    1. 修改群公告展示内容颜色。
    2. 修改群公告删除逻辑。

标题可以概括此次提交内容信息. 
然后在分别简要的概括此次分别提交的内容简介。
这样方便未来追溯相关问题等等。




