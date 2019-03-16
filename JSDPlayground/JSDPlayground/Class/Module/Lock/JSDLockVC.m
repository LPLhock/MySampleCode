//
//  JSDLockVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/16.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDLockVC.h"

static NSArray* lockTypeArray;
@interface JSDLockVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* model;
@property (nonatomic, strong) NSArray* lockTypeArray;

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
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
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
    
    NSObject* obj = [[NSObject alloc] init];
    
    dispatch_queue_t queue0 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue0, ^{
        @synchronized (obj) {
            NSLog(@"queue0访问 Obj");
            sleep(3);
            dispatch_async(queue0, ^{
                dispatch_async(queue0, ^{
//                    @synchronized (obj) {
                        NSLog(@"queue0++--访问 Obj");
                        sleep(3);
                        
                        NSLog(@"queue0++--访问 Obj结束");
//                    }
                });
                @synchronized (obj) {
                    NSLog(@"queue0+++访问 Obj");
                    sleep(3);
                    
                    NSLog(@"queue0+++访问 Obj结束");
                }
            });
            NSLog(@"queue0访问 Obj结束");
        }
    });
    dispatch_async(queue0, ^{
        @synchronized (obj) {
            NSLog(@"queue0---访问 Obj");
            sleep(3);
            
            NSLog(@"queue0---访问 Obj结束");
        }
    });
    dispatch_async(queue1, ^{
        @synchronized (obj) {
            NSLog(@"queue1访问 Obj");
            sleep(3);
            
            NSLog(@"queue1访问 Obj结束");
        }
    });
//    dispatch_async(queue0, ^{
////        @synchronized (obj) {
//            NSLog(@"不使用锁queue0访问 Obj");
//            sleep(3);
//            NSLog(@"不使用锁queue0访问 Obj结束");
////        }
//
//    });
//    dispatch_async(queue1, ^{
//
//        //            @synchronized (obj) {
//        NSLog(@"不使用锁queue1访问 Obj");
//        sleep(3);
//
//        NSLog(@"不使用锁queue1访问 Obj结束");
//        //            }
//    });
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
