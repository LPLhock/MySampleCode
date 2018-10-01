//
//  ViewController.m
//  JSDUITableViewReuseMethods
//
//  Created by Jersey on 2018/10/1.
//  Copyright © 2018年 Jersey. All rights reserved.
//

#import "ViewController.h"

static NSArray* model;
static NSArray* viewContorllerModel;
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

+ (void)initialize {
    
   model = @[@"提前注册 Cell(Class)", @"延迟注册 Cell(Class)", @"提前注册 Cell(Nib)", @"延迟注册 Cell(Nib)"];
    viewContorllerModel = @[@"JSDClassReusingViewController"];
}

#pragma mark - 1.ViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return model.count;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = model[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    Class viewControllerClass = NSClassFromString(viewContorllerModel[indexPath.row]);
    UIViewController* viewController = [[viewControllerClass alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}


#pragma mark - Set && Get
@end
