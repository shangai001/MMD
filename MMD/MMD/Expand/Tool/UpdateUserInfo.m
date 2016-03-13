//
//  UpdateUserInfo.m
//  MMD
//
//  Created by pencho on 16/3/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "UpdateUserInfo.h"

@implementation UpdateUserInfo

+ (void)updateUserInfo:(NSDictionary *)userDictionary{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        NSDictionary *dataDic = userDictionary[@"data"];
        for (NSString *keyString in [dataDic allKeys]) {
            NSDictionary *dic = dataDic[keyString];
            [UpdateUserInfo saveDictionaryInUserDefault:dic];
        }
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *userId = [SDUserDefault valueForKey:@"userId"];
            NSLog(@"userId  %@",userId);
        });
        
    });
    
    
}
+ (void)saveDictionaryInUserDefault:(NSDictionary *)info{
    
    [info enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //除去id
        if (![key isEqualToString:@"id"]) {
            
            if (![obj isKindOfClass:[NSNull class]]) {
                
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    
                    [UpdateUserInfo saveDictionaryInUserDefault:obj];
                    
                }else{
                    
                    [SDUserDefault setValue:obj forKey:key];
                }
                
            }else{
                
                NSLog(@"[obj isKindOfClass:[NSNull class]] key->%@ obj->%@",key,obj);
            }
        }
    }];
}
@end
