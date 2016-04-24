//
//  QueryIdModel.h
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface QueryIdModel : BaseModel

/**
 *  查询用户信用等级
 *
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)queryCreditRatingSuccess:(successHandler)successHandler
                         failure:(failureHandler)failureHandler;
/**
 *  查询用户审核状态
 *
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)queryUserCheckSuccess:(successHandler)successHandler
                      failure:(failureHandler)failureHandler;
/**
 *  查询用户联系人信息
 *
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)queryContactsSuccess:(successHandler)successHandler
                     failure:(failureHandler)failureHandler;
/**
 *  查询用户附件信息
 *
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)queryAttachmentsSuccess:(successHandler)successHandler
                        failure:(failureHandler)failureHandler;
/**
 *  查询持证拍照信息
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)queryIDPhoto:(NSDictionary *)info
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler;


@end
