//
//  JSDDutyManage.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/13.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDDutyManage.h"

@interface JSDDutyObjectA : JSDDutyObject

@end

@implementation JSDDutyObjectA

- (void)handleDutyObject:(completionBlock)completionBlock {
    
    NSLog(@"我是任务 A,我已经完成了读取任务哦");
    completionBlock(YES);
    [super handleDutyObject:completionBlock];
}

@end

@interface JSDDutyObjectB : JSDDutyObject

@end

@implementation JSDDutyObjectB

- (void)handleDutyObject:(completionBlock)completionBlock {
    
    NSLog(@"我是任务 B,我已经完成了上传任务哦");
    completionBlock(YES);
    [super handleDutyObject:completionBlock];
}

@end

@interface JSDDutyObjectC : JSDDutyObject

@end

@implementation JSDDutyObjectC

- (void)handleDutyObject:(completionBlock)completionBlock {
    
    NSLog(@"我是任务 C,我已经完成了最终任务哦");
    completionBlock(YES);
    [super handleDutyObject:completionBlock];
}

@end

@interface JSDDutyManage()

@property (nonatomic, strong) JSDDutyObject* firstObject;

@end

@implementation JSDDutyManage

- (instancetype)init{
    
    if (self = [super init]) {
        
        _firstObject = [[JSDDutyObjectA alloc] init];
        JSDDutyObjectB* objectB = [[JSDDutyObjectB alloc] init];
        _firstObject.nextObject = objectB;
        JSDDutyObjectC* objectC = [[JSDDutyObjectC alloc] init];
        objectB.nextObject = objectC;
        
        return self;
    }
    return nil;
}

- (void)start {
    
    [self.firstObject handle:^(JSDDutyObject * _Nonnull object, BOOL handle) {
    }];
}

@end


