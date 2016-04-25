//
//  ChangePhoneModel.m
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ChangePhoneModel.h"
#import "AppUserInfoHelper.h"

@implementation ChangePhoneModel

+ (void)changePhoneNumber:(NSDictionary *)info
                  success:(successHandler)successHandler
                  failure:(failureHandler)failureHandler{
    
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:info];
    NSString *URL = [NSString stringWithFormat:@"%@/user/changePhone",kHostURL];
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}

@end
