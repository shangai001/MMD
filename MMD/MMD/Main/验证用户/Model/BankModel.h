//
//  BankModel.h
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface BankModel : BaseModel
/**
 *  获取银行列表
 *
 *  @param info    nil即可
 *  @param success
 *  @param failure
 */
+ (void)getBankList:(NSDictionary *)info
       completation:(successHandler)success
            failure:(failureHandler)failure;
/**
 *  检查银行卡是否已经注册
 *
 *  @param info     bankCard
 *  @param success
 *  @param failure
 */
+ (void)checkCreditCard:(NSDictionary *)info
           completation:(successHandler)success
                failure:(failureHandler)failure;

@end
