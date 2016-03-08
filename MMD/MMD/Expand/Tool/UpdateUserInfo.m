//
//  UpdateUserInfo.m
//  MMD
//
//  Created by pencho on 16/3/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "UpdateUserInfo.h"

@implementation UpdateUserInfo

+ (void)updateUserInfo:(NSDictionary *)user{
    [user enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSUserDefaults *st = [NSUserDefaults standardUserDefaults];
        if (obj) {
            [st setObject:obj forKey:key];
        }
    }];
}
+ (void)updateCommonHeader{
    NSDictionary *sidDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"token"];
    if (sidDic) {
        [HYBNetworking configCommonHttpHeaders:sidDic];
    }
}
@end
