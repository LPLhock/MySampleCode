//
//  JSDKVOVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/10.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDKVOVC.h"

@interface JSDKVOVC ()

@end

@implementation JSDKVOVC


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
    self.navigationItem.title = @"KVO";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
 
    JSDKVOClass* kvoCalss = [[JSDKVOClass alloc] init];
    
    [kvoCalss addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:NULL];
//    [kvoCalss willChangeValueForKey:@"name"];
    kvoCalss.name = @"jersey";
//    [kvoCalss didChangeValueForKey:@"name"];
//    kvoCalss.name = @"jersey";
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([object isKindOfClass:[JSDKVOClass class]]) {
        NSLog(@"触发了KVO新值:%@ 当前%@", [object valueForKey:@"name"], object);
    }
}

#pragma mark - 7.GET & SET

@end

@implementation JSDKVOClass

+ (BOOL)automaticallyNotifiesObserversOfName {

    return YES;
}

//- (void)setValue:(id)value forKey:(NSString *)key {
//
//    [self willChangeValueForKey:key];
//    [super setValue:value forKey:key];
//    [self didChangeValueForKey:key];
//}

- (void)setName:(NSString *)name {

    [self willChangeValueForKey:@"name"];
//    [super setValue:name forKey:@"name"];
    _name = name;
    [self didChangeValueForKey:@"name"];
}

@end

@implementation NSKVONotifying_JSDKVOClass

- (void)setValue:(id)value forKey:(NSString *)key {

    NSLog(@"手动设置 KVO");
    [self willChangeValueForKey:key];
    [super setValue:value forKey:key];
    [self didChangeValueForKey:key];
}


@end
