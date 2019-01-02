//
//  JSDOperation.h
//  JSDNetworkRequest
//
//  Created by Jersey on 2019/1/2.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark -- 请求任务对象

@interface JSDOperationItem : NSObject

// Additional information, such as number, type etc.
@property (nonatomic, copy)     NSDictionary <NSString *, id> *infos;
@property (nonatomic, copy)     NSString    *urlString;
@property (nonatomic, copy)     NSString    *pathToSave;
@property (nonatomic, assign)   CGFloat     progress;
@property (nonatomic, copy)     NSString*   taskName;
@property (nonatomic, assign)   BOOL        finished;
@property (nonatomic, assign)   BOOL        cancelled;

- (instancetype)initWithUrlString:(NSString *)urlString pathToSave:(NSString *)pathToSave infos:(NSDictionary <NSString *, id> * _Nullable)infos taskName:(NSString *)taskName;

@end

#pragma mark -- 处理任务对象

@interface JSDOperation : NSOperation

@property (nonatomic, strong) JSDOperationItem* operationItem;

- (instancetype)initWithOperationItem:(JSDOperationItem *)item onOperationQueue:(NSOperationQueue *)operationQueue; // 便利构造方法

@end

NS_ASSUME_NONNULL_END
