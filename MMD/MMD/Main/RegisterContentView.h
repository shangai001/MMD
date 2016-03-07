//
//  RegisterContentView.h
//  MMD
//
//  Created by pencho on 16/3/7.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterContentView : UIView

@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *getSecurityCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UIButton *changeSecurityStatus1;
@property (weak, nonatomic) IBOutlet UIButton *changeSecurityStatus2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *securityNButtonHeight;

- (void)changeSecurityButtonWaitingStatus:(NSInteger)seconds;
- (void)changeSecurityButtonNormalStatus;

@end
