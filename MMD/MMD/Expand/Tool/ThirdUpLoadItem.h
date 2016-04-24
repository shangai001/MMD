//
//  ThirdUpLoadItem.h
//  MMD
//
//  Created by pencho on 16/4/13.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXMemberDetail;

@interface ThirdUpLoadItem : NSObject

//Base64
@property (copy, nonatomic)NSString *idcardHand;
@property (copy, nonatomic)NSString *idcardFront;
@property (copy, nonatomic)NSString *idcardBack;

//储存路径
@property (copy, nonatomic)NSString *mobileIdCardHand;
@property (copy, nonatomic)NSString *mobileIdCardBack;
@property (copy, nonatomic)NSString *mobileIdCardFront;

/**
 *  身份证官方照片
 */
@property (copy,nonatomic)NSString *idcardPhoto;

@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *idcard;
@property (copy,nonatomic)NSString *address;

/**
 *  第三步上传真信数据
 *
 *  @param detail
 */
- (void)downloadImagesWith:(ZXMemberDetail *)detail;
/**
 *  重新更改持证拍照信息
 *
 *  @param detail 
 */
- (void)reDownloadImagesWith:(ZXMemberDetail *)detail;


@end
