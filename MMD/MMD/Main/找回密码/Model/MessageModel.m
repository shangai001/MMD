//
//  MessageModel.m
//  MMD
//
//  Created by pencho on 16/4/5.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+ (void)getSecurityMessageToken:(NSDictionary *)info
                     completion:(successHandler)completionHandler
                        failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/basic/getSmsToken",kHostURL];
    [HttpRequest postWithURLString:URL parameters:info success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            completionHandler(responseObject);
        }
    } failure:^(NSError *error) {
        failureHandler(error);
    }];

}
+ (void)getSecurityMessageCode:(NSDictionary *)info
                    completion:(successHandler)completionHandler
                       failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/registCode",kHostURL];
    [HttpRequest postWithURLString:URL parameters:info success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"获取验证码responseObject %@",responseObject);
            completionHandler(responseObject);
        }
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
+ (void)registerUser:(NSDictionary *)info
        completation:(successHandler)successHandler
             failure:(failureHandler)failureHandler{
    NSString *URL = [NSString stringWithFormat:@"%@/user/regist",kHostURL];
    [HttpRequest postWithURLString:URL parameters:info success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"新注册responseObject %@",responseObject);
            successHandler(responseObject);
        }
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
@end
