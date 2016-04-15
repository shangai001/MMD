//
//  RefundHeaderView.m
//  MMD
//
//  Created by pencho on 16/4/14.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RefundHeaderView.h"

@implementation RefundHeaderView

- (void)awakeFromNib{
    self.selectedIndex = 0;
}
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    if (_selectedIndex == 0) {
        self.lineViewCenterX.constant = 0;
    }else if (_selectedIndex == 1){
        self.lineViewCenterX.constant = self.frame.size.width/2;
    }
    [self layoutIfNeeded];
}
- (void)layoutSubviews{
    
}
- (IBAction)firstAction:(id)sender {
    self.selectedIndex = 0;
    if (self.SwitchBlock) {
        self.SwitchBlock(0);
    }
}
- (IBAction)secondAction:(id)sender {
    self.selectedIndex = 0;
    if (self.SwitchBlock) {
        self.SwitchBlock(1);
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
