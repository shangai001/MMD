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


//front_imgUrl 身份证整体照片
//back_imgUrl 身份证背面照片
//faceImgUrl1 人脸识别照片

static NSString * const frontIDImageName = @"frontIDImage";
static NSString * const backIDImageName = @"backIDImage";
static NSString * const userTakeFaceImageName = @"userTakeImage";

@implementation ThirdUpLoadItem

- (void)downloadImagesWith:(ZXMemberDetail *)detail{
    
    NSLog(@"穿过来的值  %@",detail);
    ZXIDcardModel *idModel = detail.idcardModel;
    __block ThirdUpLoadItem *item = [ThirdUpLoadItem new];
    
    
    NSString *userPhoto = idModel.front_faceImgUrl_user;
    NSString *frontIDUrl = idModel.front_imgUrl;
    NSString *backIDUrl = idModel.back_imgUrl;
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    //进组
    dispatch_group_enter(downloadGroup);
    [HttpRequest downloadFile:frontIDUrl baseName:frontIDImageName success:^(id result) {
        if (result) {
            NSData *frontData = [NSData dataWithContentsOfFile:result];
            NSString *frontBase64String = [frontData base64EncodedString];
            item.idcardFront = frontBase64String;
            item.mobileIdCardFront = (NSString *)result;
            dispatch_group_leave(downloadGroup);
        }
    } failure:^(NSError *error) {
        
    }];
    //进组
    dispatch_group_enter(downloadGroup);
    [HttpRequest downloadFile:backIDUrl baseName:backIDUrl success:^(id result) {
        if (result) {
            NSData *backData = [NSData dataWithContentsOfFile:result];
            NSString *backBase64String = [backData base64EncodedString];
            item.idcardBack = backBase64String;
            item.mobileIdCardBack = (NSString *)result;
            dispatch_group_leave(downloadGroup);
        }
    } failure:^(NSError *error) {
        
    }];
    //进组
    dispatch_group_enter(downloadGroup);
    [HttpRequest downloadFile:userPhoto baseName:userTakeFaceImageName success:^(id result) {
        if (result) {
            NSData *userData = [NSData dataWithContentsOfFile:result];
            NSString *userBase64String = [userData base64EncodedString];
            item.idcardHand = userBase64String;
            item.mobileIdCardHand = (NSString *)result;
            dispatch_group_leave(downloadGroup);
        }
    } failure:^(NSError *error) {
        
    }];
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        // 汇总代码
        NSLog(@"item 属性 %@",item);
        
    });
    

    
}

@end
