//
//  RefundTableViewCell+PutUIinfo.m
//  MMD
//
//  Created by pencho on 16/4/19.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RefundTableViewCell+PutUIinfo.h"
#import "RefundItem.h"
#import "ColorHeader.h"

@implementation RefundTableViewCell (PutUIinfo)

- (void)putItemInfo:(RefundItem *)item{
    
    float repayFloat = [item.repayAmount floatValue];
    NSString *repayAmountString = [NSString stringWithFormat:@"%0.2f元",repayFloat];
    self.repayAmountLabel.text = nil;
    self.repayAmountLabel.attributedText = [self repayAttributedStringWith:repayAmountString];
    
}
- (NSAttributedString *)repayAttributedStringWith:(NSString *)originalString{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:originalString];
    NSInteger lenth = originalString.length;
    //元
    NSRange yuanRange = NSMakeRange(lenth - 1, 1);
    NSDictionary *yuanDic = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor]};
    [attString addAttributes:yuanDic range:yuanRange];
    //.00
    NSRange OORange = NSMakeRange(lenth - 4, 3);
    NSDictionary *ooDic = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:REDCOLOR};
    [attString addAttributes:ooDic range:OORange];
    //129
    NSRange numberRanage = NSMakeRange(0, lenth - 4);
    NSDictionary *numberDic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:REDCOLOR};
    [attString addAttributes:numberDic range:numberRanage];

    return attString;
}
@end
