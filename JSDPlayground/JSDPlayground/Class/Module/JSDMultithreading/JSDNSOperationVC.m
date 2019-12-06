//
//  JSDNSOperationVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/12.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDNSOperationVC.h"

@interface JSDNSOperationVC ()

@end

@implementation JSDNSOperationVC


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
    self.navigationItem.title = @"NSOperation";
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    NSInvocationOperation* operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task) object:nil];
    NSInvocationOperation* operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    NSInvocationOperation* operation3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task3) object:nil];
    NSInvocationOperation* operation4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task4) object:nil];
    
    NSLog(@"开始执行任务咯");
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [operation4 addDependency:operation3];
    [operation4 addDependency:operation2];
    [operation4 addDependency:operation1];
    [queue addOperation:operation4];
    NSLog(@"执行任务结束咯");
    
//    [queue cancelAllOperations];
    
}

- (void)task {
    
    NSLog(@"开始执行任务1%@", [NSThread currentThread]);
    sleep(3);
    NSLog(@"完成任务1");
}
- (void)task2 {
    NSLog(@"开始执行任务2%@", [NSThread currentThread]);
    sleep(3);
    NSLog(@"完成任务2");
}
- (void)task3 {
    NSLog(@"开始执行任务3%@", [NSThread currentThread]);
    sleep(3);
    NSLog(@"完成任务3");
}
- (void)task4 {
    
    NSLog(@"开始执行任务4");
    sleep(1);
    NSLog(@"完成任务4");
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
