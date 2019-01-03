//
//  ViewController.m
//  JSDNaturalNumber
//
//  Created by Jersey on 2019/1/3.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 自然数数组 1 --- 1000;
    NSMutableArray* naturas = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= 1000; i++) {
        [naturas addObject:@(i)];
    }
    // 深拷贝一份模板
    NSMutableArray* naturasTemplate = naturas.mutableCopy;
    // 随机去除两个元素
    for (NSInteger i = 0; i < 2; i++) {
        NSInteger y = arc4random() % 1000;
        [naturas removeObject: @(y)];
        NSLog(@"去除%ld", y);
    }
    // 数据配置完毕
    // 循环遍历一遍
    for (NSInteger i = 0; i < naturas.count; i++) {
        
        if ([naturasTemplate containsObject:naturas[i]]) {
            [naturasTemplate removeObject:naturas[i]];
        }
    }
    NSLog(@"找到去除的元素:%@-----%@", naturasTemplate.firstObject, naturasTemplate.lastObject);
}


@end
