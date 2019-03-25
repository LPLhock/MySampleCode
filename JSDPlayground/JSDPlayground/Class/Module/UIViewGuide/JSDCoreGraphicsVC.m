//
//  JSDCoreGraphicsVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/20.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDCoreGraphicsVC.h"
#import <CoreGraphics/CoreGraphics.h>

@interface JSDCoreGraphicsVC ()

@end

@implementation JSDCoreGraphicsVC


#pragma mark - 1.View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //4.设置通知
    [self setupNotification];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    UIImageView* nornerRadiusView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    nornerRadiusView.image = [UIImage imageNamed:@"1551775274999"];
//    nornerRadiusView.image = [UIImage imageWithContentsOfFile:@"WechatIMG912"];
UIGraphicsBeginImageContextWithOptions(nornerRadiusView.frame.size, NO, 1.0);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:nornerRadiusView.bounds cornerRadius:50];
    [path addClip];
    [nornerRadiusView drawRect:nornerRadiusView.bounds];
    nornerRadiusView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.view addSubview:nornerRadiusView];
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
//    imageView.image =[ UIImage imageNamed:@"1551775274999"];
//UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 1.0);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds
//                                                    cornerRadius:50];
//    [path addClip];
//    [imageView drawRect:imageView.bounds];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    self.navigationItem.title = @"CoreGraphics";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 使用贝塞尔曲线UIBezierPath和Core Graphics框架画出一个圆角
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.image =[ UIImage imageNamed:@"1551775274999"];
    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 1.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                                                    cornerRadius:50];
    [path addClip];
    [imageView drawRect:imageView.bounds];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.view addSubview:imageView];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

@end
