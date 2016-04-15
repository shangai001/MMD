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
#import "LoginModel.h"
#import "MMDLoggin.h"
#import "AppInfo.h"
#import "ZCAddressBook.h"
#import <NSObject+YYModel.h>


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
    
    NSMutableDictionary *devviceDic = [NSMutableDictionary dictionaryWithDictionary:tokenDic];;
    NSString *model = [AppInfo machineModelName];
    NSString *brand = [AppInfo machineModel];
    NSString *imei = [AppInfo UUIDString];
    NSString *imsi = [AppInfo UUIDString];
    if (![brand isKindOfClass:[NSNull class]]) {
        [devviceDic setObject:brand forKey:@"brand"];
    }
    if (![model isKindOfClass:[NSNull class]]) {
        [devviceDic setObject:model forKey:@"model"];
    }
    if (![imei isKindOfClass:[NSNull class]]) {
        [devviceDic setObject:imei forKey:@"imei"];
        [devviceDic setObject:imsi forKey:@"imsi"];
    }
    
    [HttpRequest postWithURLString:deviceURL parameters:devviceDic success:^(id responseObject) {
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

+ (NSMutableArray *)uploadContacts{
    
    ZCAddressBook *book = [ZCAddressBook shareControl];
    NSMutableDictionary *contacts = [book getPersonInfo];

    
    NSMutableArray *uploadArray = [NSMutableArray array];
    for (NSString *key in [contacts allKeys]) {
        NSLog(@"key = %@",key);
        NSArray *keyArray = contacts[key];
        for (NSInteger j = 0; j < keyArray.count; j ++) {
            NSDictionary *person = keyArray[j];
            //创建临时字典
            NSMutableDictionary *makePersonDic = [NSMutableDictionary dictionary];
            //姓名
            NSString *firstName = person[@"first"];
            NSString *lastName = person[@"last"];
            NSString *desplayName = [firstName stringByAppendingString:lastName];
            if (desplayName) {
                [makePersonDic setObject:desplayName forKey:@"desplayName"];
            }
            //电话号码
            NSString *phoneNum = [person[@"telphone"] lastObject];
            if (phoneNum) {
                [makePersonDic setObject:phoneNum forKey:@"phoneNum"];
            }
            //联系人 id
            NSString *contactId = [NSString stringWithFormat:@"%@%ld",key,(long)j];
            [makePersonDic setObject:contactId forKey:@"contactId"];
            //上一次联系时间
            NSDate * today = [NSDate date];
            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate:today];
            NSDate *localeDate = [today dateByAddingTimeInterval:interval];
            NSLog(@"%@", localeDate);
            // 时间转换成时间戳
            NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
            NSLog(@"timeSp : %@", timeSp);
            NSString *lastTimeContacted = timeSp;
            if (lastTimeContacted) {
                [makePersonDic setObject:lastTimeContacted forKey:@"lastTimeContacted"];
            }
            //联系次数
            NSString *timesContacted = @"0";
            [makePersonDic setObject:timesContacted forKey:@"timesContacted"];
            [uploadArray addObject:makePersonDic];
        }
    }
    return uploadArray;
}
//组装 JSON String
+ (NSMutableDictionary *)uploadDic{
    
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:nil];
    NSMutableDictionary *uploadDic = [NSMutableDictionary dictionaryWithDictionary:tokenDic];
    //获取联系人数组
    NSMutableArray *dataArray = [self uploadContacts];
    NSString *yyJsonString = [dataArray modelToJSONString];
    NSString *imei = [AppInfo UUIDString];
    NSString *imsi = [AppInfo UUIDString];
    [uploadDic setObject:imei forKey:@"imei"];
    [uploadDic setObject:imsi forKey:@"imsi"];
    [uploadDic setObject:yyJsonString forKey:@"phoneContacts"];
    return uploadDic;
}
+ (void)shouldUploadContacts:(id)info
                     success:(successHandler)successHandler
                     failure:(failureHandler)failureHandler{
    
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/uploadUserPhoneContacts",kHostURL];

    NSMutableDictionary *uploadDic = [self uploadDic];
    
    [HttpRequest postWithURLString:URL parameters:uploadDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
}
+ (void)shouldUpdateUserInfo:(NSDictionary *)info
                     success:(successHandler)successHandler
                     failure:(failureHandler)failureHandler{
    
    
    NSDictionary *infoDic = [MMDLoggin accountDic];
    NSAssert(infoDic, @"用户名密码空!");
    [LoginModel loginUser:infoDic completionHandler:^(NSDictionary *resultDictionary) {
        if ([resultDictionary[@"code"] integerValue] == 0) {
            [AppUserInfoHelper updateUserInfo:resultDictionary];
            successHandler(resultDictionary);
        }
    } FailureHandler:^(NSError *error) {
        failureHandler(error);
    }];

}
@end
