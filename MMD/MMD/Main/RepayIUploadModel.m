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


@implementation RepayIUploadModel

+ (void)uploadRepayInfo:(id)content
                success:(successHandler)successHandler
                failure:(failureHandler)failureHandler{
    if ([content isKindOfClass:[UIImage class]]) {
        UIImage *targetImage = (UIImage *)content;
        UploadParam *param = [UploadParam new];
        param.data = UIImageJPEGRepresentation(targetImage, 1.0);
        param.name = @"需要修改";
        param.mimeType = @"image/jpg";
        param.filename = @"evidence.jpg";
        
        NSString *URL = [NSString stringWithFormat:@"%@",kHostURL];
        NSDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
        //tokenDic
        [HttpRequest uploadWithURLString:URL parameters:tokenDic uploadParam:param success:^(id responseObject) {
            successHandler(responseObject);
        } failure:^(NSError *error) {
            failureHandler(error);
        }];
    }
    
}

@end
