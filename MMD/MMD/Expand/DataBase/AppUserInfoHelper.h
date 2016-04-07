//
//  AppUserInfoHelper.h
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MMDUserInfo;

@interface AppUserInfoHelper : NSObject


+ (void)updateUserInfo:(NSDictionary *)info;

+ (NSDictionary *)userInfo;

+ (NSDictionary *)userBank;

+ (NSDictionary *)userJob;

+ (NSDictionary *)user;

+ (NSDictionary *)creditRating;

+ (NSMutableDictionary *)tokenAndUserIdDictionary;

/**
 *  查询当前登录用户status
 *
 *  @return 
 */
+ (NSInteger)UserStatus;

@end
