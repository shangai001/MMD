//
//  RegisterModel.h
//  MMD
//
//  Created by pencho on 16/3/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject

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

@end
