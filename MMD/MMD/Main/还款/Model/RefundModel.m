//
//  RefundModel.m
//  MMD
//
//  Created by pencho on 16/4/18.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RefundModel.h"
#import "HttpRequest.h"
#import "AppUserInfoHelper.h"


@implementation RefundModel

+ (void)queryWillRefundInfo:(NSDictionary *)info
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler{
    
    NSMutableDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    [tokenDic setObject:@(0) forKey:@"state"];
    NSString *URL = [NSString stringWithFormat:@"%@/repay/list",kHostURL];
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
+ (void)queryDidRefundInfo:(NSDictionary *)info
                    success:(successHandler)successHandler
                    failure:(failureHandler)failureHandler{
    
    NSMutableDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    [tokenDic setObject:@(1) forKey:@"state"];
    NSString *URL = [NSString stringWithFormat:@"%@/repay/list",kHostURL];
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
@end
