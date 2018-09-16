//
//  JSDDradRect.m
//  JSDWeChat
//
//  Created by jersey on 2018/6/7.
//  Copyright © 2018年 jersey. All rights reserved.
//

#import "JSDDradRect.h"

void MycreatBitmapContext (int pixelsWide, int pixelsHigh){
    
//    CGContextRef context;
    
   UIGraphicsBeginImageContextWithOptions(CGSizeMake(pixelsHigh, pixelsHigh), NO, 1);
    
    
}

@implementation JSDDradRect


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(contextRef, 1, 0, 0, 1);
    CGContextFillRect(contextRef, CGRectMake(0, 0, 100, 100));
//    CGPDFContextCreateWithURL(<#CFURLRef  _Nullable url#>, <#const CGRect * _Nullable mediaBox#>, <#CFDictionaryRef  _Nullable auxiliaryInfo#>)
//    CGPDFContextCreate(<#CGDataConsumerRef  _Nullable consumer#>, <#const CGRect * _Nullable mediaBox#>, <#CFDictionaryRef  _Nullable auxiliaryInfo#>)
    
}

@end
