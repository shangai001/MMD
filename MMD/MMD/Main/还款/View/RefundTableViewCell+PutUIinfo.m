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
#import "TransferDate.h"


@implementation RefundTableViewCell (PutUIinfo)

- (void)putItemInfo:(RefundItem *)item{
    
    self.layer.cornerRadius = 10.0f;
    
    [self makeSureTypeColor];
    [self setRepayAmountInfo:item];
    [self setOverDueInfo:item];
    [self setNumberInfo:item];
    [self setRefundTimeInfo:item];
}
//确定主题颜色
- (void)makeSureTypeColor{
    if (self.cellType == kRefundType) {
        self.typeColor = Color(0.90, 0.24, 0.10, 1);
    }else if (self.cellType == kDidRefundType){
        self.typeColor = Color(0.42, 0.78, 0.52, 1);
    }else{
        self.typeColor = REDCOLOR;
    }
    self.rightBackView.backgroundColor = self.typeColor;
}
//设置数字文字
- (void)setRepayAmountInfo:(RefundItem *)item{
    float repayFloat = [item.repayTotal floatValue];
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
    NSDictionary *numberDic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:self.typeColor};
    [attString addAttributes:numberDic range:numberRanage];
    return attString;
}
//是否逾期
- (void)setOverDueInfo:(RefundItem *)item{
    
    self.repayStatusLabel.textColor = self.typeColor;
    NSString *string = @"";
    if (self.cellType == kRefundType) {
        if (item.overdue && [item.overdue integerValue] > 0) {
            string = [NSString stringWithFormat:@"已逾期%@天",item.overdue];
        }else{
            string = @"未逾期";
        }
    }else if (self.cellType == kDidRefundType){
        if (item.overdue && [item.overdue integerValue] > 0) {
            string = [NSString stringWithFormat:@"已还款，逾期%@天",item.overdue];
        }else{
            string = @"已还款，未逾期";
        }
    }
    self.repayStatusLabel.text = string;
    
}
//设置第几期
- (void)setNumberInfo:(RefundItem *)item{
    
    self.NumberLabel.text = [NSString stringWithFormat:@"第%@期",item.term];
    self.NumberLabel.textColor = [UIColor blackColor];
}
//设置还款时间
- (void)setRefundTimeInfo:(RefundItem *)item{
    
    NSString *date = [TransferDate getYYYYMMDD_DateWith:[item.playdate doubleValue]/1000];
    self.repayTimeLabel.text = date;
    self.repayTimeLabel.textColor = [UIColor blackColor];
}
@end
