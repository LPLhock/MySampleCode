//
//  ViewController.m
//  JSDInterview
//
//  Created by jersey on 2018/6/29.
//  Copyright © 2018年 jersey. All rights reserved.
//

#import "ViewController.h"

@interface People : NSObject

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString* name;

@end

@implementation People

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    People* jersey = [[People alloc] init];
    jersey.age = 18;
    jersey.name = @"Jersey";
    NSLog(@"%ld", jersey.retainCount);
//    jersey = nil;
    [jersey release];
    NSLog(@"%ld", jersey.retainCount);
    jersey.age = 20;
    jersey.name = @"ada";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


