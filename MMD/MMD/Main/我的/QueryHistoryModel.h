//
//  QueryHistoryModel.h
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface QueryHistoryModel : BaseModel

/**
 *  查询用户历史申请记录
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)queryHistoryInfo:(NSDictionary *)info
                 success:(successHandler)successHandler
                 failure:(failureHandler)failureHandler;


@end
