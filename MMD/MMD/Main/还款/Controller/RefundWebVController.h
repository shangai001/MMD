//
//  RefundWebVController.h
//  MMD
//
//  Created by pencho on 16/4/20.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseWebViewController.h"

typedef NS_ENUM(NSInteger,kDetailType) {
    kRefundDetailType= 0,
    kDidRefundDetailType
};

@interface RefundWebVController : BaseWebViewController

@property kDetailType detaiType;


@end
