//
//  RegisterItem.h
//  MMD
//
//  Created by pencho on 16/3/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterItem : NSObject
@property (nonatomic, copy)NSString *phoneNum;
@property (nonatomic, copy)NSString *securityCode;
@property (nonatomic, copy)NSString *password;


@property (nonatomic, strong)NSNumber *returnSecurityCode;

@end
