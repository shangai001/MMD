//
//  ThirdStepController.h
//  MMD
//
//  Created by pencho on 16/3/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//


#import "BaseViewController.h"
@class BaseNextButton;

@interface ThirdStepController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet BaseNextButton *nextButton;

@end
