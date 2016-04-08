//
//  BottomTableViewCell.m
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BottomTableViewCell.h"

@implementation BottomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
