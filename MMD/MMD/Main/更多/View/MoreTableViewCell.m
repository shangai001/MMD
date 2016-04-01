//
//  MoreTableViewCell.m
//  moreTest
//
//  Created by pencho on 16/3/31.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MoreTableViewCell.h"
#import "AppInfo.h"

@implementation MoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)addVersionLabelAfterHideGoButton{
    UIButton *button = self.goButton;
    self.goButton.hidden = YES;
    CGRect buttonFrame = button.frame;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(buttonFrame.origin.x - 20, buttonFrame.origin.y, buttonFrame.size.width, buttonFrame.size.height)];
    label.text = [AppInfo app_Version];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:label];
}
@end
