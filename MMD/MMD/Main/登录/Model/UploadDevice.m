//
//  UploadDevice.m
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "UploadDevice.h"
#import "AppInfo.h"
#import <UIKit/UIKit.h>



@implementation UploadDevice

+ (void)uploadDeviceInfo:(NSDictionary *)userTokenDic success:(successHandler)successHandler failure:(failureHandler)failureHandler{
    
    NSString *brand = [AppInfo machineModel];
    NSString *model = [AppInfo machineModelName];
//    NSString *imei =  [UIDevice IMEI];
//    NSString *imsi =  [UIDevice IMSI];
    NSMutableDictionary *uploadDic = [NSMutableDictionary dictionaryWithDictionary:userTokenDic];
    [uploadDic setObject:brand forKey:@"brand"];
    [uploadDic setObject:model forKey:@"model"];
//    [uploadDic setObject:imei forKey:@"imei"];
//    [uploadDic setObject:imsi forKey:@"imsi"];
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/uploadDeviceInfo",kHostURL];
    [HttpRequest postWithURLString:URL parameters:uploadDic success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}

@end
