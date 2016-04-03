//
//  WarnLoginModel.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "WarnLoginModel.h"

@implementation WarnLoginModel

+ (void)postWarnningMessageToPhone:(NSDictionary *)phoneInfo success:(successHandler)successHandler failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/unusualLogin",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:phoneInfo success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            successHandler(responseObject);
        }
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}

@end
