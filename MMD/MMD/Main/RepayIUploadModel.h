//
//  RepayIUploadModel.h
//  MMD
//
//  Created by pencho on 16/4/22.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface RepayIUploadModel : BaseModel

+ (void)uploadRepayInfo:(id)content
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler;

@end
