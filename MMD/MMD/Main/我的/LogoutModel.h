//
//  LogoutModel.h
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface LogoutModel : BaseModel

/**
 *  退出登录
 *
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)logoutUserSuccess:(successHandler)successHandler
                  failure:(failureHandler)failureHandler;


@end
