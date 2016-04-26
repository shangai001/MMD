//
//  MineModel.m
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MineModel.h"
#import "AppUserInfoHelper.h"

@implementation MineModel

+ (void)queryAllNotifications:(NSDictionary *)info
                      success:(successHandler)successHandler
                      failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/message/noReadTotal",kHostURL];
    
    NSDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
+ (void)queryNotificationCenter:(NSDictionary *)info
                        success:(successHandler)successHandler
                        failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/message/noReadSysMsgSize",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
+ (void)queryServiceUnReadCount:(NSDictionary *)info
                        success:(successHandler)successHandler
                        failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/message/getMessageState",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
+ (void)queryUserMessage:(NSDictionary *)info
              pageNumber:(NSInteger)numer
                 success:(successHandler)successHandler
                 failure:(failureHandler)failureHandler{
    
    CGFloat const size = 10;
    NSMutableDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    [tokenDic setObject:@(size) forKey:@"size"];
    [tokenDic setObject:@(numer) forKey:@"pageNo"];
    
    NSString *URL = [NSString stringWithFormat:@"%@/message/sysMessage",kHostURL];
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
@end
