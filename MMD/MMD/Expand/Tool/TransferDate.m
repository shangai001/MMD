//
//  TransferDate.m
//  MMD
//
//  Created by pencho on 16/4/20.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "TransferDate.h"

@implementation TransferDate

+ (NSString *)getYYYYMMDD_DateWith:(NSTimeInterval)interval{
    if (interval != 0) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        NSTimeZone *tZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:tZone];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeString =[formatter stringFromDate:date];
        return timeString;
    }
    return nil;
}

@end
