//
//  main.m
//  JSDWeChat
//
//  Created by jersey on 2018/6/6.
//  Copyright © 2018年 jersey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        
        int (^func) (int count) = ^ int (int number) {
            return 15;
        };
//
//            int result = func(10);
//
//            int value = (func(10));
//            NSLog(@"%d---%d",result,value);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
        
    }
    
    
    
}
