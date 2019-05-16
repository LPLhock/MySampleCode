//
//  JSDImageSpritesVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/5/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDImageSpritesVC.h"

@interface JSDImageSpritesVC () <CALayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation JSDImageSpritesVC

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
    self.navigationItem.title = @"图片拼接";
}

- (void)setupView {
    
    UIImage* image  = [UIImage imageNamed:@"assets_black_recharge"];
    UIImage* image2 = [UIImage imageNamed:@"assets_white_ashcan"];
    UIImage* image3 = [UIImage imageNamed:@"common_bficonss"];
    UIImage* image4 = [UIImage imageNamed:@"common_closeeyes"];
    
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 1, 1) toLayer:self.leftView.layer];
    [self addSpriteImage:image2 withContentRect:CGRectMake(0, 0, 1, 1) toLayer:self.rightView.layer];
    [self addSpriteImage:image3 withContentRect:CGRectMake(0.25, 0.25, .5, .5) toLayer:self.topView.layer];
    [self addSpriteImage:image4 withContentRect:CGRectMake(0.25, 0.25, .5, .5) toLayer:self.bottomView.layer];
    
    self.bottomView.layer.delegate = self;
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer* )layer {
    
    layer.contents = (__bridge id)image.CGImage;
//    layer.contentsGravity = kCAGravityCenter;
//    layer.contentsScale = [UIScreen mainScreen].scale;
    
    layer.contentsCenter = rect;
//    layer.contentsRect = rect;

}

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

@end

