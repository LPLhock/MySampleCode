//
//  JSDOperationQueueManage.h
//  JSDNetworkRequest
//
//  Created by Jersey on 2019/1/2.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSDOperationQueue.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSDOperationQueueManage : NSObject

+ (instancetype)sharedOperationQueueManage;

- (JSDOperationQueue* )configurationQueueWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
