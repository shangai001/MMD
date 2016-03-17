//
//  VerticalDashLineView.m
//  MMD
//
//  Created by pencho on 16/3/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "VerticalDashLineView.h"

@interface VerticalDashLineView ()

//@property (nonatomic,strong)UIColor* lineColor;//虚线颜色
@property (nonatomic)CGPoint startPoint;//虚线起点
@property (nonatomic)CGPoint endPoint;//虚线终点

@end
@implementation VerticalDashLineView
- (instancetype)init{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self customInitialize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInitialize];
    }
    return self;
}
//Default Value
- (void)customInitialize{
    self.backgroundColor = [UIColor whiteColor];
    self.lineType = kRedDasheType;
    self.startPoint = CGPointMake(self.frame.size.width/2, 0);
    self.endPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    self.lineWidth = 2.0f;
    self.realLineWidth = 5.0f;
    self.dashLineWidth = 2.0f;
}
- (void)drawRect:(CGRect)rect {
    NSString *px = NSStringFromCGPoint(self.startPoint);
    NSString *py = NSStringFromCGPoint(self.endPoint);
    NSString *frame = NSStringFromCGRect(self.frame);
    
    NSLog(@"px = %@,py = %@ frame = %@",px,py,frame);
    
    // Drawing code
    if (self.lineType == kRedDasheType) {
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGFloat lengths[] = {self.realLineWidth,self.dashLineWidth};
        CGContextSetLineDash(context, 0, lengths,2);
        CGContextMoveToPoint(context, self.frame.size.width/2, 0);
        CGContextAddLineToPoint(context, self.frame.size.width/2,self.frame.size.height);
        CGContextStrokePath(context);
        CGContextClosePath(context);
    }else if(self.lineType == kRedRealType){
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextMoveToPoint(context, self.frame.size.width/2, 0);
        CGContextAddLineToPoint(context, self.frame.size.width/2,self.frame.size.height);
        CGContextStrokePath(context);
        CGContextClosePath(context);
    }else if (self.lineType == kGrayRealType){
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextMoveToPoint(context, self.frame.size.width/2, 0);
        CGContextAddLineToPoint(context, self.frame.size.width/2,self.frame.size.height);
        CGContextStrokePath(context);
        CGContextClosePath(context);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
