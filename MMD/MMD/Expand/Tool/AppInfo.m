//
//  AppInfo.m
//  MMD
//
//  Created by pencho on 16/4/1.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "AppInfo.h"
#import <UIDevice+YYAdd.h>
#import <SSKeychain.h>


@implementation AppInfo

+ (NSString *)app_Version{
    NSDictionary *infoPlistDic = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoPlistDic objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
+ (NSString *)model{
    return [[UIDevice currentDevice] model];
}
+ (NSString *)systemVersion{
    return [UIDevice currentDevice].systemVersion;
}
+ (NSString *)systemName{
    return [UIDevice currentDevice].systemName;
}
+ (NSString *)localizedModel{
    return [UIDevice currentDevice].localizedModel;
}

/**********/
+ (NSString *)machineModel{
    return [UIDevice currentDevice].machineModel;
}
+ (NSString *)machineModelName{
    return [UIDevice currentDevice].machineModelName;
}
+ (NSString *)UUIDString{
    
    NSString *savedUUIDString = [SSKeychain passwordForService:@"UUID" account:@"MMD"];
    if (savedUUIDString == nil || [savedUUIDString isEqualToString:@""]) {
        savedUUIDString = [UIDevice currentDevice].identifierForVendor.UUIDString;
        NSError *error = nil;
        [SSKeychain setPassword:savedUUIDString forService:@"UUID" account:@"MMD" error:&error];
    }
    NSLog(@"UUID ---> %@",savedUUIDString);
    savedUUIDString = [savedUUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"UUID ---> %@",savedUUIDString);
    return savedUUIDString;
}
@end
