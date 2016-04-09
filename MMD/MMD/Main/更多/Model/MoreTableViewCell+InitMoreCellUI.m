//
//  MoreTableViewCell+InitMoreCellUI.m
//  MMD
//
//  Created by pencho on 16/4/4.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MoreTableViewCell+InitMoreCellUI.h"
#import "MoreCellUIItem.h"

@implementation MoreTableViewCell (InitMoreCellUI)


- (void)putMoreUIValue:(MoreCellUIItem *)item{
    self.iconImageView.image = [UIImage imageNamed:item.imageName];
    self.titleLabel.text = item.title;
}

@end
