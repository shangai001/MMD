//
//  AppInfo.m
//  MMD
//
//  Created by pencho on 16/4/1.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

+ (NSString *)app_Version{
    
    NSDictionary *infoPlistDic = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoPlistDic objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
@end
