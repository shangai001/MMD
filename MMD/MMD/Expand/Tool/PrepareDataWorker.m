//
//  PrepareDataWorker.m
//  MMD
//
//  Created by pencho on 16/4/14.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "PrepareDataWorker.h"
#import "ConstantKeySecret.h"
#import "ZXSDK.h"
#import "LogginHandler.h"
#import "MMDLoggin.h"


@implementation PrepareDataWorker

#pragma mark ConfigureZXSDK
+ (void)configureZXSDK{
    
    [ZXSDK configWithAppId:ZX_APIKEY withAppSecret:ZX_APISECRET];
}
+ (void)reLoginIfHasUserIdPassword{
    
    NSDictionary *userIdPassword = [MMDLoggin accountDic];
    if (userIdPassword) {
        [LogginHandler shouldUpdateUserInfo:nil success:^(NSDictionary *resultDic) {
            if ([resultDic[@"code"] integerValue] == 1) {
                EZLog(@"启动时候重新登录成功");
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        NSLog(@"没有记住用户名字和密码!");
    }
}
@end
