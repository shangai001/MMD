//
//  QueryMessageModel.h
//  MMD
//
//  Created by pencho on 16/4/27.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface QueryMessageModel : BaseModel

//获取消息列表
+ (void)getMessageList:(NSDictionary *)info
               success:(successHandler)successHandler
               failure:(failureHandler)failureHandler;

//发送消息
+ (void)sendMessage:(NSDictionary *)info
            success:(successHandler)successHandler
            failure:(failureHandler)failureHandler;
@end
