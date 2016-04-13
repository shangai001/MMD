//
//  ThirdUpLoadItem.m
//  MMD
//
//  Created by pencho on 16/4/13.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ThirdUpLoadItem.h"
#import "ZXMemberDetail.h"
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

- (NSString *)replaceHttpsString:(NSString *)originalString{
    
    originalString = [originalString stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
    originalString = [originalString stringByReplacingOccurrencesOfString:@"9527" withString:@"80"];
    return originalString;
}
- (void)downloadImagesWith:(ZXMemberDetail *)detail{
    
    [SVProgressHUD show];
    NSLog(@"穿过来的值  %@",detail);
    ZXIDcardModel *idModel = detail.idcardModel;
    __block ThirdUpLoadItem *item = [ThirdUpLoadItem new];
    
    
    NSString *userPhoto = idModel.front_faceImgUrl_user;
    NSString *frontIDUrl = idModel.front_imgUrl;
    NSString *backIDUrl = idModel.back_imgUrl;
    
    NSString *httpuserPhoto = [self replaceHttpsString:userPhoto];
    NSString *httpfrontIDUrl = [self replaceHttpsString:frontIDUrl];
    NSString *httpbackIDUrl = [self replaceHttpsString:backIDUrl];
    NSLog(@"三个 URL 分别是 %@ %@ %@",httpuserPhoto,httpfrontIDUrl,httpbackIDUrl);
    
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    //进组
    dispatch_group_enter(downloadGroup);
    [HttpRequest downloadFile:httpfrontIDUrl baseName:frontIDImageName success:^(id result) {
        if (result) {
            NSData *frontData = [NSData dataWithContentsOfFile:result];
            NSString *frontBase64String = [frontData base64EncodedString];
            item.idcardFront = frontBase64String;
            item.mobileIdCardFront = (NSString *)result;
            //离组
            dispatch_group_leave(downloadGroup);
        }
    } failure:^(NSError *error) {
        
    }];
    //进组
    dispatch_group_enter(downloadGroup);
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
    //进组
    dispatch_group_enter(downloadGroup);
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
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        // 汇总代码
        [SVProgressHUD dismiss];
        NSLog(@"item 属性 %@",item);
        [item uploadThirdInfo:item];
        
    });
}
- (void)uploadThirdInfo:(ThirdUpLoadItem *)item{
 
    [SVProgressHUD show];
    
    NSMutableDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
    
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
            EZLog(@"更新用户信息成功");
            [[NSNotificationCenter defaultCenter] postNotificationName:UserInfoUpdateSuccess object:nil];
        }

    } failure:^(NSError *error) {
        EZLog(@"更新登录错误 %@",error);
    }];
}

@end
