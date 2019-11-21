//
//  JSDMessageForwarding.m
//  JSDPlayground
//
//  Created by Jersey on 19/11/2019.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDMessageForwarding.h"

@implementation JSDMessageForwarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {

    NSMethodSignature* signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];

    
    NSLog(@"转发处理方法签名%@",self.class);
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

    NSLog(@"转发处理方法选择子");
}

+ (void)zexige {
    
    NSLog(@"hahazexidao");
}

@end
