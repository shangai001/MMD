//
//  LoginStauff.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "DistributeStauff.h"



@implementation DistributeStauff

+ (void)shouldBlindUser:(NSString *)userId mobileId:(NSString *)phoneNumber with:(ZXCallback)callBack{
    
    [ZXSDK bindForUid:userId withMobile:phoneNumber withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        callBack(code,message,memberDetail);
    }];
    
}

+(void)idcardVerificationForUid:(NSString *)uid withCallback:(ZXCallback)callback{
    
    [ZXSDK idcardVerificationForUid:uid withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        callback(code,message,memberDetail);
    }];
}
+(void)getMemberDetailByMobileNo:(NSString *)mobileno withCallback:(ZXCallback)callback{
    
    [ZXSDK getMemberDetailByMobileNo:mobileno withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        callback(code,message,memberDetail);
    }];
}

+(void)getMemberDetailByIDCard:(NSString *)idcard withCallback:(ZXCallback)callback{
    
    [ZXSDK getMemberDetailByIDCard:idcard withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        callback(code,message,memberDetail);
    }];
}
@end
