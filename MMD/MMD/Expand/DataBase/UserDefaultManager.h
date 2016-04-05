//
//  RecordPassword.h
//  MMD
//
//  Created by pencho on 16/4/5.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultManager : NSObject
/**
 *  登录成功后记录用户名和密码
 *
 *  @param key_Phone      用户手机号码
 *  @param value_Password 用户密码
 */
+ (void)ez_RecordUser:(NSString *)key_Phone password:(NSString *)value_Password;
/**
 *  重置除了用户密码外的所有值
 */
+ (void)ez_ResetStandardUserDefaults;
/**
 *  找出记录下来的手机号phoneNumber的密码
 *
 *  @param phoneNumber 输入的手机号
 *
 *  @return 记录的密码
 */
+ (NSString *)ez_FindPasswordForPhone:(NSString *)phoneNumber;


@end
