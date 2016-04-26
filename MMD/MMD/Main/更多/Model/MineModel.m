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

@end
