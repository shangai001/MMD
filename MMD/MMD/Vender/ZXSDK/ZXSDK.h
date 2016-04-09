//
//  ZXSDK.h
//  ZXSDK
//
//  Created by Ray on 16/3/21.
//  Copyright © 2016年 zhenxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXMemberDetail.h"

typedef enum {
    ZXResult_SUCCESSED = 0,//成功
    ZXResult_USER_CANCELED,//用户取消了操作
    ZXResult_INVALID_USERID,//用户无效
    ZXResult_INVALID_APP,//APP无效
    ZXResult_USERID_ALREADY_EXIST,//用户id已经存在
    ZXResult_IDCARD_ALREADY_EXIST,//身份证已经存在
    ZXResult_MOBILENO_ALREADY_EXIST,//手机号码已经存在
    ZXResult_INTERNEL_ERROR,//系统错误
    ZXResult_NETWORK_ERROR//网络出错或服务器连接异常
} ZXResultCode;


typedef void(^ZXCallback)(ZXResultCode code,NSString* message,ZXMemberDetail *memberDetail);

@protocol ZXSDKDelegate<NSObject>
-(void)zxCallback:(ZXResultCode)code withMessage:(NSString *)message forTag:(NSInteger)tag withMemberDetail:(ZXMemberDetail *)memberDetail;
@end

//private String clientAppId = "55e3e58c59fb43b3b67fe8e02236cb6e";
//private String clientAppSecret = "2fb7ab67b24e46f899c2587da417885a";


@interface ZXSDK : NSObject

/**
 * (API)初始化
 *
 */
+(void)configWithAppId:(NSString *)appId withAppSecret:(NSString *)appSecret;

/**
 * (API)结束掉一个任务
 *
 */
+(void)cancelTask:(NSUInteger)taskId;

/**
 * (API) 调用ZX刷脸登录
 *
 * @param uid
 *           用户在第三方APP体系下的id值
 * @param callback
 *           回调接类,API通过loginByFace_Callback函数来返回登录结果
 *
 * @return 调用成功则返回true,调用失败则返回false
 */


+(void)loginByFaceForUid:(NSString *)uid withCallback:(ZXCallback)callback;


/**
 * (API)将第三方用户与真信绑定起来
 *
 * 在当前APP体系下检测UID,MOBILENO是否被绑定过，如果有任何一个被绑定过，则无需要再绑定，返回相关错误
 * 否则进入绑定的过程，先真人认证，再拍身份证照片片，完成绑定
 *
 * @param uid
 *           用户在第三方APP体系下的id值
 * @param userMobile
 *           用户的手机号
 * @param callback
 *           回调类,API通过bind_Callback函数来返回登录结果
 *
 * @return 调用成功则返回true,调用失败则返回false
 */
+(void)bindForUid:(NSString *)uid withMobile:(NSString *)userMobile withCallback:(ZXCallback)callback;


/**
 * (API)解绑
 *
 * @param uid
 *           用户在第三方APP体系下的id值
 * @param callback
 *           回调类,API通过bind_Callback函数来返回登录结果
 * @return
 */
+(NSUInteger)unbindForUid:(NSString *)uid withCallback:(ZXCallback)callback;


/**
 * (API) 调用身份认证
 *
 * 该调用会去真正比对用户拍摄身份证的照片头像与公安部系统的用户身份证照片的头像
 *
 * @param uid
 *           用户在第三方APP体系下的id值
 * @param callback
 *           回调接类,API通过idcardVerification_Callback函数来返回登录结果
 *
 * @return 调用成功则返回true,调用失败则返回false
 */
+(NSUInteger)idcardVerificationForUid:(NSString *)uid withCallback:(ZXCallback)callback;
+(NSUInteger)idcardVerificationForUid:(NSString *)uid withTag:(NSInteger)tag withSDKDelegate:(id<ZXSDKDelegate>)deleg;

/**
 * (API) 根据身份证号码得到用户的真信认证数据
 *
 * @param idcard
 *           当前APP体系下的用户的身份证号码
 * @param callback
 *           回调类，API通过getMemberDetailByIDCard_Callback来返回值
 *
 * @return 调用成功则返回true,调用失败则返回false
 */
+(NSUInteger)getMemberDetailByIDCard:(NSString *)idcard withCallback:(ZXCallback)callback;
+(NSUInteger)getMemberDetailByIDCard:(NSString *)idcard withTag:(NSInteger)tag withSDKDelegate:(id<ZXSDKDelegate>)deleg;


/**
 * (API) 根据手机号码得到用户的真信认证数据
 *
 * @param mobileno
 *           当前APP体系下用户的手机号码
 * @param callback
 *           回调类，API通过getMemberDetailByMobileNo_Callback来返回值
 *
 * @return 调用成功则返回true,调用失败则返回false
 */
+(NSUInteger)getMemberDetailByMobileNo:(NSString *)mobileno withCallback:(ZXCallback)callback;
+(NSUInteger)getMemberDetailByMobileNo:(NSString *)mobileno withTag:(NSInteger)tag withSDKDelegate:(id<ZXSDKDelegate>)deleg;


/**
 * (API) 得到用户的真信认证数据
 *
 * @param uid
 *           用户在第三方APP体系下的id值
 * @param callback
 *           回调类，API通过getMemberDetail_Callback来返回值
 *
 * @return 调用成功则返回true,调用失败则返回false
 */
+(NSUInteger)getMemberDetailByUid:(NSString *)uid withCallback:(ZXCallback)callback;
+(NSUInteger)getMemberDetailByUid:(NSString *)uid withTag:(NSInteger)tag withSDKDelegate:(id<ZXSDKDelegate>)deleg;
@end
