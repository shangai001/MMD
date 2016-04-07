//
//  CalculateRefund.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "CalculateRefund.h"
//#import <MJExtension.h>

@implementation CalculateRefund

+ (NSString *)interestFilePath{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"InterestFile" ofType:@"text"];
    return path;
}
+ (NSDictionary *)interestDictionary{
    
    
    NSString *path = [self interestFilePath];
    NSError *error = nil;
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"解析出来的字典是 %@  蚊子 %@",dic,text);
    return dic;
}

+ (NSUInteger)calculateRefundWithNumber:(NSUInteger)loanNumber time:(NSUInteger)month{
    
    NSUInteger refundNumber =  loanNumber * (1 + 0.8 + month * 0.1);
    return refundNumber;
}

@end
