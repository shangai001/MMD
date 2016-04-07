//
//  RefundTextHelper.h
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RefundTextHelper : NSObject

/**
 *  根据借款数和还款月数creat AttributedString
 *
 *  @param loanCount
 *  @param month
 *
 *  @return
 */
+ (NSAttributedString *)formatAttributeStringWith:(NSUInteger)refundCount refundMonth:(NSUInteger)month;

@end
