//
//  HeaderLabel.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "HeaderLabel.h"
#define LABEL_WIDTH 150
#define LABEL_HEIGHT 30


@implementation HeaderLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (UILabel *)initHeaderLabel{
    
//    UILabel *headerLabel = [UILabel new];
//    headerLabel.font = [UIFont systemFontOfSize:15];
//    headerLabel.textAlignment = NSTextAlignmentLeft;
//    headerLabel.textColor = [UIColor blackColor];
//    headerLabel.frame = CGRectMake(0, 0, LABEL_WIDTH, LABEL_HEIGHT);
//    return headerLabel;
    return [self initHeaderLabel:CGSizeMake(LABEL_WIDTH, LABEL_HEIGHT)];
}
+ (UILabel *)initHeaderLabel:(CGSize)size{
    
    UILabel *headerLabel = [UILabel new];
    headerLabel.font = [UIFont systemFontOfSize:15];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textColor = [UIColor redColor];
    headerLabel.frame = CGRectMake(0, 0, size.width, size.height);
    return headerLabel;
}
@end
