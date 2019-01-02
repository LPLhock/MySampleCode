//
//  JSDOperationQueue.h
//  JSDNetworkRequest
//
//  Created by Jersey on 2019/1/2.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDOperationQueue : NSOperationQueue

- (instancetype)initWithName:(NSString *)name;
@property (nonatomic, strong) NSMutableDictionary *downloadingOperations; //可用于保存已添加任务, 如需自行管理任务则可使用.

@end

NS_ASSUME_NONNULL_END
