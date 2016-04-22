//
//  PostRepayController.h
//  MMD
//
//  Created by pencho on 16/4/21.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface PostRepayController : BaseViewController
//是否可以拍照
@property (assign, nonatomic)BOOL albumOptional;
@property (copy, nonatomic)NSString *repayId;

@end
