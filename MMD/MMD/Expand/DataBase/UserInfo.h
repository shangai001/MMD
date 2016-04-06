//
//  UserInfoItem.h
//  MMD
//
//  Created by pencho on 16/4/5.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

/*
 "id": 1,
 "userId": 1,
 "name": "梁亮",
 "idcard": "130629198710010037",
 "idcardProvince": "",
 "idcardCity": "",
 "idcardArea": "",
 "idcardAddress": "河北省石家庄市桥东区中山东路168号",
 "nativePlace": null,
 "sex": "男",
 "birthday": 560016000000,
 "age": 29,
 "phone": "18632156680",
 "phoneRegion": "河北联通GSM卡,河北,石家庄市",
 "address": null,
 "marriage": "2",
 "marriageName": "已婚",
 "children": "2",
 "childrenName": "一个子女",
 "imei": "866002023950099",
 "imsi": "460013053601047",
 "phoneBrand": "Meizu",
 "phoneModel": "MX4 Pro",
 "phoneOs": "Android 5.1.1",
 "appVersion": "0.9.2.beta",
 "score": 265,
 "lifeRadius": "1",
 "lifeRadiusName": "方圆10公里内",
 "idcardPhoto": "https://v1-sdk.zhenxinsafe.com:9527/zxsdk/idcard/face?appId=55e3e58c59fb43b3b67fe8e02236cb6e",
 "user": null,
 "channelCode": "y001",
 "channelStr": "应用宝",
 "notInfoStates": null,
 "idcardAuthen": null,
 "contract": null,
 "amount": null,
 "expireRepay": null,
 "recentRepay": null,
 "idcardFaceCertConfidence": 0.87371498,
 "attachmentId": null,
 "totalBalance": null,
 "infoView": null
 */

@property (copy, nonatomic)NSNumber *userId;
@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *idcard;
@property (copy, nonatomic)NSString *idcardCity;
@property (copy, nonatomic)NSString *idcardProvince;
@property (copy, nonatomic)NSString *idcardArea;
@property (copy, nonatomic)NSString *idcardAddress;
@property (copy, nonatomic)id nativePlace;
@property (copy, nonatomic)NSString *sex;
@property (copy, nonatomic)NSNumber *birthday;
@property (copy, nonatomic)NSNumber *age;
@property (copy ,nonatomic)NSString *phone;
@property (copy, nonatomic)NSString *phoneRegion;
@property (copy, nonatomic)id address;

@property (copy, nonatomic)NSString *marriage;
@property (copy, nonatomic)NSString *marriageName;
@property (copy, nonatomic)NSString *children;
@property (copy, nonatomic)NSString *childrenName;
@property (copy, nonatomic)NSString *appVersion;
@property (copy, nonatomic)NSNumber *score;

@property (copy, nonatomic)NSString *lifeRadius;
@property (copy, nonatomic)NSString *lifeRadiusName;
@property (copy, nonatomic)NSString *idcardPhoto;

@property (copy, nonatomic)id user;
@property (copy, nonatomic)id notInfoStates;
@property (copy, nonatomic)id idcardAuthen;
@property (copy, nonatomic)id contract;
@property (copy, nonatomic)id amount;
@property (copy, nonatomic)id expireRepay;
@property (copy, nonatomic)id recentRepay;

@property (assign, nonatomic)float idcardFaceCertConfidence;
@property (copy, nonatomic)id attachmentId;
@property (copy, nonatomic)id totalBalance;
@property (copy, nonatomic)id infoView;

@end
