//
//  CalculateRefund.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "CalculateRefund.h"
#import "AppUserInfoHelper.h"
#import "ReadFiler.h"



@implementation CalculateRefund


//---等额本息算法公式，每月还款额 =（贷款本金 x （月利率 x (1 + 月利率）^还款月数）/（（1 + 月利率）^(还款月数 - 1)） ------------------//
//double pow(double x, double y）;计算以x为底数的y次幂

+ (NSDecimalNumber *)shouldRepayEveryMonthPrincipal:(NSInteger)principal mothCount:(NSInteger)count{
    
    NSDictionary *crediteDic = [self getCurrentUserRateDic];
    
    NSDecimalNumber *mothRateNumber = [[NSDecimalNumber decimalNumberWithString:[crediteDic[@"yearRate"] stringValue]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithMantissa:12 exponent:0 isNegative:NO]];
    
    unsigned long long principalLong = (unsigned long long)principal;
    NSDecimalNumber *principalNumber = [NSDecimalNumber decimalNumberWithMantissa:principalLong exponent:0 isNegative:NO];
    
    //月利息 = 本金 x 月利率 x ((1 + 月利率）^还款月数）
    NSDecimalNumber *motnInterestNumber = [principalNumber decimalNumberByMultiplyingBy:mothRateNumber];
    
    NSDecimalNumber *middleNumber = [[[NSDecimalNumber one] decimalNumberByAdding:mothRateNumber] decimalNumberByRaisingToPower:count];
    
    NSDecimalNumber *moNumber = [motnInterestNumber decimalNumberByMultiplyingBy:middleNumber];
    
    //（1 + 月利率）^还款月数 - 1
    NSDecimalNumber *m1Number = [middleNumber decimalNumberBySubtracting:[NSDecimalNumber one]];
    //每月管理费
    NSDecimalNumber *manageFeeNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",crediteDic[@"manageFee"]]];
    
    //每月应该还款
    NSDecimalNumber *rePayEveryMothNumber = [[moNumber decimalNumberByDividingBy:m1Number] decimalNumberByAdding:manageFeeNumber];
    
    return rePayEveryMothNumber;
}
/**
 *  获取当前用户费率字典
 *
 *  @return
 */
+ (NSDictionary *)getCurrentUserRateDic{
    
    if ([SDUserDefault boolForKey:Loggin]) {
        NSDictionary *crediteDic = [AppUserInfoHelper creditRating];
        return crediteDic;
    }else{
        NSDictionary *crediteDic = [ReadFiler readDictionaryFile:@"mmd" fileType:@"txt"];
        return crediteDic;
    }
    return nil;
}
/**
 *  综合管理费率
 *
 *  @param principal 本金
 *
 *  @return 综合管理费率
 */
+ (NSDecimalNumber *)overHeadMentMoney:(NSInteger)principal{
    
    NSDictionary *crediteDic = [self getCurrentUserRateDic];
    unsigned long long pricipalLong = (unsigned long long)principal;
    NSDecimalNumber *principalNumber = [NSDecimalNumber decimalNumberWithMantissa:pricipalLong exponent:0 isNegative:NO];
    
    NSDecimalNumber *r1,*r2,*r3,*r4 = [NSDecimalNumber zero];
    
    NSDecimalNumber *managerRateNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",crediteDic[@"manageRate"]]];
    
    //管理费率/2
    r1 = [managerRateNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithMantissa:2 exponent:0 isNegative:NO]];
    
    //本金除以2000
    r2 = [principalNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithMantissa:2 exponent:3 isNegative:NO]];
    r3 = [r1 decimalNumberByMultiplyingBy:r2];
    r4 = [r3 decimalNumberByAdding:r1];
    
    NSComparisonResult result = [managerRateNumber compare:r4];
    NSDecimalNumber *resultNumber = result == NSOrderedDescending ? r4 : managerRateNumber;
    
    return resultNumber;
}
//月管理费
+ (NSDecimalNumber *)manageFeeEveryMonth{
    
    NSDictionary *crediteDic = [self getCurrentUserRateDic];
    NSDecimalNumber *managerFeeNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",crediteDic[@"manageFee"]]];
    
    return managerFeeNumber;
}
//实际到账金额
+ (NSDecimalNumber *)realMoneyPrincipal:(NSInteger)principal mothCount:(NSInteger)count{
    
    unsigned long long principalLong = (unsigned long long)principal;
    NSDecimalNumber *principalNumber = [NSDecimalNumber decimalNumberWithMantissa:principalLong exponent:0 isNegative:NO];
    //综合管理费
    NSDecimalNumber *onceFeeNumber = [self overHeadMentMoney:principal];
    NSDecimalNumber *realMoneyNumber = [[[NSDecimalNumber one] decimalNumberBySubtracting:onceFeeNumber] decimalNumberByMultiplyingBy:principalNumber];
    return realMoneyNumber;
}
@end
