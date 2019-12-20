//
//  UIViewController+Search.m
//  JSDUIViewContorllerTool
//
//  Created by Jersey on 2018/9/16.
//  Copyright © 2018年 Jersey. All rights reserved.
//

#import "UIViewController+Search.h"

@implementation UIViewController (Search)

+ (UIViewController *)jsd_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+ (UIViewController *)jsd_findVisibleViewController {
    
    UIViewController* currentViewController = [self jsd_rootViewController];

    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else if ([currentViewController isKindOfClass:[UISplitViewController class]]) { // 当需要兼容 Ipad 时
                currentViewController = currentViewController.presentingViewController;
            } else {
                if (currentViewController.presentingViewController) {
                    currentViewController = currentViewController.presentingViewController;
                } else {
                    return currentViewController;
                }
            }
        }
    }
    
    return currentViewController;
}

@end
