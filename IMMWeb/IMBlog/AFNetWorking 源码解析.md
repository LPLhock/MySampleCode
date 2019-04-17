# AFNetWorking 源码解析

[toc]
## AFURLSessionManage
### 概述: 
```
 `AFURLSessionManager` creates and manages an `NSURLSession` object based on a specified `NSURLSessionConfiguration` object, which conforms to `<NSURLSessionTaskDelegate>`, `<NSURLSessionDataDelegate>`, `<NSURLSessionDownloadDelegate>`, and `<NSURLSessionDelegate>`.
```
此类是 AF 的核心基类, 其包含一个 NSURLSession, 2.0 之前是基于 NSURLConnect 封装, 然后还包含一个 NSURLSessionConfiguration, 其准守 NSURLSession 的 *任务协议* *数据协议* *下载协议* *会话协议*。

### 网络请求的实现基于

*  ## NSURLSession & NSURLSessionTask Delegate Methods

 `AFURLSessionManager` implements the following delegate methods:
  ### `NSURLSessionDelegate` 
  ```
 - `URLSession:didBecomeInvalidWithError:`        
 - `URLSession:didReceiveChallenge:completionHandler:`
 - `URLSessionDidFinishEventsForBackgroundURLSession:`
  ```
  可以看到 AF 实现了 SessionDelegate **任务将要开始**, **正在接受数据**, **任务将要完成** 等方法。
  
  * ## NSURLSessionTaskDelegate
  * ## NSURLSessionDataDelegate
  * ## NSURLSessionDownloadDelegate

  AF 的网络请求主要基于 NSURLSession, 通过遵守协议实现其相应子类的协议, 在相应的代理方法中采用通知的方式来进行 任务回调。

### AF 在网络请求上还做了什么优化
 
 *  ## Network Reachability Monitoring 
    主要用于监听网络状况, 可以根据不同的网络状态来对请求任务作出相应暂停,退出等调整。
    
 *  ## NSCoding Caveats
 *  ## NSCopying Caveats

## AFHTTPSessionManage

