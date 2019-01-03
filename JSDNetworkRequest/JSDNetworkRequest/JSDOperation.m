//
//  JSDOperation.m
//  JSDNetworkRequest
//
//  Created by Jersey on 2019/1/2.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDOperation.h"

static NSTimeInterval kJSDTimeoutIntervalOperation = 30.0f; //默认超时时间

@interface JSDOperationItem()


@end

@implementation JSDOperationItem

- (instancetype)initWithUrlString:(NSString *)urlString pathToSave:(NSString *)pathToSave infos:(NSDictionary <NSString *, id> *)infos taskName:(NSString *)taskName {
    
    self = [super init];
    if (self) {
        _urlString = urlString;
        _pathToSave = pathToSave;
        _infos = infos;
        _taskName = taskName;
        _progress = 0;
    }
    return self;
}

@end

@interface JSDOperation()<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession* urlSession;
@property (nonatomic, strong) NSURLSessionTask* sessionTask;
@property (nonatomic, assign) BOOL isCompletiom;
@property (nonatomic, weak) NSOperationQueue* operationQueue; //防止循环引用

// 因这些属性是readonly, 需要重写来否则无法直接调用 get 方法。
@property (assign, nonatomic, getter=isExecuting) BOOL executing;
@property (assign, nonatomic, getter=isFinished) BOOL finished;
@property (assign, nonatomic, getter=isCancelled) BOOL cancelled;

@end //

@implementation JSDOperation

@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize cancelled = _cancelled;

- (instancetype)initWithOperationItem:(JSDOperationItem *)item onOperationQueue:(NSOperationQueue *)operationQueue {
    
    self = [super init];
    if (self) {
        _operationItem = item;
        
        [self setupURLSession];
        
        _operationQueue = operationQueue;
        self.queuePriority = NSOperationQueuePriorityNormal; //设置队列优先级为默认.
        
        self.name = [NSString stringWithFormat:@"TaskURL: %@", item.taskName];  //任务名字
        
        self.finished = NO;
        self.cancelled = NO;
    }
    return self;
}

- (void)start {
    
    NSLog(@"开始请求数据:%s %@", __func__, self);
    // 必须设置finished为YES, 不然也会卡住
    if ([self checkCancelled]) {
        return;
    }

    self.executing  = YES;
    
    [self main];
}

- (void)main {
    
    if ([self checkCancelled]) {
        return;
    }
    [self startDownload];
    
    while (self.executing && !self
           .isFinished) { //通过 RunLoop 使不断循环, 直至下载任务完成.
          [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    //同理
//    while (self.executing) {
//        if ([self checkCancelled]) {
//            return;
//        }
//    }
}

- (BOOL)checkCancelled
{
    if (self.cancelled) {
        self.finished = YES;
        return YES;
    }
    
    return NO;
}

- (void)startDownload
{
    [self.sessionTask resume];
}

- (void)requestDone {
    
    NSLog(@"当前任务执行完成:%@", self.name);
    [self.urlSession finishTasksAndInvalidate];
    self.urlSession = nil;
    self.isCompletiom = YES;
    
    self.executing = NO;
    self.finished = YES;
}

#pragma mark -- Setup Confign

- (void)setupURLSession {
    
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.urlSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:_operationQueue];
    NSURL* url = [NSURL URLWithString: self.operationItem.urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:kJSDTimeoutIntervalOperation];
    
    self.sessionTask = [self.urlSession downloadTaskWithRequest:request];
    self.sessionTask.taskDescription = self.operationItem.urlString;
}

- (void)failToDownload
{
    [self cancel];
    
    self.operationItem.finished = NO;
    self.operationItem.progress = 0.f;
}

#pragma mark -- NSURLSessionDelegate
//下载任务完成时回调
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.operationItem.pathToSave]) {
        [fileManager removeItemAtPath:self.operationItem.pathToSave error:nil];
    }
    
    NSURL* fileUrl = [NSURL fileURLWithPath: self.operationItem.pathToSave];
    NSError* error = nil;
    [fileManager moveItemAtURL:location toURL:fileUrl error:&error];
    
    if (!error) {
        NSLog(@"下载完成,并且文件保存成功 %@ -- 文件保存路径:%@", self.name, fileUrl.path);
    } else {
        NSLog(@"保存文件失败");
        //执行相应任务
    }
    
    // 下载完成通知到任务相关类
    BOOL isDownCompletion = [fileManager fileExistsAtPath:self.operationItem.pathToSave];
        
    self.operationItem.finished = isDownCompletion;
    if (isDownCompletion) {
        [self requestDone];
    }
    
}
//回调正在下载的文件完成进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    
}

//检测是否在下载过程中失败
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (!error) {
        return;
    }
    
    NSLog(@"网络请求错误: %@", error.localizedDescription);
    switch (error.code) {
        case -999: // 取消
        case -1001:{
            //超时重试
            NSLog(@"请求超时, 请重试");
            
        }
            break;
            
        default:
            //
            break;
    }
    
}

@end
