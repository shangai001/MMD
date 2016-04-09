//
//  QueryModel.m
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "QueryModel.h"
#import "AppUserInfoHelper.h"

@implementation QueryModel

+ (void)queryLoanStatus:(NSDictionary *)info
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/loan/getNewLoanApply",kHostURL];
    NSDictionary *userIdTokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
+ (void)cancleLoanApply:(NSDictionary *)info
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/loan/cancelRegistration",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
@end
