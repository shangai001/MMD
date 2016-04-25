//
//  QueryAttachmentModel.h
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface QueryAttachmentModel : BaseModel

/**
 *  查询用户附件列表
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)queryAttachment:(NSDictionary *)info
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler;
/**
 *  上传修改附件
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler 
 */
+ (void)uploadAttachment:(NSDictionary *)info
                 success:(successHandler)successHandler
                 failure:(failureHandler)failureHandler;

@end
