//
//  IDCardModel.h
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface IDCardModel : BaseModel

/**
 *  检查身份证是否已经注册
 *
 *  @param info    idcard
 *  @param success
 *  @param failure 
 */
+ (void)checkoutIDCard:(NSDictionary *)info
          completation:(successHandler)success
               failure:(failureHandler)failure;


@end
