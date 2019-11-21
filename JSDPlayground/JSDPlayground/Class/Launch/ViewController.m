//
//  ViewController.m
//  JSDPlayground
//
//  Created by Jersey on 2019/1/12.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "ViewController.h"

#import "JSDCommandModel.h"
#import <objc/runtime.h>
NSString* const kJSDCellIdentifier = @"kJSDCellIdentifier";

void dynamicMethodIMP(id self, SEL _cmd) {
    // implementation ....
    NSLog(@"动态添加了个方法");
}
@interface ViewController ()

@end

@implementation ViewController

#pragma mark - 1.View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)respondsToSelector:(SEL)aSelector {
//
//
//    return NO;
//}

+ (void)zexige {
    
    NSLog(@"hahazexidao");
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    
    return NO;
}

//+ (BOOL)resolveInstanceMethod:(SEL)aSEL
//{
//    if (aSEL == @selector(ziziziz)) {
//          class_addMethod([self class], aSEL, (IMP)dynamicMethodIMP, "v@:");
//          return YES;
//    }
//    return [super resolveInstanceMethod:aSEL];
//}
+ (BOOL)resolveInstanceMethod:(SEL)aSEL
{
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    return nil;
}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//
//    NSMethodSignature* signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
//
//    NSLog(@"处理方法签名");
//    return signature;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//
//    NSLog(@"处理方法选择子");
//}

@end
