//
//  LogginSuccessActionHelper.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LogginSuccessActionHelper.h"
#import "MMLogViewController.h"

@implementation LogginSuccessActionHelper

+ (void)jumpFromViewController:(MMLogViewController *)logger userStatus:(NSInteger)status{
    
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
    
    /*
     //如果是第一次登录，验证身份证号码
     VerifyViewController *verifyer = [[VerifyViewController alloc] initWithNibName:NSStringFromClass([VerifyViewController class]) bundle:[NSBundle mainBundle]];
     [self.navigationController pushViewController:verifyer animated:YES];
     */

    
}
@end
