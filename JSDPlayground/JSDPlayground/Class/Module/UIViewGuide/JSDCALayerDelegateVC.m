//
//  JSDCALayerDelegateVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/5/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDCALayerDelegateVC.h"

#pragma mark - 1.View Controller Life Cycle

@interface JSDCALayerDelegateVC ()<CALayerDelegate>

@property (nonatomic, strong) UIView* nodeView;

@end

@implementation JSDCALayerDelegateVC

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
    self.navigationItem.title = @"UIView Disply";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nodeView = [[UIView alloc] initWithFrame:CGRectMake(100, 250, 200, 200)];
    self.nodeView.backgroundColor = [UIColor blackColor];
//    self.nodeView.layer.delegate = self;
    
    [self.view addSubview:self.nodeView];
    NSLog(@"开始加载");
    CALayer* layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor blueColor].CGColor;
    
    layer.delegate = self; // 设置了代理之后, 当页面 POP 出去, 则会 Crash. 具体不知道什么原因
    [self.view.layer addSublayer:layer];
    layer.frame = CGRectMake(0, 0, 50, 50);
//    [self.nodeView.layer display];
//    [layer display];
    
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//
//    CGContextSetLineWidth(ctx, 10.0f);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextStrokeEllipseInRect(ctx, layer.frame);
//
//    NSLog(@"绘制");
//}
//
//- (void)layerWillDraw:(CALayer *)layer {
//
////    [self.nodeView layerWillDraw:layer];
//
//    NSLog(@"将要绘制");
//}

//- (void)layoutSublayersOfLayer:(CALayer *)layer {
//
//    NSLog(@"布局");
//}

//- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
//
//    NSLog(@"响应");
//
//    return nil;
//}

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

@end

