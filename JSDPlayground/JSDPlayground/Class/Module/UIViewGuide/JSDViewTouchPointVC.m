//
//  JSDViewTouchPointVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/5.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDViewTouchPointVC.h"
#import "JSDTouchButton.h"

@interface JSDViewTouchPointVC ()

@property (nonatomic, strong) UIView* redView;
@property (nonatomic, strong) UIView* blueView;
@property (nonatomic, strong) UIButton* redButton;
@property (nonatomic, strong) JSDTouchButton* blueButton;

@end

@implementation JSDViewTouchPointVC

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

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    self.navigationItem.title = @"TouchPoint";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizesSubviews = NO;
    
    [self.view addSubview:self.redView];
    [self.view addSubview:self.blueView];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(self.redView);
        make.top.mas_equalTo(self.redView.mas_bottom).mas_offset(100);
    }];
    
    [self.redView addSubview:self.redButton];
    [self.blueView addSubview:self.blueButton];
    
    [self.redButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    self.redButton.backgroundColor = [UIColor redColor];
    self.redButton.layer.cornerRadius = 50;
    self.redButton.layer.masksToBounds = YES;
    
    [self.blueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(150);
    }];
    
    self.blueButton.backgroundColor = [UIColor greenColor];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

- (void)onTouchRedButton {
    
    NSLog(@"红色按钮响应");
}

- (void)onTouchBlueButton {
    
    NSLog(@"蓝色按钮响应");
}
#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (UIView *)redView {
    
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor blackColor];
    }
    return _redView;
}

- (UIView *)blueView {
    
    if (!_blueView) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blackColor];
    }
    return _blueView;
}

- (UIButton *)redButton {
    
    if (!_redButton) {
        _redButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_redButton addTarget:self action:@selector(onTouchRedButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _redButton;
}

- (UIButton *)blueButton {
    
    if (!_blueButton) {
        _blueButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_blueButton addTarget:self action:@selector(onTouchBlueButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blueButton;
}

@end
