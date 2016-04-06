//
//  VerifyViewController.h
//  MMD
//
//  Created by pencho on 16/3/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//


#import "BaseViewController.h"

@class VerifyItem;

@interface VerifyViewController : BaseViewController

@property (nonatomic,copy)VerifyItem *item;
@property (nonatomic,assign)NSInteger status;

@end
