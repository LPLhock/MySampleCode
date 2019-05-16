//
//  JSDTransformVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/5/16.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDTransformVC.h"

@interface JSDTransformVC ()

@property (weak, nonatomic) IBOutlet UIImageView *rotaionImageView;
@property (weak, nonatomic) IBOutlet UIImageView *scaleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *translationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *synthesizeImageView;

@end

@implementation JSDTransformVC

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
    self.navigationItem.title = @"Transform";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.rotaionImageView.backgroundColor = [UIColor grayColor];
    self.scaleImageView.backgroundColor = [UIColor grayColor];
    self.translationImageView.backgroundColor = [UIColor grayColor];
    self.synthesizeImageView.backgroundColor = [UIColor grayColor];
//    CGAffineTransform
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused"
    CGAffineTransform rotaintransform = CGAffineTransformMakeRotation(M_PI_4);
    CGAffineTransform rotaintransform2 = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
//    self.rotaionImageView.layer.affineTransform = transform;
    self.rotaionImageView.transform = rotaintransform;
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.5, 0.5);
    CGAffineTransform scaleTransform2 = CGAffineTransformMakeScale(1.5, 0.5);
    self.scaleImageView.transform = scaleTransform2;
    
    CGAffineTransform concatTransform = CGAffineTransformConcat(rotaintransform, scaleTransform2);
    CGAffineTransform translate = CGAffineTransformMakeTranslation(100, 0);
//    self.translationImageView.transform = concatTransform;
    
#pragma clang diagnostic pop
    
    CGAffineTransform synthesisTransform = CGAffineTransformIdentity;
    synthesisTransform = CGAffineTransformScale(synthesisTransform, 0.5f, 0.5f);
    synthesisTransform = CGAffineTransformRotate(synthesisTransform, M_PI / 180 * 90);
    synthesisTransform = CGAffineTransformTranslate(synthesisTransform, 200, 0);
    self.synthesizeImageView.transform = synthesisTransform;
    
    
    
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

