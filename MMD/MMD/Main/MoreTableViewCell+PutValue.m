//
//  MoreTableViewCell+PutValue.m
//  MMD
//
//  Created by pencho on 16/3/31.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MoreTableViewCell+PutValue.h"
#import "MoreItem.h"

@implementation MoreTableViewCell (PutValue)

- (void)putValue:(MoreItem *)item{
    NSLog(@"item.imageName = %@ title = %@",item.imageName,item.title);
    self.iconImageView.image = [UIImage imageNamed:item.imageName];
    self.titleLabel.text = item.title;
}
@end
