//
//  HandleUserStatus.m
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "HandleUserStatus.h"
#import "AppUserInfoHelper.h"
#import "VerifyViewController.h"


@implementation HandleUserStatus


+ (BOOL)handleUserStatusAt:(UIViewController *)viewController{
    
    NSInteger status = [AppUserInfoHelper UserStatus];
    if (status && status >= 0 && status < 3) {
        //跳转到父Controller
        VerifyViewController *verifyer = [[VerifyViewController alloc] initWithNibName:NSStringFromClass([VerifyViewController class]) bundle:[NSBundle mainBundle]];
        verifyer.status = status;
        verifyer.hidesBottomBarWhenPushed = YES;
        [viewController.navigationController pushViewController:verifyer animated:YES];
        return NO;
    }else{
        return YES;
    }
    return NO;
}

@end
