//
//  AppUserInfoHelper.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "AppUserInfoHelper.h"
#import "AppDelegate.h"



//#define PASSWORD_KEY @"LastPasswordKey"
//#define PASSWORD_VALUE @"LastPasswordValue"

@implementation AppUserInfoHelper

+ (NSString *)getDocumentPath {
    
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documents[0];
    return documentPath;
}
+ (void)updateUserInfo:( NSDictionary * _Nullable )info{
    
    NSDictionary *dataDic = info[@"data"];
    [self saveIno:dataDic path:[self getDocumentPath]];
}
+ (void)saveIno:(NSDictionary *)info path:(NSString *)filePath{
    
    NSString *fullPath = [filePath stringByAppendingPathComponent:@"UserInfo.data"];
    BOOL success = [NSKeyedArchiver archiveRootObject:info toFile:fullPath];
    if (success) {
        //        标记当前登录成功
        if (![SDUserDefault boolForKey:Loggin]) {
            [SDUserDefault setBool:YES forKey:Loggin];
        }
    }
    NSAssert(success, @"归档用户信息失败");
}
+ (NSDictionary *)userData{
    
    return [self unarchiveUserInfo];
}
+ (NSDictionary *)getChildUserInfo:(NSString *)childKey{
    
    NSDictionary *userData = [self userData];
    if ([userData[childKey] isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return userData[childKey];
}
+ (NSDictionary *)unarchiveUserInfo{
    
    NSString *filePath = [self getDocumentPath];
    
    NSString *fullPath = [filePath stringByAppendingPathComponent:@"UserInfo.data"];
    
    NSDictionary *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
    
    return userInfo;
}
+ (NSDictionary *)user{
    
    NSDictionary *fullDic = [self unarchiveUserInfo];
    
    if ([fullDic[@"user"] isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return fullDic[@"user"];
}
+ (NSDictionary *)userBank{
    
    NSDictionary *fullDic = [self unarchiveUserInfo];
    if ([fullDic[@"userBank"] isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return fullDic[@"userBank"];
}
+ (NSDictionary *)userInfo{
    
    NSDictionary *fullDic = [self unarchiveUserInfo];
    if ([fullDic[@"userInfo"] isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return fullDic[@"userInfo"];
}
+ (NSDictionary *)userJob{
    
    NSDictionary *fullDic = [self unarchiveUserInfo];
    if ([fullDic[@"userJob"] isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return fullDic[@"userJob"];
}
+ (NSDictionary *)creditRating{
    
    NSDictionary *fullDic = [self unarchiveUserInfo];
    if ([fullDic[@"creditRating"] isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return fullDic[@"creditRating"];
}
+ (NSMutableDictionary *)tokenAndUserIdDictionary{
    
    NSString *userId = [self userInfo][@"userId"];
    NSString *token = [self user][@"token"];
    if (userId && token) {
        NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"userId":userId,@"token":token}];
        return infoDic;
    }
    return nil;
}
+ (NSInteger)UserStatus{
    
    NSDictionary *user = [self user];
    
    NSInteger statusInterger = [[user objectForKey:AuditState] integerValue];
    
    return statusInterger;
}
+ (NSDictionary *)appendUserIdToken:(nullable NSDictionary *)info{
    
    NSMutableDictionary *userIdTokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    if (info == nil) return userIdTokenDic;
    
    for (NSString *key in [info allKeys]) {
        id object = info[key];
        if (![object isKindOfClass:[NSNull class]] && userIdTokenDic) {
            [userIdTokenDic setObject:object forKey:key];
        }
    }
    return userIdTokenDic;
}
/*
+ (NSDictionary *)accountDic{
    
    NSString *userId = [SDUserDefault objectForKey:PASSWORD_KEY];
    NSString *password = [SDUserDefault objectForKey:PASSWORD_VALUE];
    
    NSDictionary *userIdPasswordDic = @{@"userId":userId,@"password":password};
    return userIdPasswordDic;
}
*/

@end
