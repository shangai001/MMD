//
//  RegisterContentView.m
//  MMD
//
//  Created by pencho on 16/3/7.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RegisterContentView.h"

@implementation RegisterContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [self configureSecurityButton];
}
- (void)configureSecurityButton{
    self.getSecurityCodeButton.backgroundColor = [UIColor colorWithRed:0.41 green:0.79 blue:0.53 alpha:1];
    self.getSecurityCodeButton.layer.cornerRadius = self.securityNButtonHeight.constant/2.0;
}
- (void)changeSecurityButtonWaitingStatus:(NSInteger)seconds{
    NSString *title = [NSString stringWithFormat:@"%ldS后重新获取",seconds];
    [self.getSecurityCodeButton setTitle:title forState:UIControlStateNormal];
    self.getSecurityCodeButton.enabled = NO;
}
- (void)changeSecurityButtonNormalStatus{
    NSString *normalTitle = @"获取短信验证码";
    [self.getSecurityCodeButton setTitle:normalTitle forState:UIControlStateNormal];
    self.getSecurityCodeButton.enabled = YES;
}
@end
