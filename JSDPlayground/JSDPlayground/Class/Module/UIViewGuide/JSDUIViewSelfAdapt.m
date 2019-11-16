//
//  JSDUIViewSelfAdapt.m
//  JSDPlayground
//
//  Created by Jersey on 12/11/2019.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDUIViewSelfAdapt.h"
#import <Aspects.h>

#define NSLog(format, ...)   {fprintf(stderr, "类名<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");};

@interface JSDUIViewSelfAdapt ()

@property(nonatomic, strong) UIView *adaptSuperView;
@property(nonatomic, strong) UIView *adaptSubView;
@property(nonatomic, strong) UIButton *adaptButton;


@end

@implementation JSDUIViewSelfAdapt

#pragma mark - View Controller Life Cycle

- (void)viewWillApper:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSLog(@"---");
}
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
    
//    self aspect_hookSelector:@selector(viewWillAppear:) withOptions: usingBlock: error:<#(NSError *__autoreleasing *)#>
    
    [self aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^{
        NSLog(@"实现交换");
    } error:nil];
    
    
}

#pragma mark - 2 SettingView and Style

-(void)setupNavBar {
    
    self.navigationItem.title = @"UIViewSelfAdapt";
    
}

- (void)setupView {
    
    self.adaptSuperView = [[UIView alloc] init];
    self.adaptSuperView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.adaptSuperView];
    
    [self.adaptSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(100);
    }];
    
    self.adaptSubView = [[UIView alloc] init];
    self.adaptSubView.backgroundColor = [UIColor blueColor];
    [self.adaptSuperView addSubview:self.adaptSubView];
    
    [self.adaptSubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.top.left.mas_equalTo(10);
        make.bottom.right.mas_equalTo(-10);
    }];
    
    self.adaptButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.adaptButton setTitle:@"调增SubView" forState:UIControlStateNormal];
    [self.adaptButton addTarget:self action:@selector(onTouchAddView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.adaptButton];
    [self.adaptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-50);
    }];
    
    
}

- (void)reloadingView {
    
    
}

#pragma mark - 3 Request Data

- (void)setupData {
    
    
}

#pragma mark - 4 UITableViewDataSource and UITableViewDelegate

#pragma mark - 5 Event Response

- (void)onTouchAddView:(id)sender {
    
    CGFloat adaptSubViewWidthHeight = CGRectGetHeight(self.adaptSubView.frame) + 10;
    [self.adaptSubView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(adaptSubViewWidthHeight);
        make.height.mas_equalTo(adaptSubViewWidthHeight);
        make.top.left.mas_equalTo(10);
        make.bottom.right.mas_equalTo(-10);
    }];
}


- (void)setupAnalyticalData {
    
    
}
#pragma mark - 6 Private Methods

- (void)setupNotification {
    
}

- (void)setupPrivateMethod {
    
    
}

#pragma mark - 7 GET & SET




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

