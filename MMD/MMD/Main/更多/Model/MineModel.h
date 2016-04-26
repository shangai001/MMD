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
/**
 *  查询消息中心未读消息
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)queryNotificationCenter:(NSDictionary *)info
                        success:(successHandler)successHandler
                        failure:(failureHandler)failureHandler;
/**
 *  查询客服中心未读消息
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)queryServiceUnReadCount:(NSDictionary *)info
                        success:(successHandler)successHandler
                        failure:(failureHandler)failureHandler;

/**
 *  查询用户历史消息
 *
 *  @param info
 *  @param numer
 *  @param successHandler
 *  @param failureHandler
 */

+ (void)queryUserMessage:(NSDictionary *)info
              pageNumber:(NSInteger)numer
                 success:(successHandler)successHandler
                 failure:(failureHandler)failureHandler;


@end
