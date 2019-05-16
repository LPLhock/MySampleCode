//
//  JSDCALayerClockVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/5/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDCALayerClockVC.h"

@interface JSDCALayerClockVC ()

@property (weak, nonatomic) IBOutlet UIView *clockView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (nonatomic, strong) UIView* blueView;
@property (nonatomic, strong) UIView* yellowView;
@property (nonatomic, strong) UIView* redView;

@property (nonatomic, strong) NSTimer* timer;

@end

@implementation JSDCALayerClockVC

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
    self.navigationItem.title = @"Clock";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.clockView.layer.anchorPoint = CGPointMake(0, 0);
    
    self.clockView.layer.cornerRadius = self.clockView.frame.size.height / 2;
    self.clockView.layer.borderColor = [UIColor blackColor].CGColor;
    self.clockView.layer.borderWidth = 3;
    
    self.secondView.backgroundColor = [UIColor blackColor];
    
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self reloadView];
    
    
    UIView* jsdView = [[UIView alloc] init];
    jsdView.backgroundColor = [UIColor blueColor];
    jsdView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:jsdView];
//    NSLog(@"jsd:%@", NSStringFromCGPoint(jsdView.layer.position));
    self.blueView = jsdView;
    
    UIView* jsqView = [[UIView alloc] init];
    jsqView.backgroundColor = [UIColor yellowColor];
    jsqView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:jsqView];
    jsqView.layer.anchorPoint = CGPointMake(0, 0);
//    NSLog(@"js:%@", NSStringFromCGPoint(jsView.layer.position));
    self.yellowView = jsqView;
    
    UIView* jsView = [[UIView alloc] init];
    jsView.backgroundColor = [UIColor redColor];
    jsView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:jsView];
    self.redView = jsView;
    
    jsView.layer.anchorPoint = CGPointMake(1, 1);
    
    NSLog(@"js:%@", NSStringFromCGPoint(jsView.layer.position));
    
    CGPoint jsdViewPoint = [self.view convertPoint:CGPointMake(50, 50) toView:jsdView];
    NSLog(@"jsd:%@", NSStringFromCGPoint(jsdViewPoint));
    
}

- (void)reloadView {

}

- (void)tick {
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* components = [calendar components:units fromDate:[NSDate date]];
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    
    self.secondView.transform = CGAffineTransformMakeRotation(secondAngle);
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGPoint eventPoint = [[touches anyObject] locationInView:self.view];
    NSString* title;
//    if ([self.blueView pointInside:eventPoint withEvent:event]) {
//        title = @"blueView";
//    } else if ([self.redView pointInside:eventPoint withEvent:event]) {
//        title = @"self.redView";
//    } else if ([self.yellowView pointInside:eventPoint withEvent:event]) {
//        title = @"yellowView";
//    } else {
//        title = @"super View";
//    }
    UIView* eventLayer = [self.view hitTest:eventPoint withEvent:event];
//    if ([self.blueView.layer containsPoint:eventPoint]) {
//        title = @"blueView";
//    } else if ([self.redView.layer containsPoint:eventPoint]) {
//        title = @"self.redView";
//    } else if ([self.yellowView.layer containsPoint:eventPoint]) {
//        title = @"yellowView";
//    } else {
//        title = @"super View";
//    }
    if ([eventLayer isEqual: self.blueView]) {
        title = @"blueView";
    } else if ([eventLayer isEqual: self.redView]) {
        title = @"self.redView";
    } else if ([eventLayer isEqual: self.yellowView]) {
        title = @"yellowView";
    } else {
        title = @"super View";
    }
    
    [super touchesBegan:touches withEvent:event];
    
    UIAlertController* alertVC = [[UIAlertController alloc] init];
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVC addAction:alertAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

@end

