//
//  LoggoutTableViewCell.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoggoutTableViewCell.h"
#import "BaseNextButton.h"
#import "ColorHeader.h"

@implementation LoggoutTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.logoutButton.backgroundColor = REDCOLOR;
    
}
- (IBAction)logout:(BaseNextButton *)sender {
    if (self.logouHandler) {
        self.logouHandler();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
