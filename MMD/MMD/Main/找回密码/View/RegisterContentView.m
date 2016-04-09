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
//改变“获取手机验证码”状态-->"xxS后重新获取"
- (void)changeSecurityButtonWaitingStatus:(NSInteger)seconds{
    NSString *title = [NSString stringWithFormat:@"%ldS后重新获取",(long)seconds];
    [self.getSecurityCodeButton setTitle:title forState:UIControlStateNormal];
    self.getSecurityCodeButton.enabled = NO;
}
//改变"xxS后重新获取"-->“获取手机验证码”状态
- (void)changeSecurityButtonNormalStatus{
    NSString *normalTitle = @"获取短信验证码";
    [self.getSecurityCodeButton setTitle:normalTitle forState:UIControlStateNormal];
    self.getSecurityCodeButton.enabled = YES;
}
//输入密码1
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
//输入密码2
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
//改变底部button title
- (void)changeSureButtonStatus:(NSUInteger)type{
    if (type == 0) {
        [self.sureButton setTitle:@"注  册" forState:UIControlStateNormal];
    }else if (type == 1){
        [self.sureButton setTitle:@"确  定" forState:UIControlStateNormal];
    }
}
@end
