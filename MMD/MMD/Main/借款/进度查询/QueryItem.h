//
//  QueryItem.h
//  MMD
//
//  Created by pencho on 16/4/10.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryItem : NSObject

@property (strong, nonatomic)NSNumber *loanCount;
@property (strong, nonatomic)NSNumber *state;
@property (strong, nonatomic)NSNumber *term;
@property (copy, nonatomic)NSString *contractId;
@property (strong, nonatomic)NSNumber *applyTime;

@property (strong, nonatomic)NSNumber *applyConfirmTime;
@property (strong, nonatomic)NSNumber *auditTime;
@property (strong, nonatomic)NSNumber *auditConfirmTime;
@property (strong, nonatomic)NSNumber *grantFundsTime;
@property (strong, nonatomic)NSNumber *cancelTime;


@end
