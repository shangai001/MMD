//
//  IDCardModel.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "IDCardModel.h"
#import "AppUserInfoHelper.h"

@implementation IDCard_Model

+ (void)checkoutIDCard:(NSDictionary *)info
          completation:(successHandler)success
               failure:(failureHandler)failure{
    
    NSDictionary *userIdTokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/checkIdCardRepeat",kHostURL];
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
