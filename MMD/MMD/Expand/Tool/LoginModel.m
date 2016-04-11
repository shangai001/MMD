//
//  RegisterModel.m
//  MMD
//
//  Created by pencho on 16/3/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoginModel.h"
#import "HttpRequest.h"

@implementation LoginModel

+ (void)checkUserAuthorized:(NSDictionary *)info
          completionHandler:(void (^)(NSDictionary *))completationBlock
             FailureHandler:(void (^)(NSError *))failureBlock{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/reset",kHostURL];
    [HttpRequest postWithURLString:URL parameters:info success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            completationBlock(responseObject);
            NSLog(@"验证是否通过验证 %@",responseObject);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)forgetPassword:(NSDictionary *)info completionHandler:(void (^)(NSDictionary *))completationBlock FailureHandler:(void (^)(NSError *))failureBlock{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/forgetPasswordCode",kHostURL];
    [HttpRequest postWithURLString:URL parameters:info success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            completationBlock(responseObject);
            NSLog(@"忘记密码responseObject %@",responseObject);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
+ (void)loginUser:(NSDictionary *)info completionHandler:(void (^)(NSDictionary *))completationBlock FailureHandler:(void (^)(NSError *))failureBlock{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/login",kHostURL];
    [HttpRequest postWithURLString:URL parameters:info success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            completationBlock(responseObject);
            NSLog(@"登录响应 %@",responseObject);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
+ (void)resetPassword:(NSDictionary *)info completionHandler:(void (^)(NSDictionary *))completationBlock FailureHandler:(void (^)(NSError *))failureBlock{
    NSString *URL = [NSString stringWithFormat:@"%@/user/reset",kHostURL];
    [HttpRequest postWithURLString:URL parameters:info success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            completationBlock(responseObject);
            NSLog(@"重设密码responseObject %@",responseObject);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

@end
