//
//  IDCardModel.h
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface IDCard_Model : BaseModel

/**
 *  检查身份证是否已经注册,传入idcard
 *
 *  @param info    idcard
 *  @param success 传入idcard
 *  @param failure 
 */
+ (void)checkoutIDCard:(NSDictionary *)info
          completation:(successHandler)success
               failure:(failureHandler)failure;


@end
