//
//  RepayItem.h
//  MMD
//
//  Created by pencho on 16/4/21.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepayItem : NSObject

@property (copy, nonatomic)NSString *account;
@property (copy, nonatomic)NSString *repayMoney;
@property (copy, nonatomic)NSString *repayTime;
@property (copy, nonatomic)NSString *repayId;
//1-支付宝  2-银行卡
@property (strong, nonatomic)NSNumber *type;


@end
