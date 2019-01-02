//
//  JSDOperationQueue.m
//  JSDNetworkRequest
//
//  Created by Jersey on 2019/1/2.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDOperationQueue.h"

@interface JSDOperationQueue()

@end

@implementation JSDOperationQueue

- (instancetype)initWithName:(NSString *)name {
    
    self = [super init];
    if (self) {
        [self setName:name];
        [self setMaxConcurrentOperationCount:1];
        _downloadingOperations = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
