//
//  JSDPerformanceOptimizationVC.m
//  JSDPlayground
//
//  Created by Jersey on 11/1/2020.
//  Copyright © 2020 Jersey. All rights reserved.
//

#import "JSDPerformanceOptimizationVC.h"

@interface JSDPerformanceOptimizationVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* model;

@end

@implementation JSDPerformanceOptimizationVC

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
    
}

- (void)setupView {
    
    [self.view addSubview:self.tableView];
}

- (void)reloadingView {
    
    
}

#pragma mark - 3 Request Data

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
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.model[indexPath.row] objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.model[indexPath.row] objectForKey:@"route"]) {
        
        Class class = NSClassFromString([self.model[indexPath.row] objectForKey:@"class"]);
        JSDViewController* viewController = [[class alloc] init];
        viewController.title = [self.model[indexPath.row] objectForKey:@"title"];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
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

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"cell"];
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
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"JSDPerformanceOptimization" ofType:@"plist"];
        
        _model = [[NSArray array] initWithContentsOfFile:filePath].copy;
    }
    return _model;
}

@end

