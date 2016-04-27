//
//  QueryMessageModel.m
//  MMD
//
//  Created by pencho on 16/4/27.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "QueryMessageModel.h"
#import "AppUserInfoHelper.h"

@implementation QueryMessageModel



+ (void)getMessageList:(NSDictionary *)info
               success:(successHandler)successHandler
               failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/message/getMessages",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
+ (void)sendMessage:(NSDictionary *)info
            success:(successHandler)successHandler
            failure:(failureHandler)failureHandler{
    
    NSMutableDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    NSString *content = info[@"content"];
    [tokenDic setObject:content forKey:@"content"];
    
    NSString *URL = [NSString stringWithFormat:@"%@/message/send",kHostURL];
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
@end
