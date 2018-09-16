//
//  JavaScriptObjectiveCDelegate.h
//  JSDWebView
//
//  Created by jersey on 2018/6/27.
//  Copyright © 2018年 jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JavaScriptObjectiveCDelegate <JSExport>
// JS调用此方法来调用OC的share
- (void)share:(NSDictionary *)params ;

// JS调用此方法来调用OC的相机
- (void)callCamera ;

// 在JS中调用时，多个参数需要使用驼峰方式
// 这里是多个个参数的。
- (void)showAlert:(NSString *)title msg:(NSString *)msg;

// 通过JSON传过来
- (void)callWithDict:(NSDictionary *)params;
// JS调用Oc，然后在OC中通过调用JS方法来传值给JS。
- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params;

@end
