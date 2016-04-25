//
//  EditeContactModel.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "EditeContactModel.h"
#import "AppUserInfoHelper.h"

@implementation EditeContactModel


+ (void)uploadEditeContacts:(NSDictionary *)info
                    success:(successHandler)successHandler
                    failure:(failureHandler)failureHandler{
    
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/addUserContacts",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
@end
