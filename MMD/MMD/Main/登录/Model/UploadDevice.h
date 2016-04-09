//
//  UploadDevice.h
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface UploadDevice : BaseModel

+ (void)uploadDeviceInfo:(NSDictionary *)userTokenDic success:(successHandler)successHandler failure:(failureHandler)failureHandler;


@end
