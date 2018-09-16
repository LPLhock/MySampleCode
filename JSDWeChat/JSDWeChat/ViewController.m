//
//  ViewController.m
//  JSDWeChat
//
//  Created by jersey on 2018/6/6.
//  Copyright © 2018年 jersey. All rights reserved.
//

#import "ViewController.h"

#import "JSDSuspensionView.h"
#import "JSDTrashView.h"
#import "JSDDradRect.h"
#import <objc/runtime.h>
#import "JSDCategory.h"

@interface ViewController ()

@property(nonatomic, strong) JSDSuspensionView* suspensionView;
@property(nonatomic, strong) JSDTrashView* trashView;
@property(nonatomic, strong) JSDDradRect* jsdView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //设置View
    [self setupView];
    
    Class currentClass = [JSDCategory class];
    JSDCategory *my = [[JSDCategory alloc] init];
    
    if (currentClass) {
        
        unsigned int methodCount;
        Method* methodList = class_copyMethodList(currentClass, &methodCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        
        for (NSInteger i = 0; i < methodCount; i++) {
            Method method = methodList[i];
            NSString* methodName = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
            
            if ([@"wathareyou" isEqualToString:methodName]) {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
            }
        }
        typedef void (*fn) (id, SEL);
        
        if (lastImp != NULL) {
            fn f = (fn)lastImp;
            f(my,lastSel);
        }
        free(methodList);
    }
    
    
//    if (currentClass) {
//        unsigned int methodCount;
//        Method *methodList = class_copyMethodList(currentClass, &methodCount);
//        IMP lastImp = NULL;
//        SEL lastSel = NULL;
//        for (NSInteger i = 0; i < methodCount; i++) {
//            Method method = methodList[i];
//            NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(method))
//                                                      encoding:NSUTF8StringEncoding];
//            if ([@"wathareyou" isEqualToString:methodName]) {
//                lastImp = method_getImplementation(method);
//                lastSel = method_getName(method);
//            }
//        }
//        typedef void (*fn)(id,SEL);
//
//        if (lastImp != NULL) {
//            fn f = (fn)lastImp;
//            f(my,lastSel);
//        }
//        free(methodList);
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- setupView

- (void)setupView{
    //添加悬浮窗口。
    [self.view addSubview:self.suspensionView];
    //添加底部清除窗口。
    [self.view addSubview:self.trashView];
    
    [self.view addSubview:self.jsdView];
}

#pragma mark ---- SET&GET

- (JSDSuspensionView *)suspensionView
{
    if (!_suspensionView) {
        _suspensionView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSDSuspensionView class]) owner:nil options:nil].lastObject;
        _suspensionView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    }
    return _suspensionView;
}

-(void)viewWillLayoutSubviews
{
    
}


- (JSDTrashView *)trashView
{
    if (!_trashView) {
        _trashView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSDTrashView class]) owner:nil options:nil].lastObject;
        _trashView.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 100, 100, 100);
    }
    return _trashView;
}

- (JSDDradRect *)jsdView
{
    if (!_jsdView) {
        _jsdView = [[JSDDradRect alloc] initWithFrame: CGRectMake(50, 50, 100, 100)];
    }
    return _jsdView;
}

@end

@interface UIView(zexidao)

@end

@implementation UIView(zexidao)



@end



