//
//  VerifyModel.h
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface VerifyModel : BaseModel

+ (void)postFirstInformation:(NSDictionary *)info
                     success:(successHandler)successHandler
                     failure:(failureHandler)failureHandler;

@end
