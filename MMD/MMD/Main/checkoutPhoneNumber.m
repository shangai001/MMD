//
//  checkoutPhoneNumber.m
//  MMD
//
//  Created by pencho on 16/2/29.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "checkoutPhoneNumber.h"

@implementation checkoutPhoneNumber


+ (BOOL)checkTelNumber:(NSString*)telNumber

{
    NSString *pattern =@"^1+[3578]+\\d{9}";
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

@end
