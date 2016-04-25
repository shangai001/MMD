//
//  HistoryTableViewCell+PutHistoryInfo.m
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "HistoryTableViewCell+PutHistoryInfo.h"
#import "TransferDate.h"
#import "ConstantApplyState.h"



@implementation HistoryTableViewCell (PutHistoryInfo)

- (void)putHistoryInfo:(NSDictionary *)info{
    
    NSString *applyTime = info[@"applyTime"];
    NSString *trasferdTime = [TransferDate getYYYYMMDD_DateWith:[applyTime doubleValue]/1000];
    self.timeLabel.text = trasferdTime;
    
    NSString *amount = [NSString stringWithFormat:@"%@元",info[@"amount"]];
    self.countLabel.text = amount;
    
    NSString *state = info[@"state"];
    NSInteger stateInter = [state integerValue];
    [self setStateInfo:stateInter];
}
- (void)setStateInfo:(NSInteger)stateInter{
    
    /*
     if ([item.state integerValue] == LOAN_AUDIT_FAIL) {
     self.fifthLabel.text = @"审核拒绝";
     }else if ([item.state integerValue] == LAON_AUDIT_CANCLE){
     self.fifthLabel.text = @"审核取消";
     }else if ([item.state integerValue] == LOAN_APPLY_CANCLE){
     self.fifthLabel.text = @"申请已取消";
     }
     */
    NSString *status = @"";
    if (stateInter == LOAN_APPLY_CANCLE) {
        //用户取消审核
        status = @"用户取消审核";
    }
    if (stateInter == LAON_CRANT_FUNDS_SUCCESS) {
        //正常完结
        status = @"已完结";
    }
    if (stateInter == LOAN_AUDIT_FAIL) {
        //审核拒绝
        status = @"审核拒绝";
    }
    if (stateInter == LAON_AUDIT_CANCLE) {
        //审核取消
        status = @"审核取消";
    }
    self.stateLabel.text = status;
}
@end
