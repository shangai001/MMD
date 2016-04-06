//
//  MMDLoggin.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMDLoggin.h"

#define PASSWORD_KEY @"LastPasswordKey"
#define PASSWORD_VALUE @"LastPasswordValue"

@implementation MMDLoggin

+ (BOOL)isLoggin{
    
    BOOL isLoggin = [SDUserDefault boolForKey:Loggin];
    
    return isLoggin;
}
/*
 {
 @"LastPasswordKey":@"17710243738"
 @"LastPasswordValue":@"qqqqqq"
 }
 */
#pragma mark Record/Delete Password
+ (void)ez_RecordUser:(NSString *)key_Phone password:(NSString *)value_Password{
    
    [SDUserDefault setObject:key_Phone forKey:PASSWORD_KEY];
    [SDUserDefault setObject:value_Password forKey:PASSWORD_VALUE];
    
    [SDUserDefault synchronize];
}
+ (void)ez_ResetStandardUserDefaults{
    
    NSDictionary *userDefaultDic = [SDUserDefault dictionaryRepresentation];
    
    for (NSString *key in [userDefaultDic allKeys]) {
        //除了别删除账户密码
        if (![key isEqualToString:PASSWORD_KEY] && ![key isEqualToString:PASSWORD_VALUE]) {
            
            [SDUserDefault removeObjectForKey:key];
        }
    }
    [SDUserDefault synchronize];
}
+ (NSString *)ez_FindPasswordForPhone:(NSString *)phoneNumber{
    
    NSDictionary *userDefaultDic = [SDUserDefault dictionaryRepresentation];
    
    NSString *record_Key = userDefaultDic[PASSWORD_KEY];
    
    if ([record_Key isEqualToString:phoneNumber]) {
        
        NSString *record_Password = userDefaultDic[PASSWORD_VALUE];
        
        return record_Password;
    }
    return nil;
}

@end
