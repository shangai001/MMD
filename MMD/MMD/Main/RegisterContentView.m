//
//  RegisterContentView.m
//  MMD
//
//  Created by pencho on 16/3/7.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RegisterContentView.h"
#import "ColorHeader.h"

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
    [self addStatusImageForButtons];
}
- (void)addStatusImageForButtons{
    [self.changeSecurityStatus1 setImage:[UIImage imageNamed:@"no_visible"] forState:UIControlStateNormal];
    [self.changeSecurityStatus1 setImage:[UIImage imageNamed:@"visible"] forState:UIControlStateSelected];
    [self.changeSecurityStatus2 setImage:[UIImage imageNamed:@"no_visible"] forState:UIControlStateNormal];
    [self.changeSecurityStatus2 setImage:[UIImage imageNamed:@"visible"] forState:UIControlStateSelected];
}
- (void)configureSecurityButton{
    self.getSecurityCodeButton.backgroundColor = [UIColor colorWithRed:0.41 green:0.79 blue:0.53 alpha:1];
    self.getSecurityCodeButton.layer.cornerRadius = self.securityNButtonHeight.constant/2.0;
    self.sureButton.backgroundColor = REDCOLOR;
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
- (IBAction)changeStatus1:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        button.selected = !button.selected;
        if (button.selected) {
            self.password1.secureTextEntry = NO;
        }else{
            self.password1.secureTextEntry = YES;
        }
    }
}
- (IBAction)changeStatus2:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        button.selected = !button.selected;
        if (button.selected) {
            self.password2.secureTextEntry = NO;
        }else{
            self.password2.secureTextEntry = YES;
        }
    }
}

@end
