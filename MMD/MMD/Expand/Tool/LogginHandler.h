//
//  LogginHandler.h
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface LogginHandler : NSObject

/**
 *  跳转到登录页面
 *
 *  @param currentVC
 */
+ (void)shouldLogginAt:(UIViewController *)currentVC;

/**
 *  上传设备信息(brand/model/token/userId/uuid)
 *
 *  @param info           设备信息
 *  @param successHandler 上传成功回调
 *  @param failureHandler 上传失败回调
 */

+ (void)shouldUploadDeviceInfo:(NSDictionary *)info
                       success:(successHandler)successHandler
                       failure:(failureHandler)failureHandler;
/**
 *  绑定设备信息用于百度推送
 *
 *  @param info           设备信息
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)blindDeviceInfo:(NSDictionary *)info
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler;
/**
 *  上传通讯录
 *
 *  @param info           通讯录信息
 *  @param successHandler 上传成功回调
 *  @param failureHandler 上传失败回调
 */
+ (void)shouldUploadContacts:(id)info
                     success:(successHandler)successHandler
                     failure:(failureHandler)failureHandler;
/**
 *  更新用户信息
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)shouldUpdateUserInfo:(NSDictionary *)info
                     success:(successHandler)successHandler
                     failure:(failureHandler)failureHandler;

@end
