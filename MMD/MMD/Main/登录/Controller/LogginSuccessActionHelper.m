//
//  LogginSuccessActionHelper.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LogginSuccessActionHelper.h"
#import "MMLogViewController.h"
#import "VerifyViewController.h"
#import "FirstStepController.h"
#import "SecondStaepController.h"
#import "ThirdStepController.h"

/*
 if (status == 0) {
 //刚刚注册
 
 }else if (status == 1){
 //完善第一步信息
 
 }else if (status == 2){
 //完善第二步信息
 
 }else if (status == 3){
 //完善第三部信息
 
 }else if (status == 4){
 //通过审核
 
 }

 */
@implementation LogginSuccessActionHelper

+ (void)jumpFromViewController:(MMLogViewController *)logger userStatus:(NSInteger)status{
    
    if (status < 3 && status >= 0) {
        //跳转到父Controller
        VerifyViewController *verifyer = [[VerifyViewController alloc] initWithNibName:NSStringFromClass([VerifyViewController class]) bundle:[NSBundle mainBundle]];
        
        verifyer.status = status;
        verifyer.hidesBottomBarWhenPushed = YES;
        [logger.navigationController pushViewController:verifyer animated:YES];
//        if (logger.presentationController) {
//            [logger.navigationController dismissViewControllerAnimated:YES completion:nil];
//        }
    }else{
        //已经完善信息，返回登录前的页面
        [logger.navigationController popViewControllerAnimated:YES];
    }
 }
@end
