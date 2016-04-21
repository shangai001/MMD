//
//  RefundItem.h
//  MMD
//
//  Created by pencho on 16/4/18.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefundItem : NSObject
//还款 Id
@property (nonatomic, strong)NSNumber *refundId;

//借款 Id
@property (nonatomic, strong)NSNumber *loanId;
//每期还款
@property (nonatomic, strong)NSNumber *totalFee;
//第几期
@property (nonatomic, strong)NSNumber *term;
//是否逾期
@property (nonatomic, strong)NSNumber *overdue;
//还款日
@property (nonatomic, strong)NSNumber *playdate;

@end
