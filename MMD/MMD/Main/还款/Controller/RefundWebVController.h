//
//  RefundWebVController.h
//  MMD
//
//  Created by pencho on 16/4/20.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseWebViewController.h"

//typedef NS_ENUM(NSInteger,kDetailType) {
//    kRefundDetailType= 0,
//    kDidRefundDetailType
//};

@interface RefundWebVController : BaseWebViewController

@property (nonatomic, strong)NSNumber *terms;
//还款金额
@property (nonatomic, strong)NSNumber *totalFee;
//还款计划 Id
@property (nonatomic, strong)NSNumber *orderNo;


@end
