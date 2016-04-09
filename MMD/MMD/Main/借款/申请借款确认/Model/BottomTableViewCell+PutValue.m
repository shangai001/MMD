//
//  BottomTableViewCell+PutValue.m
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BottomTableViewCell+PutValue.h"
#import "BottomItem.h"

@implementation BottomTableViewCell (PutValue)

- (void)putLabelValue:(BottomItem *)item{
    self.leftLabel.text = item.refundIndexMonth;
    self.middleLabel.text = item.refundMoneyString;
    self.rightLabel.text = item.timeLine;
}

@end
