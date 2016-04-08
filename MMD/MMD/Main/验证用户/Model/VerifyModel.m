//
//  VerifyModel.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "VerifyModel.h"
#import "AppUserInfoHelper.h"
#import "CategoryNameHeader.h"




@implementation VerifyModel

+ (void)postFirstInformation:(NSDictionary *)info
                     success:(successHandler)successHandler
                     failure:(failureHandler)failureHandler{
    
    NSDictionary *userIdTokenDic = [AppUserInfoHelper appendUserIdToken:info];
    NSString *URL = [NSString stringWithFormat:@"%@/user/firstSaveUserInfoSecond",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}

+ (void)postSecondInformation:(NSDictionary *)info
                     success:(successHandler)successHandler
                      failure:(failureHandler)failureHandler{
    
    NSDictionary *userIdTokenDic = [AppUserInfoHelper appendUserIdToken:info];
    NSString *URL = [NSString stringWithFormat:@"%@/user/secondSaveUserInfo",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
+ (void)getPicerData:(NSInteger)categoryId
             success:(successHandler)successHandler
             failure:(failureHandler)failureHandler{
    
    NSMutableDictionary *userIdTokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    //婚姻
    if (categoryId == 0) {
        [userIdTokenDic setObject:Marriage forKey:categorykey];
    }else if (categoryId == 1){
        [userIdTokenDic setObject:Children forKey:categorykey];
    }else if (categoryId == 2){
        [userIdTokenDic setObject:LbsRange forKey:categorykey];
    }else if (categoryId == 3){
        [userIdTokenDic setObject:WorkJob forKey:categorykey];
    }
    NSString *URL = [NSString stringWithFormat:@"%@/user/getByCategory",kHostURL];
    [HttpRequest postWithURLString:URL parameters:userIdTokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
@end
