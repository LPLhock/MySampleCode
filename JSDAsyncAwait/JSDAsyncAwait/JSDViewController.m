//
//  JSDViewController.m
//  JSDAsyncAwait
//
//  Created by Jersey on 2021/11/3.
//

#import "JSDViewController.h"
#import "JSDAsyncAwait-Swift.h"

@interface JSDViewController ()

@property (nonatomic, strong) NSArray *nonatomicArray;
@property (atomic, strong) NSArray *atomicArray;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) dispatch_queue_t serialQueue;

@end

@implementation JSDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Objective-C";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.lock = [NSLock new];
    self.serialQueue = dispatch_queue_create("JSD", DISPATCH_QUEUE_SERIAL);
    
    [self setupView];
    
//    [self setupNonatomicArray];
//    [self setupatomicArray];
//    [self setupArrayAutoreleasepool];
    
    // 测试 Autoreleasepool 减低内存峰值
    [self testAutoreleasepoolWithNumber: 9999999999];
}

- (void)setNonatomicArray:(NSArray *)nonatomicArray {
    if (!nonatomicArray) return;
//    [self.lock lock];
//    _nonatomicArray = nonatomicArray;
//    [self.lock unlock];
    dispatch_async(self.serialQueue, ^{
        self.nonatomicArray = nonatomicArray;
    });
}

- (void)setupNonatomicArray {
    for (int i = 0; i < 10000; i++) {
        dispatch_queue_t cQueue = dispatch_queue_create("JSD", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(cQueue, ^{
            NSInteger number =  (arc4random() % 99999) + 1;
            NSArray* randomArray = @[@(number)];
            self.nonatomicArray = randomArray;
            NSLog(@"JerseyBro: func: %s, index: %d, array: %@", __func__, i, randomArray);
        });
    }
}

- (void)setupatomicArray {
    for (int i = 0; i < 10000; i++) {
        dispatch_queue_t cQueue = dispatch_queue_create("JSD", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(cQueue, ^{
            NSInteger number =  (arc4random() % 99999) + 1;
            NSArray* randomArray = @[@(number)];
            self.atomicArray = randomArray;
            NSLog(@"JerseyBro: func: %s, index: %d, array: %@", __func__, i, randomArray);
        });
    }
}

- (void)setupArrayAutoreleasepool {
    for (int i = 0; i < 10000; i++) {
        dispatch_queue_t cQueue = dispatch_queue_create("JSD", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(cQueue, ^{
            @autoreleasepool {
                NSInteger number =  (arc4random() % 99999) + 1;
                NSArray* randomArray = @[@(number)];
                self.nonatomicArray = randomArray;
                NSLog(@"JerseyBro: func: %s, index: %d, array: %@", __func__, i, randomArray);
            }
        });
    }
}

- (void)testAutoreleasepoolWithNumber:(NSUInteger)number {
    // largeNumber是一个很大的数
    for (NSUInteger i = 0; i < number; i++) {
        @autoreleasepool {
        NSString *str = [NSString stringWithFormat:@"hello -%04lu", (unsigned long)i];
        str = [str stringByAppendingString:@" - world"];
        NSLog(@"%@", str);
        }
    }
}

- (void)setupView {
    UIButton* button = [UIButton new];
    [button setTitle:@"RunLoop" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button sizeToFit];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(onTouchButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onTouchButton {
    UIViewController* runLoopVC = [[NSClassFromString(@"JSDRunLoopVC") class] new];
    UINavigationController* runLoopNavVC = [[UINavigationController alloc] initWithRootViewController:runLoopVC];
    [self presentViewController:runLoopNavVC animated:true completion:nil];
}

@end
