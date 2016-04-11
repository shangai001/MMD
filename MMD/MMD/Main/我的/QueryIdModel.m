//
//  QueryIdModel.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "QueryIdModel.h"
#import "AppUserInfoHelper.h"

@implementation QueryIdModel

#pragma mark QueryInfo
+ (void)queryCreditRatingSuccess:(successHandler)successHandler
               failure:(failureHandler)failureHandler{
    NSString *URL = [NSString stringWithFormat:@"%@/user/creditRating",kHostURL];
    NSDictionary *userInfo = [AppUserInfoHelper tokenAndUserIdDictionary];
    [HttpRequest postWithURLString:URL parameters:userInfo success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
+ (void)queryUserCheckSuccess:(successHandler)successHandler
                         failure:(failureHandler)failureHandler{
    NSString *URL = [NSString stringWithFormat:@"%@/user/userCheck",kHostURL];
    NSDictionary *userInfo = [AppUserInfoHelper tokenAndUserIdDictionary];
    [HttpRequest postWithURLString:URL parameters:userInfo success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
+ (void)queryContactsSuccess:(successHandler)successHandler
                         failure:(failureHandler)failureHandler{
    NSString *URL = [NSString stringWithFormat:@"%@/user/userContacts",kHostURL];
    NSDictionary *userInfo = [AppUserInfoHelper tokenAndUserIdDictionary];
    [HttpRequest postWithURLString:URL parameters:userInfo success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
+ (void)queryAttachmentsSuccess:(successHandler)successHandler
                     failure:(failureHandler)failureHandler{
    NSString *URL = [NSString stringWithFormat:@"%@/user/userAttachments",kHostURL];
    NSDictionary *userInfo = [AppUserInfoHelper tokenAndUserIdDictionary];
    [HttpRequest postWithURLString:URL parameters:userInfo success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
//修改密码
//修改手机号获取验证码
//修改手机号接口
//修改银行卡
//修改工作信息接口
//增加修改联系人接口
//查询单个用户附件解耦
//新增或者修改用户信息接口
//修改持证拍照信息
//查询持证拍照信息
//查询银行卡是否开通快捷支付


@end
