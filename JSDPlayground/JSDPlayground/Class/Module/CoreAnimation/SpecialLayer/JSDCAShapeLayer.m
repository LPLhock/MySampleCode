//
//  JSDCAShapeLayer.m
//  JSDPlayground
//
//  Created by Jersey on 2019/5/16.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDCAShapeLayer.h"

@interface JSDCAShapeLayer ()

@end

@implementation JSDCAShapeLayer

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
    self.navigationItem.title = @"CAShapeLayer";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath* path = [[UIBezierPath alloc] init];
    // 绘制火柴人, 先取一个点, 然后画头, 画完之后,将点移动到脖子的地方 2.5 * M_PI。方便画身体。
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2.5*M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(150, 225)];
    // 画左脚
    [path addLineToPoint:CGPointMake(125, 275)];
    // 将原点移动回下半身原点。 画右脚
    [path moveToPoint:CGPointMake(150, 225)];
    [path addLineToPoint:CGPointMake(175, 275)];
    // 绘制 手
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(110, 175)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(190, 175)];
    
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    // 填充颜色. 貌似只填充了 画笔移动之前所有绘制的路径。
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    // Join 表示线条之间结合的样子. Cap 表示线结尾的样子.
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
    
    UIView* cornerView = [[UIView alloc] init];
    cornerView.frame = CGRectMake(100, 300, 100, 100);
    cornerView.backgroundColor = [UIColor blackColor];
    
    CAShapeLayer* cornerShapeLayer = [[CAShapeLayer alloc] init];
    CGRect rect = cornerView.frame;
    CGSize radis = CGSizeMake(50, 50);
    UIRectCorner corners = UIRectCornerAllCorners;
    UIBezierPath* cornerpath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radis];
    
    cornerShapeLayer.strokeColor = [UIColor blueColor].CGColor;
    cornerShapeLayer.fillColor = [UIColor clearColor].CGColor;
//    cornerShapeLayer.color
    cornerShapeLayer.lineWidth = 1.0f;
    cornerShapeLayer.lineJoin = kCALineJoinRound;
    cornerShapeLayer.lineCap = kCALineCapRound;
    cornerShapeLayer.path = cornerpath.CGPath;
    
    [cornerView setValue:cornerShapeLayer forKey:@"layer"];
    [self.view addSubview:cornerView];
//    cornerView.accessibilityPath = cornerpath;
//    cornerView.layer.masksToBounds = YES;
    
    
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

