//
//  UserInfoImporter.m
//  MMD
//
//  Created by pencho on 16/3/13.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "UserInfoImporter.h"
#import "AppDelegate.h"


@implementation UserInfoImporter

+ (void)updateUserInfo:(NSDictionary *)userDictionary{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        NSDictionary *dataDic = userDictionary[@"data"];
        for (NSString *keyString in [dataDic allKeys]) {
            id dic = dataDic[keyString];
            if (![dic isKindOfClass:[NSNull class]]) {
                [self saveDictionaryInUserDefault:dic];
            }
        }
        //通知主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *userId = [SDUserDefault valueForKey:@"userId"];
            NSLog(@"当前用户id --> %@",userId);
        });
        //标记当前登录成功
        if (![SDUserDefault boolForKey:Loggin]) {
            [SDUserDefault setBool:YES forKey:Loggin];
        }
        
    });
    
    
}
+ (void)saveDictionaryInUserDefault:(NSDictionary *)info{
    
    [info enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //除去id
        if (![key isEqualToString:@"id"]) {
            
            if (![obj isKindOfClass:[NSNull class]]) {
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    [self saveDictionaryInUserDefault:obj];
                    
                }else{
                    
                    [SDUserDefault setValue:obj forKey:key];
                }
                
            }else{
                
            }
        }
    }];
}


@end
