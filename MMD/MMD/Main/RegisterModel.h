//
//  RegisterModel.h
//  MMD
//
//  Created by pencho on 16/3/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject

+ (void)getSecurityCode:(NSDictionary *)info
      completionHandler:(void(^)(NSDictionary *resultDictionary))completationBlock
         FailureHandler:(void(^)(NSError *error))failureBlock;

@end
