//
//  JSDClassReusingViewController.m
//  JSDUITableViewReuseMethods
//
//  Created by Jersey on 2018/10/1.
//  Copyright © 2018年 Jersey. All rights reserved.
//

#import "JSDClassReusingViewController.h"

#import "JSDClassReusingCell.h"

static NSString* const classReusingCellIdentifier = @"classReusingCellIdentifier";
@interface JSDClassReusingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JSDClassReusingViewController

#pragma mark - 1.ViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    // 注册
    [self.tableView registerClass:@"JSDClassReusingCell" forCellReuseIdentifier:classReusingCellIdentifier];
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JSDClassReusingCell* cell = [tableView dequeueReusableCellWithIdentifier:classReusingCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = @"哈哈";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}




@end
