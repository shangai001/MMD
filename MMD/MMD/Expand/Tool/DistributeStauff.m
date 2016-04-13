//
//  LoginStauff.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "DistributeStauff.h"
#import <SVProgressHUD.h>
#import "ThirdUpLoadItem.h"





@implementation DistributeStauff

+ (void)shouldBlindUser:(NSString *)userId mobileId:(NSString *)phoneNumber{
    
    [ZXSDK bindForUid:userId withMobile:phoneNumber withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        
        ThirdUpLoadItem *item = [ThirdUpLoadItem new];
        if (code == ZXResult_IDCARD_ALREADY_EXIST) {
            [SVProgressHUD showInfoWithStatus:@"身份证已经绑定!"];
        }
        if (code == ZXResult_INVALID_USERID) {
            [SVProgressHUD showInfoWithStatus:@"不可用帐号!"];
        }
        if (code == ZXResult_MOBILENO_ALREADY_EXIST) {
            [self getMemberDetailByMobileNo:phoneNumber withCallback:^(ZXResultCode codeMobile, NSString *messageMobile, ZXMemberDetail *mobileDetail) {
                if (codeMobile == ZXResult_SUCCESSED) {
                    if ([[NSThread currentThread] isMainThread]) {
                        NSLog(@"成员信息 %@",mobileDetail);
                        [item downloadImagesWith:mobileDetail];
                    }
                    
                }
            }];
        }
        if (code == ZXResult_USERID_ALREADY_EXIST || code == ZXResult_SUCCESSED) {
            [self idcardVerificationForUid:userId withCallback:^(ZXResultCode codeUserId, NSString *messageUserId, ZXMemberDetail *userIdDetail) {
                if (codeUserId == ZXResult_SUCCESSED) {
                    if ([[NSThread currentThread] isMainThread]) {
                        NSLog(@"成员信息 %@",userIdDetail);
                        [item downloadImagesWith:userIdDetail];
                    }
                    
                }
            }];
        }
    }];
}

+(void)idcardVerificationForUid:(NSString *)uid withCallback:(ZXCallback)callback{
    
    [ZXSDK idcardVerificationForUid:uid withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        
        callback(code,message,memberDetail);
        NSLog(@"获取详情code = %@ message = %@ memberDetail = %@",@(code),message,memberDetail);
    }];
}
+(void)getMemberDetailByMobileNo:(NSString *)mobileno withCallback:(ZXCallback)callback{
    
    [ZXSDK getMemberDetailByMobileNo:mobileno withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        
        NSLog(@"获取详情code = %@ message = %@ memberDetail = %@",@(code),message,memberDetail);
        callback(code,message,memberDetail);
    }];
}

+(void)getMemberDetailByIDCard:(NSString *)idcard withCallback:(ZXCallback)callback{
    
    [ZXSDK getMemberDetailByIDCard:idcard withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        callback(code,message,memberDetail);
    }];
}
+ (void)updateUserInfo{
    
}
/*
 if (code == ZXResult_SUCCESSED) {
 
 IDCardModel *idModel = memberDetail.idcardModel;
 ZXMemberModel *memModel = memberDetail.memberModel;
 
 }
 */
@end
