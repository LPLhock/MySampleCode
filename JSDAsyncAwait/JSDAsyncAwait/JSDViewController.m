//
//  JSDViewController.m
//  JSDAsyncAwait
//
//  Created by Jersey on 2021/11/3.
//

#import "JSDViewController.h"

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
    
    
    [self setupNonatomicArray];
//    [self setupatomicArray];
//    [self setupArrayAutoreleasepool];
}

- (void)setNonatomicArray:(NSArray *)nonatomicArray {
    if (!nonatomicArray) return;
//    [self.lock lock];
//    [self.lock unlock];
    dispatch_async(self.serialQueue, ^{
        self.nonatomicArray = nonatomicArray;
    });
}

- (void)setupNonatomicArray {
    for (int i = 0; i < 100000; i++) {
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
    for (int i = 0; i < 1000000; i++) {
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
    for (int i = 0; i < 1000000; i++) {
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

@end
