//
//  ViewController.m
//  JSDAFNetWorking
//
//  Created by Jersey on 2019/1/15.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    dispatch_async(dispatch_queue_create(0, 0), ^{
//
//        CALayer* layerB = [[CALayer alloc] init];
//        layerB.backgroundColor = [UIColor redColor].CGColor;
//
//        NSLog(@"%@", [NSThread currentThread]);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            layerB.frame = CGRectMake(0, 200, 50, 50);
//            [self.view.layer addSublayer:layerB];
//            NSLog(@"对象 B 创建完成");
//        });
//    });
    
    
    UIView* viewA = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    NSLog(@"CreatA");
    viewA.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:viewA];
    NSLog(@"CreatAEnd");
    
    NSLog(@"CreatB");
    CALayer* layerB = [[CALayer alloc] init];
    layerB.backgroundColor = [UIColor redColor].CGColor;
    NSLog(@"CreatBEnd");
    
    NSLog(@"对象 A 创建完成");
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(200, 250, 50, 50)];
    
    NSLog(@"代理%@, ---A:%@", viewA.layer.delegate, viewA);

    
}


@end
