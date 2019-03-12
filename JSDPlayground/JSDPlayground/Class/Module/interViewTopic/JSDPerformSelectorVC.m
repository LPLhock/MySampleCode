//
//  JSDPerformSelectorVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/1/12.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDPerformSelectorVC.h"

#import "NSObject+JSDPerformSelector.h"
#import <objc/runtime.h>

void test () {
    
    NSLog(@"处理消息转发");
}

@interface JSDPerformSelectorVC ()

@end

@implementation JSDPerformSelectorVC


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
    self.navigationItem.title = @"PerformSelector";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
    //调用多个参数方法,  主要用于解决, 我们在调用其他类, 或者别人写的库里面包含一些私有方法时, 可以直接使用其来进行调用。
    [self jsd_performSelector:@selector(eatBreakfast:luncheon:dinner:) withObjects:@[@"汉堡-咖啡", @"牛排-沙拉", @"Coffer"]];
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

- (void)eatBreakfast:(NSString*)breakfast luncheon:(NSString *)luncheon dinner:(NSString *)dinner {
    
    NSLog(@"今天早上吃了:%@--- 中午吃了:%@--- 晚上吃了:%@---", breakfast, luncheon, dinner);
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET


@end
