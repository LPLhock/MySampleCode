//
//  JSDRoutersVC.m
//  JSDPlayground
//
//  Created by Jersey on 10/12/2019.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDRoutersVC.h"
#import <JLRoutes/JLRoutes.h>

@interface JSDRoutersVC ()

@end

@implementation JSDRoutersVC

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
    
    [JLRoutes addRoute:@"zexidao(zexi)" handler:^BOOL(NSDictionary * _Nonnull parameters) {

        NSLog(@"---%@---", parameters);
        return YES;
    }];
    

    if ([JLRoutes routeURL:[NSURL URLWithString:@"zexidao"] withParameters:@{@"name": @"zexidao"}]) {
        
        NSLog(@"YES");
    } else {
        NSLog(@"NO");
    }
    
    if ([JLRoutes routeURL:[NSURL URLWithString:@"zexidaowww"] withParameters:@{@"name": @"zexidao"}]) {
        
        NSLog(@"YES");
    } else {
        NSLog(@"NO");
    }
    
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

