//
//  FormatVerifyDataHelper.m
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "FormatVerifyDataHelper.h"
#import "ReadFiler.h"

@implementation FormatVerifyDataHelper

+ (NSMutableArray *)formatDatarefundMoth:(NSUInteger)month{
    
    NSArray *originalArray = [ReadFiler readArrayFile:@"LoanVerifySectionTitle" fileType:@"txt"];
    NSMutableArray *baseMutaleArray = [NSMutableArray arrayWithArray:originalArray];
    NSArray *lastArray = [baseMutaleArray lastObject];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    //是最后一个吗
    if (lastArray.count == 1) {
        for (NSInteger k = 0; k < month; k ++) {
            NSString *itemString = [NSString stringWithFormat:@"第%ld期",(long)k + 1];
            [tempArray addObject:itemString];
        }
        [baseMutaleArray removeObjectAtIndex:baseMutaleArray.count - 1];
        [baseMutaleArray addObject:tempArray];
        return baseMutaleArray;
    }
    return nil;
}
+ (NSMutableArray *)itemsArrayForVerify:(NSUInteger)month{
    
    NSMutableArray *titleArray = [self formatDatarefundMoth:month];
    
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            
        }
    }];
    
    return nil;
}
@end
