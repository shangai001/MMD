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

+ (void)updateUserInfo:(NSDictionary *)info{
    
    AppDelegate *app_delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app_delegate.userInfo == nil) {
        app_delegate.userInfo = [[MMDUserInfo alloc] init];
    }
    [app_delegate.userInfo updateUserInfo:info];
    
}
+ (MMDUserInfo *)getCurrentUserInfo{
    
    AppDelegate *app_delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([app_delegate.userInfo isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return app_delegate.userInfo;
    
}
+ (NSDictionary *)user{
    
    MMDUserInfo *item = [self getCurrentUserInfo];
    if ([item.user isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return item.user;
}
+ (NSDictionary *)userBank{
    
    MMDUserInfo *item = [self getCurrentUserInfo];
    if ([item.userBank isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return item.userBank;
}
+ (NSDictionary *)userInfo{
    
    MMDUserInfo *item = [self getCurrentUserInfo];
    if ([item.userInfo isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return item.userInfo;
}
+ (NSDictionary *)userJob{
    
    MMDUserInfo *item = [self getCurrentUserInfo];
    if ([item.userJob isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return item.userJob;
}
+ (NSDictionary *)creditRating{
    
    MMDUserInfo *item = [self getCurrentUserInfo];
    if ([item.creditRating isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return item.creditRating;
}
@end
