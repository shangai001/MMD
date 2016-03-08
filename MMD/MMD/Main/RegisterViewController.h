//
//  RegisterViewController.h
//  MMD
//
//  Created by pencho on 16/2/29.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterItem;
@class RegisterContentView;

typedef NS_ENUM(NSUInteger,kUserType) {
    
    kRegisterType = 0,
    kForgetPassword = 1
};
@interface RegisterViewController : UIViewController
/**
 *  标识当前是{1.注册用户 2.找回密码}
 */
@property (assign, nonatomic)kUserType type;
@property (strong, nonatomic)RegisterContentView *contentView;
@property (strong, nonatomic)RegisterItem *registerItem;

@end
