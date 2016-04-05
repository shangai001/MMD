//
//  MessageModel.h
//  MMD
//
//  Created by pencho on 16/4/5.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

/**
*  获取手机短信验证码token
*
*  @param info              nil
*  @param completionHandler
*  @param failureHandler
*/
+ (void)getSecurityMessageToken:(NSDictionary *)info
                     completion:(successHandler)completionHandler
                        failure:(failureHandler)failureHandler;
/**
 *  获取手机验证码
 *
 *  @param info              手机号/token
 *  @param completionHandler
 *  @param failureHandler    
 */
+ (void)getSecurityMessageCode:(NSDictionary *)info
                     completion:(successHandler)completionHandler
                       failure:(failureHandler)failureHandler;

/**
 *  注册用户
 *
 *  @param info           手机号/验证码/密码
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)registerUser:(NSDictionary *)info
        completation:(successHandler)successHandler
             failure:(failureHandler)failureHandler;

@end
