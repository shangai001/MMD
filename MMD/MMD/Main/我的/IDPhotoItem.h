//
//  IDPhotoItem.h
//  MMD
//
//  Created by pencho on 16/4/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPhotoItem : NSObject

@property (nonatomic, copy)NSString *cardHandUrl;
@property (nonatomic, copy)NSString *cardBackUrl;
@property (nonatomic, copy)NSString *cardFrontUrl;

@property (nonatomic, copy)NSString *state;

@end
