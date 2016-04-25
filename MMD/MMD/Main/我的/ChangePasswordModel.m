//
//  ChangePasswordModel.m
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ChangePasswordModel.h"
#import "AppUserInfoHelper.h"

@implementation ChangePasswordModel

+ (void)changePassword:(NSDictionary *)info
               success:(successHandler)successHandler
               failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/changePassword",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}

@end
