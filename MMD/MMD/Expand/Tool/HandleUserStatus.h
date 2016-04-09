//
//  HandleUserStatus.h
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HandleUserStatus : NSObject

/*
 MMLogViewController *logger = [[MMLogViewController alloc] initWithNibName:NSStringFromClass([MMLogViewController class]) bundle:[NSBundle mainBundle]];
 logger.hidesBottomBarWhenPushed = YES;
 [more.navigationController pushViewController:logger animated:YES];
 */
/**
 *  必须在登录条件下检查用户审核身份审核状态,若完善资料或者未通过审核，则直接Push到完善资料页面
 *
 *  @param viewController
 *
 *  @return
 */
+ (BOOL)handleUserStatusAt:(UIViewController *)viewController;

@end
