//
//  RefundTextHelper.m
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RefundTextHelper.h"
#import "CalculateRefund.h"
#import "ColorHeader.h"

@implementation RefundTextHelper

+ (NSAttributedString *)formatAttributeStringWith:(NSUInteger)loanCount refundMonth:(NSUInteger)month{
    
    NSUInteger refundCount = [CalculateRefund calculateRefundWithNumber:loanCount time:month];
    
    NSString *countString = [NSString stringWithFormat:@"%@",@(refundCount)];
    NSString *timeString = [NSString stringWithFormat:@"%@",@(month)];
    //借款到账日后30天还款，每期还款XXX元，共X期
    NSString *baseString = @"借款到账日后30天还款，每期还款元，共期";
    NSString *aString = @"每期还款";
    NSString *bString = @"共";
    NSRange countRange = NSMakeRange(0,countString.length);
    NSRange timeRange = NSMakeRange(0, timeString.length);
    
    //计算还款数位置
    if ([baseString rangeOfString:aString].location != NSNotFound) {
        NSRange aRange = [baseString rangeOfString:aString];
        countRange.location = aRange.location + aRange.length;
    }
    //计算还款时间未知
    if ([baseString rangeOfString:bString].location != NSNotFound) {
        NSRange bRange = [baseString rangeOfString:bString];
        timeRange.location = bRange.location + bRange.length;
    }
    if (countRange.location != 0 && timeRange.location != 0) {
        NSMutableAttributedString *refundTipString = [[NSMutableAttributedString alloc] initWithString:baseString];
        //非数字属性字符串
        [refundTipString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, refundTipString.length)];
        //还款数 属性字符串
        NSAttributedString *countAttString = [[NSAttributedString alloc] initWithString:countString attributes:@{NSForegroundColorAttributeName:REDCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        //插入还款数
        [refundTipString insertAttributedString:countAttString atIndex:countRange.location];
        //还款时间属性字符串
        NSAttributedString *timeAttString = [[NSAttributedString alloc] initWithString:timeString attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        //插入时间(不要忘记位置偏移还款数的位数!!!)
        [refundTipString insertAttributedString:timeAttString atIndex:timeRange.location + countAttString.length];
        return refundTipString;
    }
    return nil;
}

@end
