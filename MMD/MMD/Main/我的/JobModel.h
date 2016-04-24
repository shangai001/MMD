//
//  JobModel.h
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface JobModel : BaseModel

+ (void)updateJobInfo:(NSDictionary *)info
              success:(successHandler)successHandler
              failure:(failureHandler)failureHandler;


@end
