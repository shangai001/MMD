//
//  SubmitLoanInfo.h
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface SubmitLoanInfoModel : BaseModel

/**
 *  申请借款和时间提交capital,capital
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)submitLoanInfo:(NSDictionary *)info
               success:(successHandler)successHandler
               failure:(failureHandler)failureHandler;
/**
 *  检查用户是否可以提交借款申请(data = 1 可以提交,data = 0 不可以提交)
 *
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)checkIfUserCanSubmitLoanApplySuccess:(successHandler)successHandler
                                     failure:(failureHandler)failureHandler;
@end
