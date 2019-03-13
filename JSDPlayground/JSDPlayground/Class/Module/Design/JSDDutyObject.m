//
//  JSDDutyObject.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/13.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDDutyObject.h"

@implementation JSDDutyObject

- (void)handle:(resultBlock)resultBlock {
    
    completionBlock completionBlock = ^(BOOL handle) {
        if (handle) {
            return resultBlock(self, handle);
        } else {
            if (self.nextObject) {
                [self handle:resultBlock];
            } else {
                return resultBlock(NULL, NO);
            }
        }
    };
    
    [self handleDutyObject:completionBlock];
}

- (void)handleDutyObject:(completionBlock)completionBlock {
    
    
}

@end
