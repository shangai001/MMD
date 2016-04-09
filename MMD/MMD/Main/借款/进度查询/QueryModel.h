//
//  QueryModel.h
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface QueryModel : BaseModel

/**
 *  检查用户提交审核状态
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)queryLoanStatus:(NSDictionary *)info
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler;


@end
