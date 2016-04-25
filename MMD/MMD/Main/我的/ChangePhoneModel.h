//
//  ChangePhoneModel.h
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface ChangePhoneModel : BaseModel

/**
 *  更改手机号吗
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)changePhoneNumber:(NSDictionary *)info
                  success:(successHandler)successHandler
                  failure:(failureHandler)failureHandler;


@end
