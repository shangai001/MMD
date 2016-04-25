//
//  ChangePasswordModel.h
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface ChangePasswordModel : BaseModel

/**
 *  修改密码
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)changePassword:(NSDictionary *)info
               success:(successHandler)successHandler
               failure:(failureHandler)failureHandler;

@end
