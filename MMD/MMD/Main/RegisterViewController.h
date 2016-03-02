//
//  RegisterViewController.h
//  MMD
//
//  Created by pencho on 16/2/29.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterItem;

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

@property (weak, nonatomic) IBOutlet UIButton *getSecurityCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *securityCode;
@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
@property (weak, nonatomic) IBOutlet UIButton *changeSecurityStatus1;
@property (weak, nonatomic) IBOutlet UIButton *changeSecurityStatus2;

@property (strong, nonatomic)RegisterItem *registerItem;

@end
