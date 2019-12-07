//
//  JSDHashVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/13.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDHashVC.h"

@interface JSDHashVC ()

@end

@implementation JSDHashVC


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
    self.navigationItem.title = @"HASH算法";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    char* table = "hehllo,world";
    
    int array[256];
    for (int i = 0; i < 256; i++) {
        array[i] = 0;
    }
    char* p = table;
    while (*p != '\0') {
        array[*(p++)]++;
    }
    p = table;
    char result = '\0';
    while (result == '\0') {
        if (array[*p] == 1) {
            result = *p;
        } else {
            p++;
        }
    }
    NSLog(@"%c", result);
    
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
