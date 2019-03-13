//
//  JSDGCDVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/12.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDGCDVC.h"

@interface JSDGCDVC ()

@end

@implementation JSDGCDVC


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
    self.navigationItem.title = @"GCD";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)reloadView {
    
    NSLog(@"哈哈哈");
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
