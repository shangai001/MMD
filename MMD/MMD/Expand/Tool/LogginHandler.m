//
//  LogginHandler.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LogginHandler.h"
#import "MMLogViewController.h"


@implementation LogginHandler


+ (void)shouldLogginAt:(UIViewController *)currentVC{
    
    MMLogViewController *logger = [[MMLogViewController alloc] initWithNibName:NSStringFromClass([MMLogViewController class]) bundle:[NSBundle mainBundle]];
    logger.hidesBottomBarWhenPushed = YES;
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *NAV = (UINavigationController *)currentVC;
        [NAV pushViewController:logger animated:YES];
        return;
    }
    [currentVC.navigationController pushViewController:logger animated:YES];
}
@end
