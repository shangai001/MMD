//
//  WarnLoginModel.h
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface WarnLoginModel : BaseModel

+ (void)postWarnningMessageToPhone:(NSDictionary *)phoneInfo success:(successHandler)successHandler failure:(failureHandler)failureHandler;

@end
