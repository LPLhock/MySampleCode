//
//  JSDSearchMediantVC.m
//  JSDPlayground
//
//  Created by Jersey on 7/12/2019.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDSearchMediantVC.h"

@interface JSDSearchMediantVC ()

@end

@implementation JSDSearchMediantVC

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

int findMedian(int a[], int aLen)
{
    int low = 0;
    int high = aLen - 1;
    
    int mid = (aLen - 1) / 2;
    int div = PartSort(a, low, high);
    
    while (div != mid)
    {
        if (mid < div)
        {
            //左半区间找
            div = PartSort(a, low, div - 1);
        }
        else
        {
            //右半区间找
            div = PartSort(a, div + 1, high);
        }
    }
    //找到了
    return a[mid];
}

int PartSort(int a[], int start, int end)
{
    int low = start;
    int high = end;
    
    //选取关键字
    int key = a[end];
    
    while (low < high)
    {
        //左边找比key大的值
        while (low < high && a[low] <= key)
        {
            ++low;
        }
        
        //右边找比key小的值
        while (low < high && a[high] >= key)
        {
            --high;
        }
        
        if (low < high)
        {
            //找到之后交换左右的值
            int temp = a[low];
            a[low] = a[high];
            a[high] = temp;
        }
    }
    
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    
    return low;
}

#pragma mark - 2 SettingView and Style

-(void)setupNavBar {
    
}

- (void)setupView {
    
    //
    
    // 无序数组查找中位数
    int list[10] = {12,3,10,8,6,7,11,13,9};
    // 3 6 7 8 9 10 11 12 13
    //         ^
    int median = findMedian(list, 10);
    printf("the median is %d \n", median);
}

- (void)reloadingView {
    
    
}

#pragma mark - 3 Request Data

- (void)setupData {
    
    
}

#pragma mark - 4 UITableViewDataSource and UITableViewDelegate
#pragma mark - 5 Event Response


- (void)setupAnalyticalData {
    
    
}
#pragma mark - 6 Private Methods

- (void)setupNotification {
    
}

- (void)setupPrivateMethod {
    
    
}

#pragma mark - 7 GET & SET




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

