//
//  ViewController.m
//  BlockCallback
//
//  Created by 😘王艳 on 2018/8/24.
//  Copyright © 2018年 ZXDViewControll. All rights reserved.
//

#import "ViewController.h"
#import "Mediator.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *text;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    
    UIViewController* vc = [Mediator Modle_VCName:@"ViewControllerB" parameter:@{@"name":@"jersey"}];
    
    
    [self presentViewController:vc animated:YES completion:^{
        NSLog(@"%@",[vc valueForKey:@"name"]);
    }];
    
//    ViewController di
}


@end
