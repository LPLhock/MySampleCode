//
//  JSDRunLoopVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/13.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDRunLoopVC.h"

static BOOL runAlways =  YES;

@interface JSDRunLoopVC ()

@property (nonatomic, strong) NSThread* thread;

@end

@implementation JSDRunLoopVC

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
    self.navigationItem.title = @"RunLoop";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 实现常驻线程
    
    // 1. 创先一个线程
    @synchronized (self) {
        if (!_thread) {
            _thread = [[NSThread alloc] initWithTarget:self selector:@selector(runRequest) object:nil];
            _thread.name = @"long-TermThread";
            [_thread start];
        }
    }
    
    runAlways = NO;
    
}

- (void)runLoop {
    
    NSLog(@"当前 RunLoop --当前线程%@",[NSThread currentThread]);
    NSLog(@"Hello, Word");
}

- (void)runRequest {
    
    CFRunLoopSourceContext context = {0, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL};
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    
    while (runAlways) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
    }
    
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
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
