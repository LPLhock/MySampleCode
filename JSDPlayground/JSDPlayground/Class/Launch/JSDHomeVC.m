//
//  JSDHomeVC.m
//  JSDPlayground
//
//  Created by Jersey on 2019/3/18.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import "JSDHomeVC.h"

@interface JSDHomeVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* model;

@end

@implementation JSDHomeVC

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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

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

@end


