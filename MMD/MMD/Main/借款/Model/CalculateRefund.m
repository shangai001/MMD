//
//  CalculateRefund.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "CalculateRefund.h"

@implementation CalculateRefund

+ (NSUInteger)calculateRefundWithNumber:(NSUInteger)loanNumber time:(NSUInteger)month{
    
    
    
    
    NSUInteger refundNumber =  loanNumber * (1 + 0.8 + month * 0.1);
    
    return refundNumber;
}

@end
