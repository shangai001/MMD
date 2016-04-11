//
//  LoginStauff.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoginStauff.h"

@implementation LoginStauff

+ (void)shouldBlindUser:(NSString *)userId mobileId:(NSString *)phoneNumber with:(ZXCallback)callBack{
    
    [ZXSDK bindForUid:userId withMobile:phoneNumber withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        callBack(code,message,memberDetail);
    }];
    
}


@end
