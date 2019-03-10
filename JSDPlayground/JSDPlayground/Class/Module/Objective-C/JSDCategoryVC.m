//
//  JSDCategoryVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/9.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDCategoryVC.h"
#import <objc/runtime.h>

@interface JSDCategoryVC ()

@end

@implementation JSDCategoryVC


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    self.navigationItem.title = @"Category";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
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

@interface JSDCategoryVC(JerseyCafe)

- (void)cafe;

@end

@implementation JSDCategoryVC(Jersey)

- (void)cafe {
    
    NSLog(@"hello, Do you need coffee");
    
    
}

@end
