//
//  JSDTrashView.m
//  JSDWeChat
//
//  Created by jersey on 2018/6/6.
//  Copyright © 2018年 jersey. All rights reserved.
//

#import "JSDTrashView.h"



//直径
#define radius 60
#define PI 3.14159265358979323846

@implementation JSDTrashView

static inline float radians(double degrees) {
    return degrees * PI / 180;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSLog(@"NIB加载 执行%s",__func__);
}

- (void)drawRect:(CGRect)rect
{
//    CGPoint cent=CGPointMake((self.frame.size.width/2)-radius/2, (self.frame.size.height/2)-radius/2);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextClearRect(ctx, rect);
    
    float angle_start = radians(0.0);
    float angle_end = radians(120.0);
//    CGContextMoveToPoint(ctx, self.frame.size.width, -self.frame.size.height);
    CGContextSetFillColor(ctx, CGColorGetComponents( [[UIColor greenColor] CGColor]));
    CGContextAddArc(ctx, 0, 0 , radius,  angle_start, angle_end, 1);
//    CGContextFillPath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
    
}

@end
