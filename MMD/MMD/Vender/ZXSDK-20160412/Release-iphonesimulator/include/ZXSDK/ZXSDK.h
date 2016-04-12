//
//  ZXSDK.h
//  ZXSDK
//
//  Created by Ray on 16/3/21.
//  Copyright © 2016年 zhenxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXMemberDetail.h"

/**
 * 返回结果类型枚举
 */
typedef enum {
    ZXResult_SUCCESSED = 0,            //成功
    ZXResult_USER_CANCELED,            //用户取消了操作
    ZXResult_INVALID_USERID,           //用户无效
    ZXResult_INVALID_APP,              //APP无效
    ZXResult_USERID_ALREADY_EXIST,     //用户id已经存在
    ZXResult_IDCARD_ALREADY_EXIST,     //身份证已经存在
    ZXResult_MOBILENO_ALREADY_EXIST,   //手机号码已经存在
    ZXResult_INTERNEL_ERROR,           //系统错误
    ZXResult_NETWORK_ERROR             //网络出错或服务器连接异常
} ZXResultCode;

/**
 * 调用接口使用的回调函数
 * @param code 真信授权的appid
 * @param message 接口返回的消息
  * @param memberDetail 接口返回的ZXMemberDetail对象(部分接口返回)
 */
typedef void(^ZXCallback)(ZXResultCode code,NSString* message,ZXMemberDetail *memberDetail);


/**
 * 调用接口 实现的回调代理
 */
@protocol ZXSDKDelegate<NSObject>
/**
 * zxCallback 回调方法
 * @param code 真信授权的appid
 * @param message 接口返回的消息
 * @param tag 调用标识
 * @param memberDetail 接口返回的ZXMemberDetail对象(部分接口返回)
 */
-(void)zxCallback:(ZXResultCode)code withMessage:(NSString *)message forTag:(NSInteger)tag withMemberDetail:(ZXMemberDetail *)memberDetail;
@end


@interface ZXSDK : NSObject

/**
 * (API)初始化 APP初始化调用一次
 * @param appId 真信授权的appid
 * @param appSecret 真信授权的appsecret
 */
+(void)configWithAppId:(NSString *)appId withAppSecret:(NSString *)appSecret;

/**
 * (API)结束掉一个任务
 * @param taskId 取消一个SDK操作（会cancel网络请求)
 */
+(void)cancelTask:(NSUInteger)taskId;

/**
 * (API) 调用刷脸登录（有UI）
 * @param uid 用户在第三方APP体系下的id值
 * @param callback 回调函数
 *
 */
+(void)loginByFaceForUid:(NSString *)uid withCallback:(ZXCallback)callback;


/**
 * (API)将第三方用户与真信绑定起来 （有UI）
 *
 * 在当前APP体系下检测UID,MOBILENO是否被绑定过，如果有任何一个被绑定过，则无需要再绑定，返回相关信息
 * 否则进入绑定的过程，先真人认证，再拍身份证照片，完成绑定
 *
 * @param uid :用户在第三方APP体系下的id值
 * @param userMobile :用户的手机号
 * @param callback :回调函数
 *
 */
+(void)bindForUid:(NSString *)uid withMobile:(NSString *)userMobile withCallback:(ZXCallback)callback;


/**
 * (API)解除绑定
 *
 * @param uid :用户在第三方APP体系下的id值
 * @param callback :回调函数
 *
 * @return taskId :任务id
 */
+(NSUInteger)unbindForUid:(NSString *)uid withCallback:(ZXCallback)callback;


/**
 * (API) 调用身份认证
 *该调用会去真正比对用户拍摄身份证的照片头像与公安部系统的用户身份证照片的头像
 *
 * @param uid :用户在第三方APP体系下的id值
 * @param callback :回调接类,API通过idcardVerification_Callback函数来返回登录结果
 *
 * @param tag :调用标识
 * @param deleg :回调代理
 *
 * @return taskId :任务id
 */
+(NSUInteger)idcardVerificationForUid:(NSString *)uid withCallback:(ZXCallback)callback;
+(NSUInteger)idcardVerificationForUid:(NSString *)uid withTag:(NSInteger)tag withSDKDelegate:(id<ZXSDKDelegate>)deleg;

/**
 * (API) 根据身份证号码得到用户的真信认证数据
 *
 * @param idcard 当前APP体系下的用户的身份证号码
 * @param callback 回调函数
 *
 * @param tag :调用标识
 * @param deleg :回调代理
 *
 * @return taskId :任务id
 */
+(NSUInteger)getMemberDetailByIDCard:(NSString *)idcard withCallback:(ZXCallback)callback;
+(NSUInteger)getMemberDetailByIDCard:(NSString *)idcard withTag:(NSInteger)tag withSDKDelegate:(id<ZXSDKDelegate>)deleg;


/**
 * (API) 根据手机号码得到用户的真信认证数据
 *
 * @param mobileno  当前APP体系下用户的手机号码
 * @param callback  回调函数
 *
 * @param tag :调用标识
 * @param deleg :回调代理
 *
 * @return taskId :任务id
 */
+(NSUInteger)getMemberDetailByMobileNo:(NSString *)mobileno withCallback:(ZXCallback)callback;
+(NSUInteger)getMemberDetailByMobileNo:(NSString *)mobileno withTag:(NSInteger)tag withSDKDelegate:(id<ZXSDKDelegate>)deleg;


/**
 * (API) 根据uid得到用户的真信认证数据
 *
 * @param uid :用户在第三方APP体系下的id值
 * @param callback :回调函数
 *
 * @param tag :调用标识
 * @param deleg :回调代理
 *
 * @return taskId :任务id
 */
+(NSUInteger)getMemberDetailByUid:(NSString *)uid withCallback:(ZXCallback)callback;
+(NSUInteger)getMemberDetailByUid:(NSString *)uid withTag:(NSInteger)tag withSDKDelegate:(id<ZXSDKDelegate>)deleg;

/**
 * (API) 根据uid得到用户的真信认证数据
 *
 * @param mobileNo :当前APP体系下用户的手机号码
 * @param uid :用户在第三方APP体系下的id值
 * @param callback :回调函数
 *
 * @param tag :调用标识
 * @param deleg :回调代理
 *
 * @return taskId :任务id
 */

+(NSUInteger)updateMobileNo:(NSString *)mobileNo forUid:(NSString *)uid withCallback:(ZXCallback)callback;
+(NSUInteger)updateMobileNo:(NSString *)mobileNo forUid:(NSString *)uid withTag:(NSInteger)tag withSDKDelegate:(id<ZXSDKDelegate>)deleg;
@end
