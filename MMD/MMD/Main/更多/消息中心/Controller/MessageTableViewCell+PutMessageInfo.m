//
//  MessageTableViewCell+PutMessageInfo.m
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MessageTableViewCell+PutMessageInfo.h"
//#import "MessageItem.h"
#import "TransferDate.h"


@implementation MessageTableViewCell (PutMessageInfo)

- (void)setMessage:(NSDictionary *)itemDic{
    
    self.titleLabel.text = itemDic[@"title"];
    self.contentLabel.text = itemDic[@"content"];
    
//    NSString *type = itemDic[@"type"];
    self.fromLabel.text = @"推送";
    
    NSInteger sendTime = [itemDic[@"sendTime"] integerValue]/1000;
    NSString *transferdTime = [TransferDate getYYYYMMDD_DateWith:sendTime];
    self.timeLabel.text = transferdTime;
    
}
@end
