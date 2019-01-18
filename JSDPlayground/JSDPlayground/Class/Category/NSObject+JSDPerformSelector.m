//
//  NSObject+JSDPerformSelector.m
//  JSDPlayground
//
//  Created by Jersey on 2019/1/12.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "NSObject+JSDPerformSelector.h"

@implementation NSObject (JSDPerformSelector)

- (id)jsd_performSelector:(SEL)aSelector withObjects:(NSArray*)objects {
    
//    https://juejin.im/post/5a30c7c151882503eb4b44e2
    NSMethodSignature* methodSignature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (methodSignature) {
        /*
         (lldb) po invocation
         <NSInvocation: 0x600003dd0680>
         return value: {v} void
         target: {@} 0x7f847e437860
         selector: {:} eatBreakfast:luncheon:dinner:
         argument 2: {@} 0x0
         argument 3: {@} 0x0
         argument 4: {@} 0x0
         */
        // NSInvocation 主要包含, 消息接受者, 方法名, 参数,返回值。
        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        
        //签名中方法参数的个数，内部包含了 self和_cmd，所以参数从第3个开始
        NSInteger signatureParamCount = methodSignature.numberOfArguments - 2;
        NSInteger requireParamCount = objects.count;
        NSInteger resultParamCount = MIN(signatureParamCount, requireParamCount);
        for (NSInteger i = 0; i < resultParamCount; i++) {
            id  obj = objects[i];
            [invocation setArgument:&obj atIndex:i+2];
        }
        //开始执行
        [invocation invoke];
        
        id callBackObject = nil;
        if (methodSignature.methodReturnLength) {
            [invocation getReturnValue:&callBackObject];
        }
        
        return callBackObject;
    } else {
        
        @throw [NSException exceptionWithName:@"抛出异常" reason:@"方法名有误" userInfo:nil];
    }
}

@end
