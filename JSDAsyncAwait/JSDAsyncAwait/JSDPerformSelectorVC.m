//
//  JSDPerformSelectorVC.m
//  JSDAsyncAwait
//
//  Created by Jersey on 2021/11/4.
//

#import "JSDPerformSelectorVC.h"

@interface JSDPerformSelectorVC ()

@end

@implementation JSDPerformSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"JSDPerformSelectorVC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testPerformSelector];
//    dispatch_queue_t cQueue = dispatch_queue_create("JSD", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(cQueue, ^{
//        [self testPerformSelectorCrash];
//        [self testPerformSelectorOnMainThread];
//    });
    /*
     打印结果为 1、3。原因是：
         1    performSelector:withObject:afterDelay: 的本质是拿到当前线程的 RunLoop 往它里面添加 timer
         2    RunLoop 和线程是一一对应关系，子线程默认没有开启 RunLoop
         3    当前 performSelector:withObject:afterDelay: 在子线程执行
     所以 2 不会打印。
     */
}

- (void)testPerformSelector {
    dispatch_queue_t cQueue = dispatch_queue_create("JSD", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(cQueue, ^{
        NSLog(@"Perform: 1");
        [self performSelector:@selector(test) withObject:nil afterDelay: 0.0f];
        NSLog(@"Perform: 3");
    });
}

- (void)test {
    NSLog(@"Perform: 2");
}


- (void)testPerformSelectorCrash {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 10000; i++) {
            NSLog(@"Perform: 1");
            [self performSelectorOnMainThread:@selector(testPerformSelector) withObject:nil waitUntilDone:NO];
            NSLog(@"Perform: 3");
        }
    });
}

- (void)testPerformSelectorOnMainThread {
    dispatch_queue_t cQueue = dispatch_queue_create("JSD", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10000; i++) {
        dispatch_async(cQueue, ^{
            NSLog(@"Perform: 1");
            [self performSelectorOnMainThread:@selector(testPerformSelector) withObject:nil waitUntilDone:NO];
            NSLog(@"Perform: 3");
        });
    }
}

@end
