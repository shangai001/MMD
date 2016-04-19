//
//  RefundItem.h
//  MMD
//
//  Created by pencho on 16/4/18.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefundItem : NSObject
@property (nonatomic, strong)NSNumber *repayAmount;
@property (nonatomic, strong)NSNumber *remainAmount;
@property (nonatomic, strong)NSNumber *term;
@property (nonatomic, strong)NSNumber *overdue;
@property (nonatomic, strong)NSNumber *playdate;

@end
