//
//  PrepareDataWorker.h
//  MMD
//
//  Created by pencho on 16/4/14.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrepareDataWorker : NSObject

/**
 *  显示状态栏上网络指示器
 */
+ (void)showStatusIndictorView;
/**
 *  配置 ZXSDK
 */
+ (void)configureZXSDK;
/**
 *  重新登录
 */
+ (void)reLoginIfHasUserIdPassword;

@end
