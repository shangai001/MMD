//
//  GraphicVerification.h
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

typedef void(^successImage)(UIImage *codeImage);
typedef void(^failureImage)(NSError *error);


@interface GraphicVerification : BaseModel

+ (void)getGraphicVerification:(NSDictionary *)info
                  completation:(successImage)successHandler
                       failure:(failureImage)failureHandler;


@end
