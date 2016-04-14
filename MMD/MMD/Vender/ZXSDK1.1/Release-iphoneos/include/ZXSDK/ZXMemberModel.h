//
//  ZXMemberModel.h
//  ZXSDK
//
//  Created by Ray on 16/2/19.
//  Copyright © 2016年 zhenxin. All rights reserved.
//

#import "ZXBaseModel.h"

@interface ZXMemberModel : ZXBaseModel

@property NSString *memberName;          //用户名称
@property NSString *birthday;            //生日 yyyyMMdd
@property NSString *sex;                 //性别 0:女 1:男
@property NSString *mobileNo;            //手机号码
@property NSString *mobileNoCertResult;  //手机认证结果 0：未验证；1：真信验证；2：调用者验证；3：其它调用者验证
@property NSString *realPersonCertResult;//真人认证结果 0：未验证 1：认证通过 2：认证未通过
@property NSString *modified;            //是否修改过信息 Y：修改过 N 没有修改
@property NSString *idcard;              //身份证号
@property NSString *idcardCertResult;    //身份证认证结果（身份证是否有效）0：未验证 1：认证通过 2：认证未通过
@property int idcardAge;                 //身份证年龄 注册时利用身份证生日计算出来的真实年龄：（注册时间-出生年月），注：该年龄代表的是会员注册时的年龄。
@property NSString *idcardFaceCertResult;//身份证截图与公安部身份证人脸图片比对结果 0：未验证 1：一致 2：不一致

@property NSString *faceCertResult;      //人脸验证结果（是否本人) 0：未验证 1：验证通过（是本人，与身份照照片匹配度超过60%）2：验证未通过
@property int faceDetectionAge;          //人脸检测年龄 注册时通过人脸检测算法计算出来的平均年龄
@property int faceDetectionAttractive;   //人脸检测颜值 注册时通过人脸检测算法推算出来的颜值，值为 1~100，值越大，表示颜值越高。结果仅供参考。
@property NSString *faceDetectionSex;    //人脸检测性别 注册时通过人脸检测算法推算出来的性别 0：女 1：男
@property NSArray *imgIds;               //拍摄的人脸图片id数组

@property NSString *faceImgUrl1;         //拍摄的人脸第一张图片url(自动拍)

@property NSString *faceImgUrl2;         //拍摄的人脸第二张图片url


//nil
@property NSString *uid;                 //用户ID
@property int certifiedNum;              //被认证次数
@property NSString *idcardCertRtnmsg;    //身份证认证返回消息
@property float idcardFaceCertConfidence;//身份证截图与公安部身份证人脸图片匹配度 float 0到1
@property float faceCertConfidence;      //人脸与身份证照片匹配度 float 0到1
@property NSArray *modifiedPropertySet;  //有哪些属性用户修改过 [idcard:身份证号 memberName:会员名称 sex:性别]


/**
 * 获得拍摄的人脸第一张图片(自动拍)
 *
 * @return YES:成功发出请求 NO:没有获得正确的图片地址
 */
-(BOOL)get_faceImg1:(ZXImageHandler)imageHander;
/**
 * 获得拍摄的人脸第二张图片
 *
 * @return YES:成功发出请求 NO:没有正确的地址
 */
-(BOOL)get_faceImg2:(ZXImageHandler)imageHander;
@end
