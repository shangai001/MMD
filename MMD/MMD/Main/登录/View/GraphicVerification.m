//
//  GraphicVerification.m
//  MMD
//
//  Created by pencho on 16/4/6.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "GraphicVerification.h"

@implementation GraphicVerification

//NSString *uuid = [[UIDevice currentDevice] identifierForVendor];
+ (void)getGraphicVerification:(NSDictionary *)info
                  completation:(successImage)successHandler
                       failure:(failureImage)failureHandler{
    
    NSString *URL = [NSString stringWithFormat:@"%@/basic/code",kHostURL];
    [HttpRequest postUUIDWithURLString:URL parameters:info success:^(id responseObject) {
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
    }];
    
}

@end
