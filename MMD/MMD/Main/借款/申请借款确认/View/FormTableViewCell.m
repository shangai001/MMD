//
//  FormTableViewCell.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "FormTableViewCell.h"

@implementation FormTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.5f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
