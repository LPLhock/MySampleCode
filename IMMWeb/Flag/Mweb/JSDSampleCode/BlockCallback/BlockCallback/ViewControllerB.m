//
//  ViewControllerB.m
//  BlockCallback
//
//  Created by 😘王艳 on 2018/8/24.
//  Copyright © 2018年 ZXDViewControll. All rights reserved.
//

#import "ViewControllerB.h"
#import "Mediator.h"

@interface ViewControllerB ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *text;


@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.callBlock = ^(NSString *string) {
//        string = self.text.text;
//    };
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"%@",self.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.callBlock(self.text.text);
    }];
    
}

- (instancetype)actionwith:(NSDictionary* )params
{
    typedef void (^callbackType)(NSString *);
    callbackType callback = params[@"callback"];
    if (callback) {
        callback(@"Jersey");
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
