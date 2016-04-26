//
//  MineModel.h
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface MineModel : BaseModel


/**
 *  查询总的未读消息
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)queryAllNotifications:(NSDictionary *)info
                      success:(successHandler)successHandler
                      failure:(failureHandler)failureHandler;


@end
