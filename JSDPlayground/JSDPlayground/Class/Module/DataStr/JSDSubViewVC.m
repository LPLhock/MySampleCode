//
//  JSDSubViewVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/13.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDSubViewVC.h"

@interface JSDSubViewVC ()

@property(nonatomic, strong) UIView *AView;
@property(nonatomic, strong) UIView *ABView;
@property(nonatomic, strong) UIView *ABBView;
@property(nonatomic, strong) UIView *ACView;
@property(nonatomic, strong) UIView *ACCView;

@end

@implementation JSDSubViewVC

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
    self.navigationItem.title = @"子视图查找共同父视图";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.AView = [[UIView alloc] init];
    
    [self.view addSubview:self.AView];
    
    //
    self.ABView = [[UIView alloc] init];
    
    [self.AView addSubview:self.ABView];
    self.ABBView = [[UIView alloc] init];
    [self.ABView addSubview:self.ABBView];
    
    self.ACView = [[UIView alloc] init];
    [self.AView addSubview:self.ACView];
    
    UIView* testView1 = [[UIView alloc] init];
    UIView* testView2 = [[UIView alloc] init];
    
    [self.ABBView addSubview:testView1];
    [self.ABBView addSubview:testView2];
    
    [self fineSuperViewsWithfirstview:testView1 view:testView2];
    
}

- (NSArray <UIView*>*)fineSuperViewsWithfirstview:(UIView*)firstView view:(UIView *)twoView {
    
    NSMutableArray* resultViews = [[NSMutableArray alloc] init];
    NSArray* firstSuperView = [self findSuperView:firstView];
    NSArray* twoSuperView = [self findSuperView:twoView];
    
    for (NSInteger i = 0; i < firstSuperView.count; i++) {
        UIView* view = firstSuperView[i];
        for (NSInteger y = 0; y < twoSuperView.count; y++) {
            UIView* twoView = twoSuperView[y];
            if ([view isEqual:twoView]) {
                NSLog(@"共同%@", twoView);
                [resultViews addObject:twoView];
                break;
            }
        }
    }
//    NSInteger i = 0;
//    while (i < MIN(firstSuperView.count, twoSuperView.count)) {
//        UIView* view = [firstSuperView objectAtIndex:firstSuperView.count - i - 1];
//        UIView* view2 = [twoSuperView objectAtIndex:twoSuperView.count - i - 1];
//        if ([view isEqual:view2]) {
//            [resultViews addObject:view];
//            i++;
//        } else {
//            break;
//        }
//    }
    
    NSLog(@"%@", resultViews);
    return resultViews;
}

- (NSArray <UIView *>*)findSuperView:(UIView*)view {
    
    NSMutableArray* resultViews = [[NSMutableArray alloc] init];
    UIView* superView = view.superview;
    while (superView) {
        [resultViews addObject:superView];
        superView = superView.superview;
    }
    
    return resultViews;
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
