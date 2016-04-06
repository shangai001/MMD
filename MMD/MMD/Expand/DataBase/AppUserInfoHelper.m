//
//  AppUserInfoHelper.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "AppUserInfoHelper.h"
#import "AppDelegate.h"


@implementation AppUserInfoHelper

+ (NSString *)getDocumentPath {
    
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documents[0];
    return documentPath;
}
+ (void)updateUserInfo:(NSDictionary *)info{
    
    NSDictionary *dataDic = info[@"data"];
    
    AppDelegate *app_delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (app_delegate.userInfo == nil) {
        app_delegate.userInfo = [[MMDUserInfo alloc] init];
    }
    
    [app_delegate.userInfo updateUserInfo:dataDic];
    
    [self saveIno:dataDic path:[self getDocumentPath]];
}
+ (void)saveIno:(NSDictionary *)info path:(NSString *)filePath{
    
    NSString *fullPath = [filePath stringByAppendingPathComponent:@"UserInfo.data"];
    BOOL success = [NSKeyedArchiver archiveRootObject:info toFile:fullPath];
    NSAssert(success, @"归档用户信息失败");
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
@end
