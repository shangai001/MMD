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

@property (copy, nonatomic)NSString *mobileIdCardHand;
@property (copy, nonatomic)NSString *mobileIdCardBack;
@property (copy, nonatomic)NSString *mobileIdCardFront;


- (void)downloadImagesWith:(ZXMemberDetail *)detail;


@end
