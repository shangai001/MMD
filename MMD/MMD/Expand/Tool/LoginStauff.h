//
//  LoginStauff.h
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXSDK.h"

@interface LoginStauff : NSObject


/**
 *  登录之后绑定到ZXSDK
 *
 *  @param userId      用户id
 *  @param phoneNumber 用户电话号码
 *  @param callBack
 */
+ (void)shouldBlindUser:(NSString *)userId mobileId:(NSString *)phoneNumber with:(ZXCallback)callBack;

@end
