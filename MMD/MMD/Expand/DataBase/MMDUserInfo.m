//
//  UserInfoImporter.m
//  MMD
//
//  Created by pencho on 16/3/13.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMDUserInfo.h"
#import "AppDelegate.h"

@implementation MMDUserInfo


+ (instancetype)shareUserInfo{
    
    static MMDUserInfo *importer = nil;
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        importer = [[MMDUserInfo alloc] init];
    });
    return importer;
}

//登录成功后更新各大属性
- (void)updateUserInfo:(NSDictionary *)userDictionary{
    
    //标记当前登录成功
    if (![SDUserDefault boolForKey:Loggin]) {
        [SDUserDefault setBool:YES forKey:Loggin];
    }
    //更新
    NSDictionary *dataDic = userDictionary[@"data"];
    self.userInfo = dataDic[@"userInfo"];
    self.user = dataDic[@"user"];
    self.userBank = dataDic[@"userBank"];
    self.userJob = dataDic[@"userJob"];
    
    AppDelegate *app_delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app_delegate.userInfo = self;
}

/*
+ (void)updateUserInfo:(NSDictionary *)userDictionary{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         NSDictionary *dataDic = userDictionary[@"data"];
        for (NSString *keyString in [dataDic allKeys]) {
            id dic = dataDic[keyString];
            if (![dic isKindOfClass:[NSNull class]]) {
                [self saveDictionaryInUserDefault:dic];
            }
        }
        //通知主线程
        dispatch_async(dispatch_get_main_queue(), ^{
        });
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
  */


@end
