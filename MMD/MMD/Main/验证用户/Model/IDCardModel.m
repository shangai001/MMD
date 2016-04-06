//
//  IDCardModel.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "IDCardModel.h"
#import "AppUserInfoHelper.h"

@implementation IDCardModel

+ (void)checkoutIDCard:(NSDictionary *)info
          completation:(successHandler)success
               failure:(failureHandler)failure{
    
    NSString *idcard = info[@"idcard"];
    NSMutableDictionary *userIdTokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    [userIdTokenDic setObject:idcard forKey:@"idcard"];
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/checkIdCardRepeat",kHostURL];
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
