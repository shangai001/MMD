//
//  LoginStauff.h
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXSDK.h"

@interface DistributeStauff : NSObject


/**
 *  登录之后绑定到ZXSDK
 *
 *  @param userId      用户id
 *  @param phoneNumber 用户电话号码
 *  @param callBack
 */
+ (void)shouldBlindUser:(NSString *)userId mobileId:(NSString *)phoneNumber;

+(void)idcardVerificationForUid:(NSString *)uid withCallback:(ZXCallback)callback;
+(void)getMemberDetailByMobileNo:(NSString *)mobileno withCallback:(ZXCallback)callback;
+(void)getMemberDetailByIDCard:(NSString *)idcard withCallback:(ZXCallback)callback;
/**
 *  下载成功返回的3张图片
 *
 *  @param detail 
 */
+ (void)downloadImagesWith:(ZXMemberDetail *)detail;
//+ (void)downloadImagesWith:(ZXMemberDetail *)detail;

@end
