//
//  JSDRACVC.m
//  JSDPlayground
//
//  Created by Jersey on 27/11/2019.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDRACVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface JSDRACVC () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray* model;
@property(nonatomic, strong) UITextField *textField;

@end

@implementation JSDRACVC

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //5.解析数据
    [self setupAnalyticalData];
    //6.设置通知
    [self setupNotification];
    //7.private
    [self setupPrivateMethod];
}

#pragma mark - 2 SettingView and Style

-(void)setupNavBar {
    
    self.title = NSStringFromClass(self.class);
}

- (void)setupView {
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 300, 60)];
    self.textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textField];
    
    RAC(self.textField, text) = self.textField.rac_textSignal;
    
    
    [RACObserve(self.textField, text) subscribeNext:^(id x) {
        NSLog(@"字符串:%@", x);
//        NSString* text = (NSString* )x;

//        self.textField.text = [text stringByAppendingFormat:@"哈哈"];
    }];
    

//    signal subscribeNext:^(id x) {
//
//    } completed:^{
//
//    }
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(1)];
        return nil;
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"哈哈%@",x);
    } completed:^{
        NSLog(@"执行完毕");
    }];
    
    [signal doCompleted:^{
        NSLog(@"接触");
    }];
    
    RACSubject *subject = [RACSubject subject];
    
}

- (void)reloadingView {
    
    
}

#pragma mark - 3 Request Data

- (void)setupData {
    
    
}

#pragma mark - 4 UITableViewDataSource and UITableViewDelegate

#pragma mark - 5 Event Response


- (void)setupAnalyticalData {
    
    
}
#pragma mark - 6 Private Methods

- (void)setupNotification {
    
}

- (void)setupPrivateMethod {
    
    
}

#pragma mark - 7 GET & SET


@end

