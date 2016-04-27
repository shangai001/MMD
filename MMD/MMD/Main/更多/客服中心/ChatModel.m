//
//  ChatModel.m
//  MMD
//
//  Created by pencho on 16/4/27.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ChatModel.h"
#import "UUMessage.h"
#import "UUMessageFrame.h"


@implementation ChatModel


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource  = [NSMutableArray array];
    }
    return _dataSource;
}

static NSString *previousTime = nil;
// 添加聊天item（一个cell内容）
- (void)addSpecifiedItem:(NSDictionary *)dic{
    
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
    UUMessage *message = [[UUMessage alloc] init];
    message.type = UUMessageTypeText;
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    if ([dic[@"type"] integerValue] == 0) {
        
        [dataDic setObject:@(UUMessageFromMe) forKey:@"from"];
        
    }else if ([dic[@"type"] integerValue] == 1){
        
        [dataDic setObject:@"米米贷客服" forKey:@"strName"];
        [dataDic setObject:@(UUMessageFromOther) forKey:@"from"];
    }
    NSString *content = dic[@"content"];
    [dataDic setObject:content forKey:@"strContent"];
    
    NSString *messageTime = dic[@"createTimeStr"];
    [dataDic setObject:messageTime forKey:@"strTime"];
    
    [message setWithDict:dataDic];
    [message minuteOffSetStart:previousTime end:dataDic[@"strTime"]];
    
    messageFrame.showTime = message.showDateLabel = YES;
    [messageFrame setMessage:message];
    
    if (message.showDateLabel) {
        previousTime = dataDic[@"strTime"];
    }
    [self.dataSource addObject:messageFrame];

}

@end
