//
//  FormTableViewCell+PutValue.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "FormTableViewCell+PutFormValue.h"
#import "FormItem.h"

@implementation FormTableViewCell (PutFormValue)

- (void)putTitleValue:(FormItem *)item{
    self.titleLabel.text = item.pTitle;
    self.detailLabel.text = item.detailText;
    NSLog(@"排序后的sortId = %@",item.sortId);
}

@end
