//
//  MineCellActionHelper.m
//  MMD
//
//  Created by pencho on 16/4/4.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MineCellActionHelper.h"
#import "MineViewController.h"


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
            }else if (row == 1){
                //持证拍照信息
            }else if (row == 2){
                //银行卡信息
            }
        }
            break;
        case 2:
        {
            if (row == 0) {
                //工作信息
            }else if (row == 1){
                //联系人信息
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
+ (void)jumpToXXXFrom:(MineViewController *)mine{
    
}
@end
