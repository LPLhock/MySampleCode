//
//  JSDSuspensionView.m
//  JSDWeChat
//
//  Created by jersey on 2018/6/6.
//  Copyright © 2018年 jersey. All rights reserved.
//

#import "JSDSuspensionView.h"

@implementation JSDSuspensionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    self.layer.cornerRadius = 30;
    self.layer.masksToBounds = YES;
    
    //添加单击手势
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWindon)];
    [self addGestureRecognizer:tapGesture];
    
    [super awakeFromNib];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];

    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];

    CGPoint center = self.center;
    center.x +=  currentPoint.x - previousPoint.x;
    center.y +=  currentPoint.y - previousPoint.y;

    self.center = center;
}

- (void)clickWindon {
    NSLog(@"单击窗口");
}

@end
