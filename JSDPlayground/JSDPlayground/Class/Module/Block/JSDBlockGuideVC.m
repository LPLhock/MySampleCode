//
//  JSDBlockGuideVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/12.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDBlockGuideVC.h"

static int static_number = 5;

int gloNumber = 5;
@interface JSDBlockGuideVC ()

@property (nonatomic, strong) void(^strongBlock)(int num);
@property (nonatomic, copy) void(^copyBlock)(int num);

@end

@implementation JSDBlockGuideVC

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
    self.navigationItem.title = @"";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    int number = 5;
    __block int block_number = 5;
    static int sum = 5;
    NSMutableString* str = @"hello".mutableCopy;
    int (^block)(int) = ^(int num){
        
        NSLog(@"局部整形变量%d", number);
        NSLog(@"局部指针变量%@", str);
        NSLog(@"静态整形变量%d", static_number);
        NSLog(@"全局整形变量%d", gloNumber);
        NSLog(@"静态整形变量%d", sum);
        NSLog(@"__block修饰的局部变量%d", block_number);
        return num * number;
    };
    
    [str appendString:@",word"];
    number = 10;
    sum = 10;
    static_number = 10;
    gloNumber = 10;
    block_number = 10;

    block(number);
    
    __block int stackNumber = 5;
    
    _strongBlock = ^(int num) {
        
        NSLog(@"Strong修饰结果%d", num * stackNumber);
    };
    
    self.name = @"Jersey";
    __block JSDBlockGuideVC* blockGuide = self;
    __weak JSDBlockGuideVC* weakSelf = self;
    _copyBlock = ^(int num) {
        
        NSLog(@"持有了%@", blockGuide.name);
        blockGuide = nil;
        NSLog(@"释放咯%@", weakSelf.name);
        NSLog(@"释放咯%@", blockGuide.name);
        NSLog(@"copy修饰结果%d", num * stackNumber);
    };
    stackNumber = 10;
    
    [self reloadView];
}

- (void)reloadView {
 
    _strongBlock(10);
    _copyBlock(10);
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

- (void)dealloc {
    
    NSLog(@"当前控制器已经释放掉了");
}

@end
