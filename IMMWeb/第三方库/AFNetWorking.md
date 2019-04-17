# AFNetWorking

## 框架简介

* 回话: NSURLSession
* 网络监听:
* 网络安全: 
* 请求与相应序列化: 
* UIKit 模块
## 主要关系图
![AEwmrV.jpg](https://s2.ax1x.com/2019/03/15/AEwmrV.jpg)

## 核心类 AFURLSessionManage

其包含 NSURLSession, AFSecurityPolicy, AFNetworkReachabilityManager, 数据序列化等属性, 
然后 我们一般使用 AFHTTPSession 来进行网络请求其是继承关系. 

## AFHTTPSessionManage

* 负责创建和管理 Session, NSSessionTask
* 实现了 NSURLSessionDelegate 相关方法/
* 引入 AFSecurityPolicy  保证应用安全
* 引入 网络监听模块. 

