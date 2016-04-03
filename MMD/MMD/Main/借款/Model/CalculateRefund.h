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
 *  计算每月还款数目
 *
 *  @param loanNumber 借款数目
 *  @param month      还款时间
 *
 *  @return 每月还款数目
 */
+ (NSUInteger)calculateRefundWithNumber:(NSUInteger)loanNumber time:(NSUInteger)month;

@end
