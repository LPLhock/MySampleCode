//
//  JSDLockVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/16.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDLockVC.h"
#import <libkern/OSAtomic.h>
#import <objc/runtime.h>

struct objcJersey {
    Class isa;
};

typedef struct objcJersey *ib;

static NSArray* lockTypeArray;

@interface JSDLockVC ()<UITableViewDataSource, UITableViewDelegate, CALayerDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* model;
@property (nonatomic, strong) NSArray* lockTypeArray;
@property (nonatomic, assign) NSInteger moneySum;
@property (nonatomic, copy) NSString* stringA;
@property (atomic, copy) NSString* stringB;
@property(nonatomic, strong) UIView *zexidaoView;

@end

@implementation JSDLockVC

#pragma mark - 1.View Controller Life Cycle

+ (void)initialize {
    
    lockTypeArray = @[@"OSSpinLock", @"dispatch_semaphore", @"pthread_mutex", @"NSLock", @"NSCondition", @"pthread_mutex(recursive)", @"NSRecursiveLock", @"NSConditionLock", @"synchronized",];
}

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
    
//    self.zexidaoView = [[UIView alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    self.navigationItem.title = @"Lock详情";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    UIView* drawView = [[UIView alloc] init];
    drawView.backgroundColor = [UIColor redColor];
    drawView.frame = CGRectMake(0, 100, 100, 100);
    drawView.layer.delegate = self;
    [drawView setNeedsDisplay];
    [self.view addSubview:drawView];
}


- (void)displayLayer:(CALayer *)layer {
    
    NSLog(@"嘻嘻");
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    NSLog(@"哈哈");
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
    self.moneySum = 100;
}


#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.model.count;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kJSDCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.model[indexPath.row] objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString* lockTitle = lockTypeArray[indexPath.row];
    SEL lockMethod = NSSelectorFromString(lockTitle);
    if ([self respondsToSelector:lockMethod]) {
        [self performSelector:lockMethod withObject:nil];
    }
}

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

#pragma mark - @synchronized

- (void)synchronized {
    
    // 模拟多线程访问,
    dispatch_queue_t queue0 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue0, ^{
//        @synchronized (self) {
            NSLog(@"queue0 异步并发执行");
            self.moneySum += 200;
            NSLog(@"queue0 异步并发修改金额, %ld", self.moneySum);
//        };
    });
    dispatch_async(queue1, ^{
//        @synchronized (self) {
            NSLog(@"queue1 异步并发执行");
            
            NSLog(@"queue1 异步并发读取, %ld", self.moneySum);
//        };
    });
    dispatch_async(queue1, ^{
//        @synchronized (self) {
            NSLog(@"queue1 异步并发执行任务");
            self.moneySum += 200;
            NSLog(@"queue1 异步并发金额, %ld", self.moneySum);
//        };
    });
    
    dispatch_async(queue0, ^{
//        @synchronized (self) {
            NSLog(@"queue0 异步并发执行");
            
            NSLog(@"queue0 异步并发读取, %ld", self.moneySum);
//        };
    });
}

- (void)dispatch_semaphore {
    
    // 模拟多线程访问,
    dispatch_queue_t queue0 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    
    self.moneySum = 100;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    
    dispatch_async(queue0, ^{
        dispatch_semaphore_wait(semaphore, timeout);
        self.moneySum -= 50;
        NSLog(@"queue0修改完成之后金额%ld", self.moneySum);
        dispatch_semaphore_signal(semaphore);
        
    });
    
    dispatch_async(queue1, ^{
        dispatch_semaphore_wait(semaphore, timeout);
        NSLog(@"queue1 阻塞4S 减去金额之前%ld", self.moneySum);
        sleep(4);
        self.moneySum -= 30;
        NSLog(@"queue1 阻塞4S 减去金额之后%ld", self.moneySum);
        dispatch_semaphore_signal(semaphore);
        
    });
    
    dispatch_async(queue1, ^{
        dispatch_semaphore_wait(semaphore, timeout);
        NSLog(@"queue1 读取%ld", self.moneySum);
        dispatch_semaphore_signal(semaphore);
        
    });
}

- (void)NSLock {
    
    NSLock* lock = [[NSLock alloc] init];
    
    self.moneySum = 100;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lock lock];
        self.moneySum += 20;
        NSLog(@"数量%ld," ,self.moneySum);
        sleep(2);
        [lock unlock];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [lock lock];
        
        NSLog(@"再次访问数量%ld,", self.moneySum);
        [lock unlock];
    });
}

- (void)NSRecursiveLock {
    
//    NSLock *lock = [[NSLock alloc] init];
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        static void (^RecursiveMethod)(int);
        
        RecursiveMethod = ^(int value) {
            
            [lock lock];
            if (value > 0) {
                
                NSLog(@"value = %d", value);
                sleep(1);
                RecursiveMethod(value - 1);
            }
            if (value != 5) {
                [lock unlock];
            }
        };
        
        RecursiveMethod(5);
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lock lock];
        NSLog(@"另一个子线程线程访问");
        sleep(2);
//        [lock unlock];
    });
}

- (void)NSConditionLock {
    
    NSConditionLock* conditionLock = [[NSConditionLock alloc] init];
    NSMutableArray *products = [NSMutableArray array];
    
    NSInteger HAS_DATA = 1;
    NSInteger NO_DATA = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
//            NSLog(@"尝试开锁%ld", [conditionLock tryLock]);
            [conditionLock lockWhenCondition:NO_DATA];
            NSLog(@"尝试开锁%ld", [conditionLock tryLock]);
            [products addObject:[[NSObject alloc] init]];
            NSLog(@"produce a product,总量:%zi",products.count);
            [conditionLock unlockWithCondition:HAS_DATA];
            NSLog(@"尝试开锁%ld", [conditionLock tryLock]);
            sleep(1);
        }
        
    });
}

- (void)OSSpinLock {
    
    __block OSSpinLock osLock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        OSSpinLockLock(&osLock);
        NSLog(@"线程1");
        sleep(15);
        OSSpinLockUnlock(&osLock);
        NSLog(@"线程1解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        OSSpinLockLock(&osLock);
        NSLog(@"线程2");
        OSSpinLockUnlock(&osLock);
        NSLog(@"线程2解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        OSSpinLockLock(&osLock);
        NSLog(@"线程4");
        sleep(15);
        OSSpinLockUnlock(&osLock);
        NSLog(@"线程4解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        sleep(1);
        OSSpinLockLock(&osLock);
        NSLog(@"线程3");
        OSSpinLockUnlock(&osLock);
        NSLog(@"线程3解锁成功");
    });
}

- (void)NSCondition {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 50; i ++) {
            @synchronized (self) {
                if (i % 2 == 0) {
                    self.stringA = @"a very long string";
                }
                else {
                    self.stringA = @"string";
                }
                NSLog(@"Thread A: %@\n", self.stringA);
            }
        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //thread B
        for (int i = 0; i < 50; i ++) {
         @synchronized (self) {
            if (self.stringA.length >= 10) {
                NSString* subStr = [self.stringA substringWithRange:NSMakeRange(0, 10)];
            }
            NSLog(@"Thread B: %@\n", self.stringA);
        }
        }
    });

}

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: kJSDCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

- (NSArray *)model {
    
    if (!_model) {
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"JSDLock" ofType:@"plist"];
        _model = [[NSArray array] initWithContentsOfFile:filePath].copy;
        
    }
    return _model;
}

@end
