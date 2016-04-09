//
//  HandleUserStatus.m
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "HandleUserStatus.h"
#import "AppUserInfoHelper.h"
#import "MMDLoggin.h"
#import "VerifyViewController.h"
#import "MMLogViewController.h"


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
    //        //去往登录页面
    //        if (![viewController isKindOfClass:[UITabBarController class]]) {
    //
    //            MMLogViewController *logger = [[MMLogViewController alloc] initWithNibName:NSStringFromClass([MMLogViewController class]) bundle:[NSBundle mainBundle]];
    //            logger.hidesBottomBarWhenPushed = YES;
    //            [viewController.navigationController pushViewController:logger animated:YES];
    //        }else{
    //            NSLog(@"处于tabbarviewcontroller中特殊处理");
    //        }
    return NO;
}

@end
