//
//  JobModel.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "JobModel.h"
#import "AppUserInfoHelper.h"

@implementation JobModel

+ (void)updateJobInfo:(NSDictionary *)info
              success:(successHandler)successHandler
              failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/changeUserJob",kHostURL];
    
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}


@end
