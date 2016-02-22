//
//  HeaderView.m
//  MMD
//
//  Created by pencho on 16/2/19.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "HeaderView.h"
#define BUTTON_BASETAG 100

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    self.selectedIndex = 0;
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    UIButton *selectButton = (UIButton *)[self viewWithTag:_selectedIndex + BUTTON_BASETAG];
    
    [UIView animateWithDuration:0.15 animations:^{
        CGPoint linePoint = self.bottomLineView.center;
        linePoint.x = selectButton.center.x;
        self.bottomLineView.center = linePoint;
    }];
    
}
- (IBAction)askLoan:(id)sender {
}
- (IBAction)promotion:(id)sender {
}
- (IBAction)query:(id)sender {
}

@end
