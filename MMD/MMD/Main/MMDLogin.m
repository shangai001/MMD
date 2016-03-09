//
//  RegisterModel.m
//  MMD
//
//  Created by pencho on 16/3/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMDLogin.h"

@implementation MMDLogin

+ (void)getSecurityCode:(NSDictionary *)info
      completionHandler:(void(^)(NSDictionary *resultDictionary))completationBlock
         FailureHandler:(void(^)(NSError *error))failureBlock{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/registCode",kHostURL];
    [HYBNetworking getWithUrl:URL params:info success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            completationBlock(response);
        }
    } fail:^(NSError *error) {
        failureBlock(error);
    }];
    
}
+ (void)registerUserCount:(NSDictionary *)info completionHandler:(void (^)(NSDictionary *))completationBlock FailureHandler:(void (^)(NSError *))failureBlock{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/regist",kHostURL];
    [HYBNetworking getWithUrl:URL params:info success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            completationBlock(response);
        }
    } fail:^(NSError *error) {
        failureBlock(error);
    }];
}
+ (void)forgetPassword:(NSDictionary *)info completionHandler:(void (^)(NSDictionary *))completationBlock FailureHandler:(void (^)(NSError *))failureBlock{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/forgetPasswordCode",kHostURL];
    [HYBNetworking getWithUrl:URL params:info success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            completationBlock(response);
        }
    } fail:^(NSError *error) {
        failureBlock(error);
    }];
}
+ (void)loginUser:(NSDictionary *)info completionHandler:(void (^)(NSDictionary *))completationBlock FailureHandler:(void (^)(NSError *))failureBlock{
    NSString *URL = [NSString stringWithFormat:@"%@/user/login",kHostURL];
    [HYBNetworking getWithUrl:URL params:info success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            completationBlock(response);
        }
    } fail:^(NSError *error) {
        failureBlock(error);
    }];
}
@end
