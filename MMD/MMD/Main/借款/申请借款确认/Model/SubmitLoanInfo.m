//
//  SubmitLoanInfo.m
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "SubmitLoanInfo.h"
#import "AppUserInfoHelper.h"

@implementation SubmitLoanInfo


//capital,capital
+ (void)submitLoanInfo:(NSDictionary *)info
               success:(successHandler)successHandler
               failure:(failureHandler)failureHandler{
    
    NSDictionary *userDic = [AppUserInfoHelper appendUserIdToken:info];
    NSString *URL = [NSString stringWithFormat:@"%@/loan/applyLoan",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:userDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
@end
