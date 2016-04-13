//
//  LogginHandler.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LogginHandler.h"
#import "MMLogViewController.h"
#import "AppUserInfoHelper.h"



@implementation LogginHandler


+ (void)shouldLogginAt:(UIViewController *)currentVC{
    
    MMLogViewController *logger = [[MMLogViewController alloc] initWithNibName:NSStringFromClass([MMLogViewController class]) bundle:[NSBundle mainBundle]];
    logger.hidesBottomBarWhenPushed = YES;
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *NAV = (UINavigationController *)currentVC;
        [NAV pushViewController:logger animated:YES];
        return;
    }
    [currentVC.navigationController pushViewController:logger animated:YES];
}
+ (void)shouldUploadDeviceInfo:(NSDictionary *)info
                       success:(successHandler)successHandler
                       failure:(failureHandler)failureHandler{
    
    NSString *deviceURL = [NSString stringWithFormat:@"%@/user/uploadDeviceInfo",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    [HttpRequest postWithURLString:deviceURL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
+ (void)blindDeviceInfo:(NSDictionary *)info
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/bindChannelId",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}
+ (void)shouldUploadContacts:(id)info
                     success:(successHandler)successHandler
                     failure:(failureHandler)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/uploadUserPhoneContacts",kHostURL];
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:info];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
@end
