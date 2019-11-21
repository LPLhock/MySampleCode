//
//  JSDUIViewLabelVC.m
//  JSDPlayground
//
//  Created by Jersey on 18/11/2019.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDUIViewLabelVC.h"
#import "SKAutoScrollLabel.h"

@interface JSDUIViewLabelVC ()

@property(nonatomic, strong) SKAutoScrollLabel *topLabel;

@end

@implementation JSDUIViewLabelVC

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
    
    self.navigationItem.title = @"UILabel 跑马灯";
    
}

- (void)setupView {
    
    SKAutoScrollLabel* topLabel = [[SKAutoScrollLabel alloc] initWithTextContent:@"竭尽全力的去解耦的一次实践，封装一个TableView和一些功能组合的控件" direction:SK_AUTOSCROLL_DIRECTION_LEFT];
    self.topLabel = topLabel;
//    self.topLabel.frame = CGRectMake(15, 100, self.view.frame.size.width - 30, 60);
    self.topLabel.textColor = [UIColor blackColor];
    self.topLabel.backgroundColor = [UIColor grayColor];
    self.topLabel.labelSpacing = 0;
    [self.view addSubview:topLabel];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(60);
    }];
    
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




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

