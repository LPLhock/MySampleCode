//
//  JSDUIWebViewController.m
//  JSDWebView
//
//  Created by jersey on 2018/6/26.
//  Copyright © 2018年 jersey. All rights reserved.
//

#import "JSDUIWebViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIWebView.h>

@protocol JSObjcDelegate <JSExport>

//JSExportAs(callCamera, - (void) hahah);
JSExportAs(callCamera,
           - (void)printSome:(NSString *)string
           );

- (void)callCamera;
- (void)share:(NSString *)shareString;

@end

@interface JSDUIWebViewDelegate : NSObject

@end

@interface JSDUIWebViewDelegate ()<JSObjcDelegate>

@end

@implementation JSDUIWebViewDelegate

- (void)printSome:(NSString *)string{
    NSLog(@"嘻嘻嘻嘻动态绑定了哦");
}

- (void)webView:(UIWebView *)view didCreateJavaScriptContext:(JSContext *)context forFrame:(CGRect)frame
{
    NSLog(@"哈哈哈拦在WebKit方法 获取上下文%@",context);
}

- (void)callCamera{
    NSLog(@"哈哈哈, 我是中间人哦%@", self);
}
- (void)share:(NSString *)shareString{
    NSLog(@"嗯哼嗯哼");
}

@end

@interface JSDUIWebViewController ()<UIWebViewDelegate, JSObjcDelegate>

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) JSContext* jsContext;
@property (nonatomic, strong) JSDUIWebViewDelegate* delegate;

@end

@implementation JSDUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView stringByEvaluatingJavaScriptFromString:<#(nonnull NSString *)#>
    
    [self setupView];
    
    [self setupNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 2. Setting View and Style

- (void)setupView{
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"webTest.html" ofType:nil];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [webView loadRequest:request];
    webView.delegate = self;
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    NSLog(@"获取上下文%@",self.jsContext);
    
    [self.view addSubview:webView];
}

- (void)setupNavBar{
    
    self.navigationItem.title = NSStringFromClass([self class]);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(gotoVC)];
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
//    self.webView.hash;
    
    // 配置代理
    [self confignDelegate];
    
    // 注入 JS 调用.
//    [self injectJavaScript];
    
    NSLog(@"%@",self.jsContext);
}

- (void)confignDelegate{
    
    
    self.delegate = [[JSDUIWebViewDelegate alloc] init];
    self.jsContext[@"Toyun"] = self.delegate;
    
}

- (void)injectJavaScript{
    
    [self.jsContext evaluateScript:@"function add(a, b) { return a + b; }"];
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (void)callCamera {
    NSLog(@"callCamera");
    NSThread* thread = [NSThread currentThread];

    NSLog(@"当前线程:%@", thread);

    dispatch_sync(dispatch_get_main_queue(), ^{
        NSThread* thread = [NSThread currentThread];

        NSLog(@"当前线程:%@", thread);

        UIView* view = [[UIView alloc] init];
        view.frame = CGRectMake(100, 300, 200, 200);
        view.backgroundColor = [UIColor redColor];
        [self.webView.scrollView addSubview:view];
    });

//    UIView* view = [[UIView alloc] init];
//    view.frame = CGRectMake(100, 300, 200, 200);
//    view.backgroundColor = [UIColor blueColor];
//    [self.webView addSubview:view];


    // 获取到照片之后在回调js的方法picCallback把图片传出去
    JSValue *picCallback = self.jsContext[@"picCallback"];
    [picCallback callWithArguments:@[@"photos"]];
}

- (void)share:(NSString *)shareString {
    NSLog(@"share:%@", shareString);
    // 分享成功回调js的方法shareCallback
    JSValue *shareCallback = self.jsContext[@"shareCallback"];
    [shareCallback callWithArguments:nil];
}

#pragma mark -- Custom Method

- (void)gotoVC{
    
    UIViewController* nav = [[UIViewController alloc] init];
    
    NSMutableArray* mutableArray = [self.navigationController.viewControllers mutableCopy];
    [mutableArray removeObjectAtIndex:0];
    [mutableArray addObject:nav];
    
    [self.navigationController setViewControllers:mutableArray.copy animated:YES];
    
}

- (void)webView:(UIWebView *)view didCreateJavaScriptContext:(JSContext *)context forFrame:(CGRect)frame
{
    NSLog(@"哈哈哈拦在WebKit方法 获取上下文%@",context);
}
@end
