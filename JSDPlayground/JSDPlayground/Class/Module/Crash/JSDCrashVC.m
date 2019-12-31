//
//  JSDCrashVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/18.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDCrashVC.h"
#import <objc/runtime.h>
#import <XXShield/XXShield.h>

NSString* JSDLoginManagerDidLoginNotification = @"jersey";

@interface JSDCrashVC ()

@end


@implementation JSDCrashVC


#pragma mark - 1.View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //4.设置通知
    [self setupNotification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    self.navigationItem.title = @"防Crash方案";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [XXShieldSDK registerStabilitySDK];
    [XXShieldSDK registerStabilityWithAbility:3];
    
    [self performSelector:@selector(jersey) withObject:nil afterDelay:0];
    
//    NSLog(@"%@", JSDLoginManagerDidLoginNotification);
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
