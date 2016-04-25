//
//  ThirdUpLoadItem.m
//  MMD
//
//  Created by pencho on 16/4/13.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ThirdUpLoadItem.h"
#import "ZXMemberDetail.h"
#import <MJExtension.h>
#import "HttpRequest.h"
#import <NSData+YYAdd.h>
#import "AppUserInfoHelper.h"
#import "ConstantNotiName.h"
#import "LogginHandler.h"
#import <SVProgressHUD.h>


//front_imgUrl 身份证整体照片
//back_imgUrl 身份证背面照片
//faceImgUrl1 人脸识别照片

static NSString * const frontIDImageName = @"frontIDImage";
static NSString * const backIDImageName = @"backIDImage";
static NSString * const userTakeFaceImageName = @"userTakeImage";

@implementation ThirdUpLoadItem

/*
//为了能使用 http下载(替换 https--->http,端口替换为80)
- (NSString *)replaceHttpsString:(NSString *)originalString{
    
    originalString = [originalString stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
    originalString = [originalString stringByReplacingOccurrencesOfString:@"9527" withString:@"80"];
    return originalString;
}
*/
- (void)reDownloadImagesWith:(ZXMemberDetail *)detail{
    
    [SVProgressHUD show];
    
    ZXIDcardModel *idModel = detail.idcardModel;
    __block ThirdUpLoadItem *item = [ThirdUpLoadItem new];
    
    item.idcardPhoto = idModel.front_faceImgUrl_official;//非下载
    item.name  = idModel.front_info_name;
    item.idcard = idModel.front_info_number;
    item.address = idModel.front_info_address;
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    //进组
    dispatch_group_enter(downloadGroup);
    [idModel get_front_img:^(UIImage *image, NSError *error) {
        if (image) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            NSString *frontBase64String = [imageData base64EncodedString];
            item.idcardFront = frontBase64String;
            item.mobileIdCardFront = @"";
            //离组
            dispatch_group_leave(downloadGroup);
        }
    }];
    //进组
    dispatch_group_enter(downloadGroup);
    [idModel get_back_img:^(UIImage *image, NSError *error) {
        if (image) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            NSString *backImageBase64String = [imageData base64EncodedString];
            item.idcardBack = backImageBase64String;
            item.mobileIdCardBack = @"";
            //离组
            dispatch_group_leave(downloadGroup);
        }
    }];
    /*
     [HttpRequest downloadFile:httpbackIDUrl baseName:backIDImageName success:^(id result) {
     if (result) {
     NSData *backData = [NSData dataWithContentsOfFile:result];
     NSString *backBase64String = [backData base64EncodedString];
     item.idcardBack = backBase64String;
     item.mobileIdCardBack = (NSString *)result;
     //离组
     dispatch_group_leave(downloadGroup);
     }
     } failure:^(NSError *error) {
     
     }];
     */
    //进组
    dispatch_group_enter(downloadGroup);
    [idModel get_front_faceImg_user:^(UIImage *image, NSError *error) {
        if (image) {
            NSData *userImageData = UIImageJPEGRepresentation(image, 1.0f);
            NSString *userBase64String = [userImageData base64EncodedString];
            item.idcardHand = userBase64String;
            item.mobileIdCardHand = @"";
            //离组
            dispatch_group_leave(downloadGroup);
        }
    }];
    /*
     [HttpRequest downloadFile:httpuserPhoto baseName:userTakeFaceImageName success:^(id result) {
     if (result) {
     NSData *userData = [NSData dataWithContentsOfFile:result];
     NSString *userBase64String = [userData base64EncodedString];
     item.idcardHand = userBase64String;
     item.mobileIdCardHand = (NSString *)result;
     //离组
     dispatch_group_leave(downloadGroup);
     }
     } failure:^(NSError *error) {
     
     }];
     */
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        // 汇总代码
        [SVProgressHUD dismiss];
        [self reUploadThirdInfo:item];
    });

    
}
- (void)downloadImagesWith:(ZXMemberDetail *)detail{
    
    [SVProgressHUD show];
    
    ZXIDcardModel *idModel = detail.idcardModel;
    __block ThirdUpLoadItem *item = [ThirdUpLoadItem new];
    
    item.idcardPhoto = idModel.front_faceImgUrl_official;//非下载
    item.name  = idModel.front_info_name;
    item.idcard = idModel.front_info_number;
    item.address = idModel.front_info_address;
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    //进组
    dispatch_group_enter(downloadGroup);
    [idModel get_front_img:^(UIImage *image, NSError *error) {
        if (image) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            NSString *frontBase64String = [imageData base64EncodedString];
            item.idcardFront = frontBase64String;
            item.mobileIdCardFront = @"";
            //离组
            dispatch_group_leave(downloadGroup);
        }
    }];
    //进组
    dispatch_group_enter(downloadGroup);
    [idModel get_back_img:^(UIImage *image, NSError *error) {
        if (image) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            NSString *backImageBase64String = [imageData base64EncodedString];
            item.idcardBack = backImageBase64String;
            item.mobileIdCardBack = @"";
            //离组
            dispatch_group_leave(downloadGroup);
        }
    }];
    /*
    [HttpRequest downloadFile:httpbackIDUrl baseName:backIDImageName success:^(id result) {
        if (result) {
            NSData *backData = [NSData dataWithContentsOfFile:result];
            NSString *backBase64String = [backData base64EncodedString];
            item.idcardBack = backBase64String;
            item.mobileIdCardBack = (NSString *)result;
            //离组
            dispatch_group_leave(downloadGroup);
        }
    } failure:^(NSError *error) {
        
    }];
     */
    //进组
    dispatch_group_enter(downloadGroup);
    [idModel get_front_faceImg_user:^(UIImage *image, NSError *error) {
        if (image) {
            NSData *userImageData = UIImageJPEGRepresentation(image, 1.0f);
            NSString *userBase64String = [userImageData base64EncodedString];
            item.idcardHand = userBase64String;
            item.mobileIdCardHand = @"";
            //离组
            dispatch_group_leave(downloadGroup);
        }
    }];
    /*
    [HttpRequest downloadFile:httpuserPhoto baseName:userTakeFaceImageName success:^(id result) {
        if (result) {
            NSData *userData = [NSData dataWithContentsOfFile:result];
            NSString *userBase64String = [userData base64EncodedString];
            item.idcardHand = userBase64String;
            item.mobileIdCardHand = (NSString *)result;
            //离组
            dispatch_group_leave(downloadGroup);
        }
    } failure:^(NSError *error) {
        
    }];
     */
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        // 汇总代码
        [SVProgressHUD dismiss];
        [item uploadThirdInfo:item];
        
    });
}
- (void)reUploadThirdInfo:(ThirdUpLoadItem *)item{
    
    [SVProgressHUD show];
    
    NSMutableDictionary *itemDic = [item mj_keyValues];
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:itemDic];
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/reUploadIdCardPicZx",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            [SVProgressHUD dismiss];
            //更新一下 本地 user 信息
            [self didUpdateSuccess];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];

}
- (void)uploadThirdInfo:(ThirdUpLoadItem *)item{
 
    [SVProgressHUD show];
    
    NSMutableDictionary *itemDic = [item mj_keyValues];
    NSDictionary *tokenDic = [AppUserInfoHelper appendUserIdToken:itemDic];
    
    /*
    if (![item.idcardFront isKindOfClass:[NSNull class]]) {
        [tokenDic setObject:item.idcardFront forKey:@"idcardFront"];
    }
    if (![item.idcardBack isKindOfClass:[NSNull class]]) {
        [tokenDic setObject:item.idcardBack forKey:@"idcardBack"];
    }
    if (![item.idcardHand isKindOfClass:[NSNull class]]) {
        [tokenDic setObject:item.idcardHand forKey:@"idcardHand"];
    }
    if (![item.mobileIdCardFront isKindOfClass:[NSNull class]]) {
        [tokenDic setObject:item.mobileIdCardFront forKey:@"mobileIdCardFront"];
    }
    if (![item.mobileIdCardBack isKindOfClass:[NSNull class]]) {
        [tokenDic setObject:item.mobileIdCardBack forKey:@"mobileIdCardBack"];
    }
    if (![item.mobileIdCardHand isKindOfClass:[NSNull class]]) {
        [tokenDic setObject:item.mobileIdCardHand forKey:@"mobileIdCardHand"];
    }
    //身份证官方照片地址
    if (![item.idcardPhoto isKindOfClass:[NSNull class]]) {
        [tokenDic setObject:item.idcardPhoto forKey:@"idcardPhoto"];
    }
     */
    
    NSString *URL = [NSString stringWithFormat:@"%@/user/thirdSaveUserInfo",kHostURL];
    
    [HttpRequest postWithURLString:URL parameters:tokenDic success:^(id responseObject) {
        if ([responseObject[@"code"] integerValue] == 0) {
            [SVProgressHUD dismiss];
            NSLog(@"上传第三步信息成功");
            //更新一下 本地 user 信息
            [self didUpdateSuccess];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"上传第三步信息错误 %@",error);
    }];
    
}
- (void)didUpdateSuccess{
    
    [LogginHandler shouldUpdateUserInfo:nil success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            [SVProgressHUD dismiss];
            //更新本地数据
            [AppUserInfoHelper updateUserInfo:resultDic];
            [[NSNotificationCenter defaultCenter] postNotificationName:UserInfoUpdateSuccess object:nil];
        }

    } failure:^(NSError *error) {
        
    }];
}

@end
