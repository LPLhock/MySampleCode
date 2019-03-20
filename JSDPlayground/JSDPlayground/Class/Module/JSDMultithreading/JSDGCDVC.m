//
//  JSDGCDVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/12.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDGCDVC.h"
#import <CoreGraphics/CoreGraphics.h>
#import <OpenGLES/OpenGLESAvailability.h>
#import <QuartzCore/CoreAnimation.h>

@interface JSDGCDVC ()

@end

@implementation JSDGCDVC


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
    self.navigationItem.title = @"GCD";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)reloadView {
    
    NSLog(@"哈哈哈");
}

#pragma mark - 3.Request Data

- (void)setupData {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_t groutp2 = dispatch_group_create();
    dispatch_group_t groutp3 = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    // ABC
    dispatch_group_enter(groutp2);
    dispatch_group_enter(group);
    dispatch_group_enter(groutp3);
    dispatch_group_async(group, queue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(2);
            NSLog(@"任务A完成");
            dispatch_group_leave(group);
        });
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(2);
            NSLog(@"任务B完成");
            dispatch_group_leave(group);
        });
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(2);
            NSLog(@"任务C完成");
            dispatch_group_leave(group);
        });
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(2);
            NSLog(@"任务D完成");
            dispatch_group_leave(group);
        });
    });
    dispatch_group_notify(group, queue, ^{
        dispatch_group_enter(groutp2);
        dispatch_group_enter(groutp2);
        dispatch_group_async(groutp2, queue, ^{
            sleep(2);
            NSLog(@"异步执行队列二任务A");
            dispatch_group_leave(groutp2);
        });
        dispatch_group_async(groutp2, queue, ^{
            sleep(2);
            NSLog(@"异步执行队列二任务B");
            dispatch_group_leave(groutp2);
        });
        dispatch_group_async(groutp2, queue, ^{
            sleep(2);
            NSLog(@"异步执行队列二任务B");
            dispatch_group_leave(groutp2);
        });
    });
    dispatch_group_notify(groutp2, queue, ^{
        dispatch_group_enter(groutp3);
        dispatch_group_enter(groutp3);
        dispatch_group_async(groutp2, queue, ^{
            sleep(2);
            NSLog(@"异步执行队列三任务A");
            dispatch_group_leave(groutp3);
        });
        dispatch_group_async(groutp2, queue, ^{
            sleep(2);
            NSLog(@"异步执行队列三任务B");
            dispatch_group_leave(groutp3);
        });
        dispatch_group_async(groutp2, queue, ^{
            sleep(2);
            NSLog(@"异步执行队列三任务C");
            dispatch_group_leave(groutp3);
        });
    });
    
    dispatch_group_notify(groutp3, queue, ^{
        NSLog(@"全部任务都完成咯");
    });
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)executTaskA {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"任务 A 结束");
    });
}

- (void)executTaskB {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"任务 B 结束");
    });

}

- (void)executTaskC {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"任务 C 结束");
    });

}

- (void)executTaskD {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"任务 D 结束");
    });
}

- (void)executTaskE {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"任务 E 结束");
    });
}

- (void)executTaskF {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        NSLog(@"任务 F 结束");
    });
}

- (void)executTaskG {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"任务 G 结束");
    });
}

- (void)executTaskH {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"任务 H 结束");
    });
}

- (void)executTaskW {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"任务 W 结束");
    });
}

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

@end
