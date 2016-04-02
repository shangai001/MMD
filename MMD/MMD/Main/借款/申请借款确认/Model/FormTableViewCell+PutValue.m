//
//  FormTableViewCell+PutValue.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "FormTableViewCell+PutValue.h"
#import "FormItem.h"

@implementation FormTableViewCell (PutValue)

- (void)putValue:(FormItem *)item{
    self.titleLabel.text = item.pTitle;
    self.detailLabel.text = item.detailText;
}

@end
