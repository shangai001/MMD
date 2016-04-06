//
//  BankModel.h
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface BankModel : BaseModel

+ (void)getBankList:(NSDictionary *)info
       completation:(successHandler)success
            failure:(failureHandler)failure;


@end
