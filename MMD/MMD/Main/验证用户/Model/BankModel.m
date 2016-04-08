//
//  BankModel.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BankModel.h"
#import "AppUserInfoHelper.h"

@implementation BankModel

+ (void)getBankList:(NSDictionary *)info
       completation:(successHandler)success
            failure:(failureHandler)failure{
    
    NSDictionary *userIdTokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/getBanks",kHostURL];
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
+ (void)checkCreditCard:(NSDictionary *)info
           completation:(successHandler)success
                failure:(failureHandler)failure{
    
    NSDictionary *userIdTokenDic = [AppUserInfoHelper appendUserIdToken:info];
    NSString *URL = [NSString stringWithFormat:@"%@/user/checkUserBankBinded",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
