//
//  RefundHeaderView.h
//  MMD
//
//  Created by pencho on 16/4/14.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIButton *shouldRefundButton;
@property (weak, nonatomic) IBOutlet UIButton *alreadyRefundButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewCenterX;
@property (assign, nonatomic)NSInteger selectedIndex;
@property (copy, nonatomic)void(^SwitchBlock)(NSInteger index);
@end
