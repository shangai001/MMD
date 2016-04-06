//
//  UserInfoImporter.h
//  MMD
//
//  Created by pencho on 16/3/13.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MMDUserInfo : NSObject

- (void)updateUserInfo:(NSDictionary *)userDictionary;

@property (nonatomic, strong)NSDictionary *userInfo;
@property (nonatomic, strong)NSDictionary *userBank;
@property (nonatomic, strong)NSDictionary *userJob;
@property (nonatomic, strong)NSDictionary *user;
@property (nonatomic, strong)NSDictionary *creditRating;

@end
