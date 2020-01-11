//
//  JSDWebViewVC.m
//  JSDPlayground
//
//  Created by Jersey on 17/11/2019.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDWebViewVC.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <CoreLocation/CoreLocation.h>
#import <LocalAuthentication/LocalAuthentication.h>

struct zexidao {
    int xiaoli;
    NSInteger haha;
} haha;
struct
{
    int a;
    char b;
    double c;
} s1;

struct SIMPLE
{
    int a;
    char b;
    double c;
};

typedef struct {
    
} hahah;

struct B;    //对结构体B进行不完整声明
 
//结构体A中包含指向结构体B的指针
struct A
{
    struct B *partner;
    //other members;
};

struct Books
{
   char  title[50];
   char  author;
   char  subject[100];
   int   book_id;
} book = {"C 语言", 'xu', "编程语言", 123456};

@interface JSDWebViewVC () <UITableViewDelegate,UITableViewDataSource, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property(nonatomic, strong, readonly) UITableView *tableView;
@property(nonatomic, copy) NSArray *datasource;
@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) JSContext *context;
@property(nonatomic, strong) NSString *zexi;


@end

@implementation JSDWebViewVC

{
    
    NSString* _isZexiw;
}

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.设置导航栏
    [self setupNavBar];
    //2.设置view
    [self setupView];
    //3.请求数据
    [self setupData];
    //5.解析数据
    [self setupAnalyticalData];
    //6.设置通知
    [self setupNotification];
    //7.private
    [self setupPrivateMethod];
    
}

#pragma mark - 2 SettingView and Style

-(void)setupNavBar {
    
    self.navigationItem.title = @"WebView";
}

- (void)setupView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: kJSDCellIdentifier];
    [self.view addSubview:self.tableView];
    
    typedef struct zexidao zexiStruct;
    zexiStruct zexi;
    zexiStruct *zexio;
    
    struct SIMPLE s1, *s2, t2[20];
    
//    typedef struct Books Book1;
//    Book1* bk;
    struct Books Book1;
    struct Books *BOOO;
    BOOO = &Book1;
//    typedef struct objc_class *Class;
//    Class isa;
//    typedef struct objc_class *ssss;
//    ssss isss;
//    objc_allocateClassPair(<#Class  _Nullable __unsafe_unretained superclass#>, <#const char * _Nonnull name#>, <#size_t extraBytes#>)
    
    Class newClass;
    
    id instanceOfNewClass =
        [[newClass alloc] initWithDomain:@"someDomain" code:0 userInfo:nil];
    [instanceOfNewClass performSelector:@selector(report)];
//    [instanceOfNewClass release];
    [self reloadingView];
}

- (void)reloadingView {
    
    WKUserContentController* wk = [[WKUserContentController alloc] init];
    WKWebViewConfiguration* config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = wk;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
//    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    
    
    [self.view addSubview:self.webView];
    
    
    NSURL* baiduURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"indexss" ofType:@"html"]];
    
//    NSURL* baiduURL = [NSURL URLWithString:@"https://www.juejin.im"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:baiduURL]];
    
    
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//
//    dispatch_async(queue, ^{
//        dispatch_block_t block = dispatch_block_create_with_qos_class(0, QOS_CLASS_UTILITY, 0, ^{
//            for (NSInteger i = 0; i < 50000; i++) {
//                NSObject* object = NSObject.new;
//
//                NSLog(@"当前线程:%@", [NSThread currentThread]);
//            }
//        });
//        block();
//    });
    
    NSLog(@"%s-%c", book.title, book.author);
    
    [self setValue:@"key" forKey:@"zexiw"];
}

#pragma mark - 3 Request Data

- (void)setupData {
    
    
}

#pragma mark - 4 UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kJSDCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.datasource[indexPath.row] objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.datasource[indexPath.row] objectForKey:@"route"]) {
        
        Class class = NSClassFromString([self.datasource[indexPath.row] objectForKey:@"class"]);
        UIViewController* viewController = [[class alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"调用了");
}

#pragma mark - 5 Event Response


- (void)setupAnalyticalData {
    
    
}
#pragma mark - 6 Private Methods

- (void)setupNotification {
    
}

- (void)setupPrivateMethod {
    
    
}

#pragma mark - 7 GET & SET

//- (UITableView *)tableView {
//
//    if (!self.tableView) {
//
//        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//         [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: kJSDCellIdentifier];
//    }
//    return _tableView;
//}

- (NSArray *)datasource {
    
    if (!_datasource) {
        
        _datasource = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"JSDWebView" ofType:@"plist"]];
    }
    return _datasource;
}

//- (NSString* )_setZexi:(NSString *)zexi {
//
//    _zexi = [zexi copy];
//
//    return _zexi;
//}


@end

