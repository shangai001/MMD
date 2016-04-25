//
//  EditeContactModel.h
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface EditeContactModel : BaseModel

/**
 *  上传修改联系人
 *
 *  @param info
 *  @param successHandler
 *  @param failureHandler
 */
+ (void)uploadEditeContacts:(NSDictionary *)info
                    success:(successHandler)successHandler
                    failure:(failureHandler)failureHandler;


@end
