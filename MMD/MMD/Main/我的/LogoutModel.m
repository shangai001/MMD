//
//  LogoutModel.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LogoutModel.h"
#import "AppUserInfoHelper.h"

@implementation LogoutModel

+ (void)logoutUserSuccess:(successHandler)successHandler
                  failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/logout",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}

@end
