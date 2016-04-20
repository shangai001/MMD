//
//  RefundTableViewCell.m
//  MMD
//
//  Created by pencho on 16/4/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RefundTableViewCell.h"
#import "ColorHeader.h"

@implementation RefundTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor =[REDCOLOR CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
