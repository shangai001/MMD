//
//  RepayIUploadModel.m
//  MMD
//
//  Created by pencho on 16/4/22.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RepayIUploadModel.h"
#import "HttpRequest.h"
#import "UploadParam.h"
#import "AppUserInfoHelper.h"
#import <NSData+YYAdd.h>



@implementation RepayIUploadModel

+ (void)uploadRepayInfo:(NSDictionary *)info Image:(UIImage *)content
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler{
    
    
    NSMutableDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    
    UIImage *targetImage = (UIImage *)content;
    NSData *imageData = UIImageJPEGRepresentation(targetImage, 0.75);
    NSString *baseString = [imageData base64EncodedString];
    
    
    [info enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [tokenDic setObject:obj forKey:key];
    }];
    
    [tokenDic setObject:baseString forKey:@"voucherPic"];
    
    NSString *URL = [NSString stringWithFormat:@"%@/repay/offlineRepay",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        
        successHandler(responseObject);
    } failure:^(NSError *error) {
        failureHandler(error);
        
    }];
}

@end
