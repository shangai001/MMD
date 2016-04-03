//
//  MoreTableViewCell+MineUIInfo.m
//  MMD
//
//  Created by pencho on 16/4/4.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MoreTableViewCell+MineUIInfo.h"
#import "MoreCellUIItem.h"

@implementation MoreTableViewCell (MineUIInfo)

- (void)putValue:(MoreCellUIItem *)item{
    
    self.iconImageView.image = [UIImage imageNamed:item.imageName];
    self.titleLabel.text = item.title;
}
@end
