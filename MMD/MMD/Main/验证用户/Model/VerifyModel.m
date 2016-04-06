//
//  VerifyModel.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "VerifyModel.h"
#import "AppUserInfoHelper.h"

@implementation VerifyModel

+ (void)postFirstInformation:(NSDictionary *)info
                     success:(successHandler)successHandler
                     failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/firstSaveUserInfo",kHostURL];
    NSMutableDictionary *userIdTokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    for (NSString *key in [info allKeys]) {
        NSString *object = [info objectForKey:key];
        [userIdTokenDic setObject:object forKey:key];
    }
    
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}

@end
