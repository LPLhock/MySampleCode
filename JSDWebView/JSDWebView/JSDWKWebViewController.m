//
//  JSDWKWebViewController.m
//  JSDWebView
//
//  Created by jersey on 2018/6/26.
//  Copyright © 2018年 jersey. All rights reserved.
//

#import "JSDWKWebViewController.h"

#import "JSDNavigationController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "JavaScriptObjectiveCDelegate.h"

@interface JSDWKWebViewController ()<WKNavigationDelegate, WKUIDelegate, JavaScriptObjectiveCDelegate>

@property (nonatomic, strong) WKWebView* webView;
@property (nonatomic, strong) JSContext* jsContext;

@end

@implementation JSDWKWebViewController

#pragma mark -- 1. Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
    [self setupNavBar];
    // OC Call JS
    [self callJavaScript];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    if (self.webView) {
        [self.webView reload];
    }
    
}

#pragma mark -- 2. Setting View and Style

- (void)setupView{

    WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame];
//    [WKWebView ] 
//    
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cnblogswwww.com/mddblog/"]];
    // 3.加载网页
    [webView loadRequest:request];

    self.webView = webView;
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    [self.view addSubview:webView];
    
}

- (void)setupNavBar{
    
    self.navigationItem.title = NSStringFromClass([self class]);
    
}

#pragma mark -- Custom Method

- (void)callJavaScript{
    
    JSContext* context;
    JSValue* value;
//    value callWithArguments:<#(NSArray *)#>/Users/jersey/developer/Web/webTest.html
}

#pragma  mark -- WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"请求开始前:%s",__func__);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    NSLog(@"将要开始加载%s",__func__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"收到服务器相应%s",__func__);
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    NSLog(@"重定向");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
    NSLog(@"获取网页内容%s",__func__);
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSLog(@"获取网页内容完成%s",__func__);
    
//    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"model"] = self;
    [self.jsContext evaluateScript:@"callCamera"];
    
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"获取失败%s", __func__);
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"获取失败%s", __func__);
}

#pragma mark -- WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    NSLog(@"prompt:%@---defaultText:%@",prompt,defaultText);
    completionHandler(@"嘿嘿");
    
}

#pragma mark -- mark JavaScriptDelegate

- (void)share:(NSDictionary *)params {
    NSLog(@"Js调用了OC的share方法，参数为：%@", params);
}

- (void)callWithDict:(NSDictionary *)params {
    NSLog(@"Js调用了OC的方法，参数为：%@", params);
}

// JS调用了callCamera
- (void)callCamera {
    NSLog(@"JS调用了OC的方法，调起系统相册");
    
    // JS调用后OC后，可以传一个回调方法的参数，进行回调JS
    JSValue *jsFunc = self.jsContext[@"jsFunc"];
    [jsFunc callWithArguments:nil];
}

- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params {
    NSLog(@"jsCallObjcAndObjcCallJsWithDict was called, params is %@", params);
    
    // 调用JS的方法
    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
    [jsParamFunc callWithArguments:@[@{@"age": @10, @"name": @"lili", @"height": @158}]];
}

// 指定参数的用法
// 在JS中调用时，函数名应该为showAlertMsg(arg1, arg2)
- (void)showAlert:(NSString *)title msg:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [a show];
    });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
