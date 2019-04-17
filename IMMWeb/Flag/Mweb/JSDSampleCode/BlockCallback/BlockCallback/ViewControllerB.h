//
//  ViewControllerB.h
//  BlockCallback
//
//  Created by 😘王艳 on 2018/8/24.
//  Copyright © 2018年 ZXDViewControll. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewControllerB : UIViewController

@property (copy, nonatomic) void (^callBlock)(NSString* string);
@property (copy, nonatomic) NSString* name;

@end
