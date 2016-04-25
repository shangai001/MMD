//
//  AttachmentTableViewCell+PutUIInfo.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "AttachmentTableViewCell+PutUIInfo.h"

@implementation AttachmentTableViewCell (PutUIInfo)

- (void)putUIInfo:(NSDictionary *)info{
    
    self.titleLabel.text = info[@"title"];
    
    NSString *state = info[@"state"];
    NSString *statusString = @"";
    
    if ([state isEqualToString:@"0"]) {
        statusString = @"未审核";
    }else if ([state isEqualToString:@"1"]){
        statusString = @"未通过审核";
    }else if ([state isEqualToString:@"2"]){
        statusString = @"已通过审核";
    }
    self.statusLabel.text = statusString;
}

@end
