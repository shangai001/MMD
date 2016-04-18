//
//  RefundModel.h
//  MMD
//
//  Created by pencho on 16/4/18.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface RefundModel : BaseModel

/**
 *  查询应还款
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)queryWillRefundInfo:(NSDictionary *)info
                    success:(successHandler)successHandler
                    failure:(failureHandler)failureHandler;
/**
 *  查询已还款
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)queryDidRefundInfo:(NSDictionary *)info
                   success:(successHandler)successHandler
                   failure:(failureHandler)failureHandler;

@end
