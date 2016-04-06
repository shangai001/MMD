//
//  UserInfoImporter.h
//  MMD
//
//  Created by pencho on 16/3/13.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MMDUserInfo : NSObject

+ (instancetype)shareUserInfo;


- (void)updateUserInfo:(NSDictionary *)userDictionary;

@end
