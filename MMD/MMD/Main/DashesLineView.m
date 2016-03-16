//
//  DashesLineView.m
//  MMD
//
//  Created by pencho on 16/3/16.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "DashesLineView.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation DashesLineView

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
    self.startPoint = CGPointMake(0, self.frame.size.height/2);
    self.endPoint = CGPointMake(self.frame.size.width, self.frame.size.height/2);
//    self.lineColor = [UIColor redColor];
    self.lineWidth = 2.0f;
    self.realLineWidth = 5.0f;
    self.dashLineWidth = 2.0f;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.lineType == kRedDasheType) {
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGFloat lengths[] = {self.realLineWidth,self.dashLineWidth};
        CGContextSetLineDash(context, 0, lengths,2);
        CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);
        CGContextAddLineToPoint(context, self.endPoint.x,self.startPoint.y);
        CGContextStrokePath(context);
        CGContextClosePath(context);
    }else if(self.lineType == kRedRealType){
        
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);
        CGContextAddLineToPoint(context, self.endPoint.x,self.startPoint.y);
        CGContextStrokePath(context);
        CGContextClosePath(context);
    }else if (self.lineType == kGrayRealType){
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);
        CGContextAddLineToPoint(context, self.endPoint.x,self.startPoint.y);
        CGContextStrokePath(context);
        CGContextClosePath(context);
    }
}
@end
