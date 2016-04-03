//
//  BaseModel.h
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"

typedef void(^successHandler)(NSDictionary *resultDic);
typedef void(^failureHandler)(NSError *error);


@interface BaseModel : NSObject

@end
