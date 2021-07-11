//
//  JSDLaunchOptimizationVC.m
//  JSDPlayground
//
//  Created by Jersey on 11/1/2020.
//  Copyright © 2020 Jersey. All rights reserved.
//

#import "JSDLaunchOptimizationVC.h"

@interface JSDLaunchOptimizationVC ()

@property(nonatomic, strong) UITextView *textView;

@end

@implementation JSDLaunchOptimizationVC

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
    
}

- (void)setupView {
    
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.width.height.mas_equalTo(self.view);
    }];
    self.textView.text = @"1. 减少";
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

- (UITextView *)textView {
    
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.scrollEnabled = YES;
        _textView.editable = NO;
        [_textView setFont:[UIFont systemFontOfSize:20]];
    }
    return _textView;
}

@end

