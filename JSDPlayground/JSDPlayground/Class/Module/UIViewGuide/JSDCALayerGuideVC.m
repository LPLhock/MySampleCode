//
//  JSDCALayerVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/5/14.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDCALayerGuideVC.h"

@interface JSDCALayerGuideVC ()

@end

@implementation JSDCALayerGuideVC

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
    self.navigationItem.title = @"CALayerGuide";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CALayer* layer = [[CALayer alloc] init];
    UIImage* image = [UIImage imageNamed:@"common_ggsz1"];
    
    layer.frame = CGRectMake(0, 0, 200, 300);
    layer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 100);
    layer.contents = (__bridge id)image.CGImage; // CGImage 返回 CGImageRef, 其是指向 CGImage. typedef struct CF_BRIDGED_TYPE(id) CGImage *CGImageRef;
    layer.contentsGravity = kCAGravityCenter; // 类似 UIView 的 ViewContentMode, 此值默认是 resize;
    layer.contentsScale = [UIScreen mainScreen].scale;  // 并不是单纯是字面上的内容缩放比例,其表示的是 此图片 1个点会占用多少像素. 比如默认值是 1 时, 1个点对应 1个像素, 但是 retina 屏幕, 一般需要 1个点 对应 2个像素, 如果我们不修改此值则图像不会显示出原图效果。  由于其实拉伸效果, 所以需要考虑 contentsGravity , 如果这里值已经设置成 kCAGravityResizeAspect 拉伸的,  然后在继续使用它来设置, 效果会非常不明显。  一般配合 kCAGravityCenter 使用, 因为其不会对图片造成任何拉伸效果。
    layer.masksToBounds = YES;
    layer.contentsRect = CGRectMake(0, 0, 1, 1); // 默认值   {0,0,1,1}  其是一个设置显示区域, 默认会将显示区域以外的内容进行裁剪掉。 其是一种 单位坐标系统。
    //“事实上给contentsRect设置一个负数的原点或是大于{1, 1}的尺寸也是可以的。这种情况下，最外面的像素会被拉伸以填充剩下的区域。”
    
    [self.view.layer addSublayer:layer];
    
    CALayer* layer2 = [[CALayer alloc] init];
    UIImage* image2 = [UIImage imageNamed:@"common_ggsz1"];
    
    layer2.frame = CGRectMake(0, 0, 200, 300);
    layer2.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 + 100);
    layer2.contents = (__bridge id)image2.CGImage;
    layer2.contentsGravity = kCAGravityCenter;
    layer2.contentsScale = [UIScreen mainScreen].scale;
//    layer2.masksToBounds = YES;
    layer2.contentsRect = CGRectMake(0, -1, 1, 1.5);
    
    [self.view.layer addSublayer:layer2];

    // 阴影
    UIView* connerView = [[UIView alloc] initWithFrame:CGRectMake(100, 80, 100, 100)];
    connerView.backgroundColor = [UIColor grayColor];

    
    UIView* subConnerView = [[UIView alloc] initWithFrame:CGRectMake(250, 80, 100, 100)];
    

    subConnerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:connerView];
    [self.view addSubview:subConnerView];
    
    connerView.layer.shadowOpacity = 1;
    connerView.layer.shadowOffset = CGSizeMake(-5, 5);
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(squarePath, NULL, connerView.frame);

    NSLog(@"%f", connerView.layer.shadowRadius);
    
    subConnerView.layer.shadowOpacity = 1;
    subConnerView.layer.cornerRadius = 50;
    subConnerView.layer.shadowOffset = CGSizeMake(-5, 5);
//    CGMutablePathRef circlePath = CGPathCreateMutable();
//    CGPathAddEllipseInRect(circlePath, NULL, subConnerView.bounds);
    
//    connerView.layer.shadowPath =
//    subConnerView.layer.mask
    
    // Mask
    
//    UIView* maskView = [UIView]
    
    UIImageView* maskImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"assets_white_ashcan"]];
    maskImageView.frame = CGRectMake(100, 300, 100, 100);
    [self.view addSubview:maskImageView];
    
    CALayer* maskLayer = [[CALayer alloc] init];
    maskLayer.frame = maskImageView.bounds;
    maskLayer.contents = (__bridge id)[UIImage imageNamed:@"common_note"].CGImage;
    
    maskImageView.layer.mask = maskLayer;
}

- (void)injected {
    
    [self viewDidLoad];
    [self viewWillAppear:YES];
    [self viewWillDisappear:YES];
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

