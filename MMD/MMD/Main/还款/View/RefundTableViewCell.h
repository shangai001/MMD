//
//  RefundTableViewCell.h
//  MMD
//
//  Created by pencho on 16/4/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,kCelltype) {
    kRefundType = 0,
    kDidRefundType
};

@interface RefundTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *repayAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *rightBackView;

@property kCelltype cellType;
@property (nonatomic, strong)UIColor *typeColor;//(0.42,0.78,0.52-G)---(0.90,0.24,0.10---R)

@end
