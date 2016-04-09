//
//  ZXMemberModel.h
//  ZXSDK
//
//  Created by Ray on 16/2/19.
//  Copyright © 2016年 zhenxin. All rights reserved.
//

#import "ZXBaseModel.h"

@interface ZXIDcardModel : ZXBaseModel

@property NSString *memberId;

@property NSString *birthday;
@property NSString *encryptFlag;
@property NSString *faceCertResult;
@property NSString *groupId;

@property NSString *idcard;
@property NSString *idcardCertResult;
@property NSString *lastUpdateTime;
@property NSString *memberName;
@property NSString *memberNo;
@property NSString *mobileNo;
@property NSString *mobileNoCertResult;
@property NSString *mobileNoDigester;
@property NSString *modified;
@property NSString *registerTime;
@property NSString *sex;
//@property (nonatomic,strong)NSString *token;
@property NSString *tokenExpiresTime;
@property NSString *tpId;
/*
member =         {
    birthday = "1985-12-08 00:00:00";
    encryptFlag = Y;
    faceCertResult = 0;
    groupId = b7b2b1c82c8a458f8df3df3d72110afe;
    id = 8b467c264f0f4660b9cabf0466398c5b;
    idcard = 420984198512082777;
    idcardCertResult = 0;
    lastUpdateTime = "2016-02-19 11:41:00";
    memberName = "\U5f20\U96f7";
    memberNo = 13113229710;
    mobileNo = 13113229710;
    mobileNoCertResult = 1;
    mobileNoDigester = 83ac14ba0d7e009a979cd44208eaf4cd;
    modified = N;
    registerTime = "2016-02-19 11:41:00";
    sex = 1;
    token = a58b8e23c23045068fa31b35582e010f;
    tokenExpiresTime = "2016-02-26 11:41:00";
    tpId = b925ce0a49104e0ebfdbd40baf408291;
};
*/

@end
