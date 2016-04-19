//
//  RefundTableViewCell.h
//  MMD
//
//  Created by pencho on 16/4/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *repayAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *rightBackView;

@end
