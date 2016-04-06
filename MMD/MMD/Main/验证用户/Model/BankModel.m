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
    
    
    NSString *token = [AppUserInfoHelper user][@"token"];
    NSDictionary *tempUserInfo = [AppUserInfoHelper userInfo];
    
    NSString *userId = tempUserInfo[@"userId"];
    NSDictionary *tokenDic = @{@"token":token,@"userId":userId};
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/getBanks",kHostURL];
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
