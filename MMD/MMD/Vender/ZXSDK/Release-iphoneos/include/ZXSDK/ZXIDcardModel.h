//
//  ZXIDcardModel.h
//  ZXSDK
//
//  Created by Ray on 16/2/19.
//  Copyright © 2016年 zhenxin. All rights reserved.
//

#import "ZXBaseModel.h"

@interface ZXIDcardModel : ZXBaseModel

//font 身份证正面
@property NSString *front_faceImgId;                    //人脸图像id
@property NSString *front_imgId;                        //图像id

@property NSString *front_info_name;                    //姓名
@property NSString *front_info_year;                    //年
@property NSString *front_info_month;                   //月
@property NSString *front_info_day;                     //日
@property NSString *front_info_sex;                     //性别
@property NSString *front_info_address;                 //住址
@property NSString *front_info_number;                  //身份证号码
@property NSString *front_info_nation;                  //民族
@property NSString *front_info_oriAdministrativeArea;   //身份证号码所属行政区

@property BOOL front_validity_address;                  //验证结果
@property BOOL front_validity_birthday;                 //验证结果
@property BOOL front_validity_name;                     //验证结果
@property BOOL front_validity_number;                   //验证结果
@property BOOL front_validity_sex;                      //验证结果

//back 身份证背面
@property NSString *back_imgId;                         //身份证图片id
@property float back_authorityConfidence;               //身份证签发机（authority）关可信度
@property NSString *back_idcardWithinPeriod;            //身份证是否还在有效期内（0:未检测或有效期识别有误、1：在有效期内、2：不在有效期内

@property NSString *back_info_authority;                //签发机关
@property NSString *back_info_timelimit;                //有效期限

@property BOOL back_validity_authority;                 //签发机关 验证状态
@property BOOL back_validity_timelimit;                 //有效期限 验证状态

@end
