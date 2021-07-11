//
//  JSDHomeVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/18.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDHomeVC.h"
#import <objc/runtime.h>
#import <Aspects.h>
#import <JLRoutes/JLRoutes.h>
#import <NSLayoutConstraint+MASDebugAdditions.h>

@interface JSDHomeVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* model;

@end

@interface _NSZombie_ViewController : NSObject



@end

@implementation _NSZombie_ViewController

- (void)zexige {
    
    NSLog(@"haha");
    
    UIView*view;
    [view setNeedsDisplay];
    [view setNeedsLayout];
}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//
//    NSLog(@"调用");
//    return self;
//}
//
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//
//    NSLog(@"haha");
//    return nil;
//}
//
//+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector {
//
//    NSLog(@"转发");
//    return nil;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//
//    NSLog(@"调用");
//}

+ (BOOL)resolveClassMethod:(SEL)sel {
    
    return NO;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature* signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    
    NSLog(@"处理方法签名");
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    NSLog(@"处理方法选择子");
}

@end

@implementation JSDHomeVC

#pragma mark - 1.View Controller Life Cycle

- (void)loadView {
    
    [super loadView];
    NSLog(@"%s", __func__);
    
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidLayoutSubviews {
    
    
    [super viewDidLayoutSubviews];
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    NSLog(@"%s", __func__);
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
    
    NSLog(@"%s", __func__);
    // 调试僵尸对象; _NSZombie_ViewController
    ViewController* vc = [[ViewController alloc] init];
    NSLog(@"%lu", (unsigned long)vc.retainCount);
//    [vc release];
//    NSLog(@"%lu",  vc.retainCount);
//    [vc zexige];
    
//    [vc aspect_hookSelector:@selector(methodSignatureForSelector:) withOptions:AspectPositionAfter usingBlock:^(){
//        NSLog(@"拦截");
//     } error:nil];
//
//    [vc aspect_hookSelector:@selector(forwardInvocation:) withOptions:AspectPositionAfter usingBlock:^(){
//        NSLog(@"拦截");
//    } error:nil];
    
    [vc performSelector:@selector(ziziziz)];
    [vc performSelector:@selector(zexige)];
    
}

//- (BOOL)respondsToSelector:(SEL)aSelector {
//
//    return NO;
//}

//- (void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:animated];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2.SettingView and Style

- (void)setupNavBar {
    self.navigationItem.title = @"JerseyCafe";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (void)reloadView {
    
}

- (void)injected {
    
    [self viewDidLoad];
    [self viewWillAppear:YES];
    [self viewWillDisappear:YES];
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
    
    if ([self.model[indexPath.row] objectForKey:@"route"]) {
        
        NSString* classString = [self.model[indexPath.row] objectForKey:@"class"];
        NSLog(@"控制器%@", classString);
        NSString* classStringUTF8 = [classString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        Class class = NSClassFromString(classStringUTF8);
        ViewController* viewController = [[class alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}



#pragma mark - 5.Event Response

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

#pragma mark - 7.GET & SET

- (UITableView *)tableView {
    
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
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"JSDCatalog" ofType:@"plist"];
        _model = [[NSArray array] initWithContentsOfFile:filePath].copy;
    }
    return _model;
}

//- (BOOL)respondsToSelector:(SEL)aSelector {
//    
//    
//    return YES;
//}

@end


