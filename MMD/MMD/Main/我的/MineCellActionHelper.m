//
//  MineCellActionHelper.m
//  MMD
//
//  Created by pencho on 16/4/4.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MineCellActionHelper.h"
#import "MineViewController.h"
#import "HandleUserStatus.h"
#import "LogginHandler.h"
#import "MMDLoggin.h"
#import "IDInfoController.h"
#import "IDPhotoController.h"
#import "BankInfoController.h"
#import "JobViewController.h"
#import "ContactTableViewController.h"



@implementation MineCellActionHelper

+ (void)jumpFromViewController:(MineViewController *)originalController
                       atIndex:(NSIndexPath *)indexPath{
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    switch (section) {
        case 1:
        {
            if (row == 0) {
                //身份证信息
                IDInfoController *idVC = [[IDInfoController alloc] initWithNibName:NSStringFromClass([IDInfoController class]) bundle:[NSBundle mainBundle]];
                [self jumpToController:idVC from:originalController];
                
            }else if (row == 1){
                //持证拍照信息
                IDPhotoController *idPhotoVc = [[IDPhotoController alloc] initWithNibName:NSStringFromClass([IDPhotoController class]) bundle:[NSBundle mainBundle]];
                [self jumpToController:idPhotoVc from:originalController];
            }else if (row == 2){
                //银行卡信息
                BankInfoController *bankInfoVc = [[BankInfoController alloc] initWithNibName:NSStringFromClass([BankInfoController class]) bundle:[NSBundle mainBundle]];
                [self jumpToController:bankInfoVc from:originalController];
            }
        }
            break;
        case 2:
        {
            if (row == 0) {
                //工作信息
                JobViewController *jobVc = [[JobViewController alloc] initWithNibName:NSStringFromClass([JobViewController class]) bundle:[NSBundle mainBundle]];
                [self jumpToController:jobVc from:originalController];
            }else if (row == 1){
                //联系人信息
                ContactTableViewController *contactVC = [[ContactTableViewController alloc] initWithStyle:UITableViewStylePlain];
                [self jumpToController:contactVC from:originalController];
                
            }else if (row == 2){
                //补充附件
            }
        }
            break;
        case 3:
        {
            if (row == 0) {
                //更改密码
            }else if (row == 1){
                //手机号码
            }
        }
            break;
        case 4:
        {
            if (row == 0) {
                //历史申请记录
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark JumptoTarget
+ (void)jumpToController:(UIViewController *)targetController from:(MineViewController *)mine{
    
    //先检查用户是否登录
    if ([MMDLoggin isLoggin]) {
        if ([HandleUserStatus handleUserStatusAt:mine]) {
            targetController.hidesBottomBarWhenPushed = YES;
            //前往对应页面
            [mine.navigationController pushViewController:targetController animated:YES];
        }
    }else{
        //去登录界面
        [LogginHandler shouldLogginAt:mine];
    }
}
@end
