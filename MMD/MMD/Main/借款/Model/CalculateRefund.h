//
//  CalculateRefund.h
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateRefund : NSObject


/**
*  每月还款数(公式:每月还款数目=(综合管理费 + (1 +每月利率) x 本金)/月数)
*
*  @param loanMoney 借款数
*  @param month     还款时间(月)
*
*  @return 每月还款金额
*/
+ (NSUInteger)calculateRefundWithNumber:(NSUInteger)loanMoney time:(NSUInteger)month;
/**
 *  返回实际到账金额
 *
 *  @param loanMoney 借款数目
 *
 *  @return 
 */
+ (float)getActualMoney:(NSUInteger)loanMoney;
/**
 *  利息字典
 *
 *  @return 
 */
+ (NSDictionary *)interestDictionary;

@end
