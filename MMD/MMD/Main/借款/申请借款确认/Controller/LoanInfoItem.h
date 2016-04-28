//
//  LoanInfoItem.h
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanInfoItem : NSObject

@property (assign, nonatomic)NSDecimalNumber *loanMoney;
@property (assign, nonatomic)NSDecimalNumber *refundMoneyEveryMoth;
@property (assign, nonatomic)NSDecimalNumber *refundMoth;

@end
