//
//  JSDOperationQueueManage.m
//  JSDNetworkRequest
//
//  Created by Jersey on 2019/1/2.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDOperationQueueManage.h"

static id instance;

@interface JSDOperationQueueManage()

@property (nonatomic, strong) NSMutableDictionary* operationQueues;

@end

@implementation JSDOperationQueueManage

+ (instancetype)sharedOperationQueueManage {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[JSDOperationQueueManage alloc] init];
        }
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _operationQueues = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (JSDOperationQueue *)configurationQueueWithKey:(NSString *)key {
    
    JSDOperationQueue* operationQueue = [self.operationQueues objectForKey:key];
    if (!operationQueue) {
        operationQueue = [[JSDOperationQueue alloc] initWithName:key];
    }
    
    return operationQueue;
}

@end
