//
//  SubmitLoanInfo.h
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface SubmitLoanInfo : BaseModel

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


@end
