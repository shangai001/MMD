//
//  TrasferMessageDic.m
//  MMD
//
//  Created by pencho on 16/4/27.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "TrasferMessageDic.h"

@implementation TrasferMessageDic

+ (NSDictionary *)trasferMessage:(NSDictionary *)oldMessage{
    
    NSDictionary *ziDic = @{@"content":@"直接的测试",
                                   @"createTime":@(1461737757000),
                                   @"createTimeStr":@"2016-04-27 14:15:57",
                                   @"customerService":@"",
                                   @"customerServiceId":@(6280),
                                   @"type":@(1),
                                   @"userId":@"1"};
    
    return ziDic;
}

@end
