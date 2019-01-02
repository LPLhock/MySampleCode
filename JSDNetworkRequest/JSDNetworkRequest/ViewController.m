//
//  ViewController.m
//  JSDNetworkRequest
//
//  Created by Jersey on 2018/1/2.
//  Copyright © 2018年 Jersey. All rights reserved.
//

#import "ViewController.h"
#import "JSDOperation.h"
#import "JSDOperationQueue.h"
#import "JSDOperationQueueManage.h"

@interface ViewController ()<NSURLSessionDelegate>

@property (nonatomic, strong) NSMutableArray<NSString *>* URLStrings;

@end

@implementation ViewController


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
    self.navigationItem.title = @"";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {

    //初始化 URLSession
    
    JSDOperationQueueManage* operationQueueManage = [JSDOperationQueueManage sharedOperationQueueManage];
    JSDOperationQueue* operationQueue = [operationQueueManage configurationQueueWithKey:@"com.jersey.downloadQueue"];
    
    NSString *taskUrlStringA = @"https://api.beautyplus.com/archive/a878300ad53e9943b56f868a3d98143a.zip";
    NSString *taskUrlStringB = @"https://api.beautyplus.com/archive/5028e1648b88dd6eff249bdd2900009e.zip";
    NSString *taskUrlStringC = @"https://api.beautyplus.com/archive/ff1251f45a2ed767f668604c07905238.zip";
    NSString *taskUrlStringD = @"https://api.beautyplus.com/archive/2659553e8ae587cd6f6ad5bcf77829cf.zip";
    
    [self.URLStrings addObject:taskUrlStringA];
    
    
    NSString* docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    //初始化四个下载任务.
    NSString* pathToSaveA = [docPath stringByAppendingPathComponent:[taskUrlStringA lastPathComponent]];
    JSDOperationItem* operationItemA = [[JSDOperationItem alloc] initWithUrlString:taskUrlStringA pathToSave:pathToSaveA infos:nil taskName:@"ItemA"];
    
    NSString* pathToSaveB = [docPath stringByAppendingPathComponent:[taskUrlStringA lastPathComponent]];
    JSDOperationItem* operationItemB = [[JSDOperationItem alloc] initWithUrlString:taskUrlStringB pathToSave:pathToSaveB infos:nil taskName:@"ItemB"];
    
    NSString* pathToSaveC = [docPath stringByAppendingPathComponent:[taskUrlStringC lastPathComponent]];
    JSDOperationItem* operationItemC = [[JSDOperationItem alloc] initWithUrlString:taskUrlStringC pathToSave:pathToSaveC infos:nil taskName:@"ItemC"];
    
    NSString* pathToSaveD = [docPath stringByAppendingPathComponent:[taskUrlStringD lastPathComponent]];
    JSDOperationItem* operationItemD = [[JSDOperationItem alloc] initWithUrlString:taskUrlStringD pathToSave:pathToSaveD infos:nil taskName:@"ItemD"];
    
    //通过请求任务组与队列 生成相应线程任务。
    JSDOperation* operationA = [[JSDOperation alloc] initWithOperationItem:operationItemA onOperationQueue:operationQueue];
    JSDOperation* operationB = [[JSDOperation alloc] initWithOperationItem:operationItemB onOperationQueue:operationQueue];
    JSDOperation* operationC = [[JSDOperation alloc] initWithOperationItem:operationItemC onOperationQueue:operationQueue];
    JSDOperation* operationD = [[JSDOperation alloc] initWithOperationItem:operationItemD onOperationQueue:operationQueue];
    
    NSLog(@"准备请求网络");
    //依次将任务按顺序添加至队列中,并按顺序执行
    [operationQueue addOperation:operationA];
    [operationQueue addOperation:operationB];
    [operationQueue addOperation:operationC];
    [operationQueue addOperation:operationD];
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (NSMutableArray<NSString *> *)URLStrings {
    
    if (!_URLStrings) {
        _URLStrings = [[NSMutableArray alloc] init];
    }
    return _URLStrings;
}

@end
