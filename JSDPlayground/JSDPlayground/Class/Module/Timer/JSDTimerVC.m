//
//  JSDTimerVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/19.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDTimerVC.h"

typedef struct jersey {
    NSString* name;
}JerseyCafe;
@interface JSDTimerVC ()

@property (nonatomic, copy) NSString* name;
@end

@implementation JSDTimerVC


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
    self.navigationItem.title = @"定时器";
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.name willChangeValueForKey:@"name"];
    [self setName:@"Jersey"];
//    [self.name didChangeValueForKey:@"name"];
    
    UIView* timerView = [[NSBundle mainBundle] loadNibNamed:@"JSDTimerView" owner:nil options:nil].lastObject;
    [self.view addSubview: timerView];
 
}



- (void)setName:(NSString *)name {
    
    [self.name willChangeValueForKey:@"name"];
    _name = name;
    [self.name didChangeValueForKey:@"name"];
}

+ (BOOL)automaticallyNotifiesObserversOfName {
    
    return NO;
}

- (void)reloadView {
    
}

#pragma mark - 3.Request Data

- (void)setupData {
    
}

#pragma mark - 4.UITableViewDataSource and UITableViewDelegate

#pragma mark - 5.Event Response

- (IBAction)clickNSTimer:(id)sender {
    
    NSTimer* timer = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static NSInteger number = 0;
        NSLog(@"运行 NSTimer 定时器%ld", number);
        number++;
    }];

    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
}

- (IBAction)clickCADisplayLink:(id)sender {
    
    CADisplayLink* link = [CADisplayLink displayLinkWithTarget:self selector:@selector(execuTimerTask)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}

- (IBAction)clickGCDTimer:(id)sender {
    
    
}

- (IBAction)clickPerformSelected:(id)sender {
    
}

#pragma mark - 6.Private Methods

- (void)setupNotification {
    
}

- (void)execuTimerTask {
    
    static NSInteger number = 0;
    NSLog(@"正在执行定时任务%ld", number);
    number++;
}

#pragma mark - 7.GET & SET

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"通知咯");
}

@end


@implementation UIView(haha)

- (id)jersey {
    
    NSObject *obj = [[NSObject alloc] init];
    return obj;
}

- (JerseyCafe) jerseyhaha {
    
    JerseyCafe jersey = {@"Jersey"};
    
    return jersey;
}

@end
