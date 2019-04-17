# CocoaSocket 源码分析 学习笔记

[toc]

## GCDAsyncSocket   init
```
- (id)initWithDelegate:(id)aDelegate delegateQueue:(dispatch_queue_t)dq socketQueue:(dispatch_queue_t)sq
```
此方法是**GCDAsyncSocket**最终调用初始化方法。
```
dispatch_queue_set_specific
dispatch_queue_get_specific
```
其使用这两个 API 来对队列 socketQueue 进行管理。


## connect

```
//多一个inInterface，本机地址
- (BOOL)connectToHost:(NSString *)inHost
               onPort:(uint16_t)port
         viaInterface:(NSString *)inInterface
          withTimeout:(NSTimeInterval)timeout
                error:(NSError **)errPtr
```
stateIndex 使用这个状态与  ipv4 ipv6 进行 socket 连接, 此 stateIndex 不知道是表示什么的。

 



