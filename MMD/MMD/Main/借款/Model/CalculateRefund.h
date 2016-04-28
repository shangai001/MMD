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
 *  计算每月还款
 *
 *  @param principal 本金
 *  @param count     借款期数
 *
 *  @return 每月应还数
 */
+ (NSDecimalNumber *)shouldRepayEveryMonthPrincipal:(NSInteger)principal mothCount:(NSInteger)count;
/**
 *  获取当前用户费率字典
 *
 *  @return
 */
+ (NSDictionary *)getCurrentUserRateDic;

/**
 *  综合管理费率
 *
 *  @param principal 本金
 *
 *  @return 综合管理费率
 */
+ (NSDecimalNumber *)overHeadMentMoney:(NSInteger)principal;
/**
 *  月管理费
 *
 *  @return
 */
+ (NSDecimalNumber *)manageFeeEveryMonth;
/**
 *  实际到账金额
 *
 *  @param principal
 *  @param count
 *
 *  @return
 */
+ (NSDecimalNumber *)realMoneyPrincipal:(NSInteger)principal mothCount:(NSInteger)count;

@end
