//
//  HeaderView.m
//  MMD
//
//  Created by pencho on 16/2/19.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "HeaderView.h"

CGFloat const BUTTON_BASETAG = 100;


@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/**
*  底部线条的宽度待定
*/
//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        _selectedIndex = -1;
//    }
//    return self;
//}

- (void)awakeFromNib{
    _selectedIndex = 0;
    [self bringSubviewToFront:self.bottomLineView];
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    UIButton *firstButton = (UIButton *)[self viewWithTag:BUTTON_BASETAG];
    UIButton *selectButton = (UIButton *)[self viewWithTag:_selectedIndex + BUTTON_BASETAG];
    [UIView animateWithDuration:0.15 animations:^{
        CGPoint linePoint = self.bottomLineView.center;
        linePoint.x = selectButton.center.x;
        self.bottomLineView.center = linePoint;
        self.lineCenterX.constant = linePoint.x - firstButton.center.x;
    }];
    [self bringSubviewToFront:self.bottomLineView];
}
- (void)callHeaderDelegate:(UIButton *)selectedButton{
    if ([self.headerDelegate respondsToSelector:@selector(didSelectButton:buttonIndex:)]) {
        [self.headerDelegate didSelectButton:selectedButton buttonIndex:self.selectedIndex];
    }
}
- (IBAction)askLoan:(id)sender {
    self.selectedIndex = 0;
    [self callHeaderDelegate:sender];
}
- (IBAction)promotion:(id)sender {
    self.selectedIndex = 1;
    [self callHeaderDelegate:sender];
}
- (IBAction)query:(id)sender {
    self.selectedIndex = 2;
    [self callHeaderDelegate:sender];
}

@end
