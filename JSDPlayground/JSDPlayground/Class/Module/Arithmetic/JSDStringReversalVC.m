//
//  JSDStringReversalVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/13.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDStringReversalVC.h"

@interface JSDStringReversalVC ()

@end

@implementation JSDStringReversalVC


#pragma mark - 1.View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    static NSInteger number = 0;
    number++;
    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //4.设置通知
    [self setupNotification];
    
    NSLog(@"当前数量%ld", number);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    self.navigationItem.title = @"字符串反转";
}

- (void)setupView {

    self.view.backgroundColor = [UIColor whiteColor];
    
    char ch[] = "hello, word";
    
//    [self char_reverse:ch];
    NSLog(@"%s", ch);
    
    static NSInteger number = 0;
    number++;
    NSLog(@"当前数量%ld", number);
}

- (void)char_reverse:(char *)cha {
    // 指向第一个字符
    char* begin = cha;
    // 指向最后一个字符
    char* end = cha + strlen(cha) - 1;
    
    while (begin < end) {
        // 交换前后两个字符,同时移动指针
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
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
