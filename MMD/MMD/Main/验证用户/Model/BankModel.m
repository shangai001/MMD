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
    
    NSMutableDictionary *userIdTokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    
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
    
    NSString *bankCard = info[@"bankCard"];
    NSMutableDictionary *userIdTokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    [userIdTokenDic setObject:bankCard forKey:@"bankCard"];
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/checkUserBankBinded",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
