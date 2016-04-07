//
//  SecondStaepController.h
//  MMD
//
//  Created by pencho on 16/3/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface SecondStaepController : BaseViewController


@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *bseScrollView;
@property (weak, nonatomic) IBOutlet UITextField *maritalStatusField;
@property (weak, nonatomic) IBOutlet UITextField *childField;
@property (weak, nonatomic) IBOutlet UITextField *lifeRadius;
@property (weak, nonatomic) IBOutlet UITextField *careerField;
@property (weak, nonatomic) IBOutlet UITextField *compangyName;
@property (weak, nonatomic) IBOutlet UITextField *compangyCityField;
@property (weak, nonatomic) IBOutlet UITextField *compangyAddressField;
@property (weak, nonatomic) IBOutlet UITextField *companyPhoneNum;


@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@end
