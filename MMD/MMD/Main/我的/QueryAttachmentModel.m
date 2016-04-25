//
//  QueryAttachmentModel.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "QueryAttachmentModel.h"
#import "AppUserInfoHelper.h"

@implementation QueryAttachmentModel

+ (void)queryAttachment:(NSDictionary *)info
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/userAttachments",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}

@end
