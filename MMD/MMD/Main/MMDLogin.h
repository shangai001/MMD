//
//  RegisterModel.h
//  MMD
//
//  Created by pencho on 16/3/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMDLogin : NSObject

/**
 *  获取手机验证码
 *
 *  @param info              传入参数(手机号)
 *  @param completationBlock 完成回调
 *  @param failureBlock      失败回调
 */
+ (void)getSecurityCode:(NSDictionary *)info
      completionHandler:(void(^)(NSDictionary *resultDictionary))completationBlock
         FailureHandler:(void(^)(NSError *error))failureBlock;
/**
 *  注册用户账号
 *
 *  @param info              传入参数
 *  @param completationBlock 完成回调
 *  @param failureBlock      失败回调
 */
+ (void)registerUserCount:(NSDictionary *)info
        completionHandler:(void(^)(NSDictionary *resultDictionary))completationBlock
           FailureHandler:(void(^)(NSError *error))failureBlock;

/**
 *  忘记密码，获取验证码重新设置密码
 *
 *  @param info              传入手机号
 *  @param completationBlock 完成回调
 *  @param failureBlock      失败回调
 */
+ (void)forgetPassword:(NSDictionary *)info
     completionHandler:(void(^)(NSDictionary *resultDictionary))completationBlock
        FailureHandler:(void(^)(NSError *error))failureBlock;

/**
 *  登录
 *
 *  @param info              传入手机号(18632156680)
 *  @param completationBlock 完成回调
 *  @param failureBlock      失败回调
 */
+ (void)loginUser:(NSDictionary *)info
completionHandler:(void(^)(NSDictionary *resultDictionary))completationBlock
   FailureHandler:(void(^)(NSError *error))failureBlock;

@end
