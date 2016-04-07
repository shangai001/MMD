//
//  CalculateRefund.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "CalculateRefund.h"
#import "AppUserInfoHelper.h"


#define MMDRate 0.0625
#define MonthRate 0.02


@implementation CalculateRefund

+ (NSDictionary *)interestDictionary{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mmd" ofType:@"txt"];
    NSData *mmdData = [NSData dataWithContentsOfFile:path];
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:mmdData options:NSJSONReadingAllowFragments error:nil];
    return object;
}

/**
 *  每月还款额度(公式:每月还款数目=(综合管理费 + (1 +每月利率) x 本金)/月数)
 *
 *  @param loanMoney 借款数
 *  @param month     还款时间(月)
 *
 *  @return 每月还款金额
 */
+ (NSUInteger)calculateRefundWithNumber:(NSUInteger)loanMoney time:(NSUInteger)month{
    
    NSDictionary *currentUserDic = [self getCurrentUserRateDic];
//    float rate = [currentUserDic[@"rate"] floatValue];
    float management = [currentUserDic[@"manageMent"] floatValue];
    NSUInteger refundMoney = (loanMoney * MonthRate * month + management * month + loanMoney)/month;
    return refundMoney;
}
+ (float)getActualMoney:(NSUInteger)loanMoney{
    //一次性扣除综合管理费
    float actualMone = loanMoney * (1 - MMDRate);
    return actualMone;
}
/**
 *  获取当前用户费率信息
 *
 *  @return
 */
+ (NSDictionary *)getCurrentUserRateDic{
    
    NSDictionary *crediteDic = [AppUserInfoHelper creditRating];
    NSString *level = crediteDic[@"name"];
    NSDictionary *interestDictionary = [self interestDictionary];
    NSDictionary *oneDic = interestDictionary[level];
    return oneDic;
}
@end
