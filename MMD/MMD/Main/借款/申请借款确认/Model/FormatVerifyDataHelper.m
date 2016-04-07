//
//  FormatVerifyDataHelper.m
//  MMD
//
//  Created by pencho on 16/4/8.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "FormatVerifyDataHelper.h"
#import "ReadFiler.h"
#import "AppUserInfoHelper.h"
#import "LoanInfoItem.h"
#import "CalculateRefund.h"
#import "FormItem.h"

@implementation FormatVerifyDataHelper

+ (NSMutableArray *)formatDatarefundMoth:(NSUInteger)month{
    
    NSArray *originalArray = [ReadFiler readArrayFile:@"LoanVerifySectionTitle" fileType:@"txt"];
    NSMutableArray *baseMutaleArray = [NSMutableArray arrayWithArray:originalArray];
    return baseMutaleArray;
//    NSMutableArray *tempArray = [NSMutableArray array];
    //是最后一个吗
//    if (lastDic.count == 1) {
//        for (NSInteger k = 0; k < month; k ++) {
//            NSString *itemString = [NSString stringWithFormat:@"第%ld期",(long)k + 1];
//            
//        }
//        [baseMutaleArray removeObjectAtIndex:baseMutaleArray.count - 1];
//        [baseMutaleArray addObject:tempArray];
//        return baseMutaleArray;
//    }
    return nil;
}
+ (NSMutableArray *)itemsArrayForVerify:(LoanInfoItem *)item{
    
    NSMutableArray *titleArray = [self formatDatarefundMoth:item.refundMoth];
    NSMutableArray *keyValuesArray = [NSMutableArray arrayWithCapacity:titleArray.count];
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *oneDic = (NSMutableDictionary *)obj;
            NSMutableDictionary *keyValuesDic = [self findValueForkey:oneDic item:item];
            [keyValuesArray addObject:keyValuesDic];
        }
    }];
    NSLog(@"找补完 ---> %@",keyValuesArray);
    return titleArray;
}
+ (NSMutableDictionary *)findValueForkey:(NSMutableDictionary *)dic item:(LoanInfoItem *)item{
    
    
    NSDictionary *userInfo = [AppUserInfoHelper userInfo];
    NSDictionary *userBank = [AppUserInfoHelper userBank];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"借款人"]) {
            NSString *userName = userInfo[@"name"];
            [tempDic setObject:userName forKey:key];
        }
        if ([key isEqualToString:@"身份证"]) {
            [tempDic setObject:userInfo[@"idcard"] forKey:key];
        }
        if ([key isEqualToString:@"银行卡"]) {
            [tempDic setObject:userBank[@"bankCard"] forKey:key];
        }
        if ([key isEqualToString:@"开户银行"]) {
            NSString *bankAdress = [NSString stringWithFormat:@"%@%@%@",userBank[@"province"],userBank[@"city"],userBank[@"area"]];
            [tempDic setObject:bankAdress forKey:key];
        }
        if ([key isEqualToString:@"借款金额"]) {
            NSString *loanFloatString = [NSString stringWithFormat:@"%0.2f元",item.floatLoanMoney];
            [tempDic setObject:loanFloatString forKey:key];
        }
        if ([key isEqualToString:@"借款期限"]) {
            NSString *time = [NSString stringWithFormat:@"%ld个月",(long)item.refundMoth];
            [tempDic setObject:time forKey:key];
        }
        if ([key isEqualToString:@"综合管理费"]) {
            float manageMent = [CalculateRefund manageMentMoney];
            float totalManageMent = manageMent * item.refundMoth;
            NSString *totalString = [NSString stringWithFormat:@"%0.2f元",totalManageMent];
            [tempDic setObject:totalString forKey:key];
        }
        if ([key isEqualToString:@"月管理费"]) {
            float manageMent = [CalculateRefund manageMentMoney];
            NSString *singleString = [NSString stringWithFormat:@"%0.2f元",manageMent];
            [tempDic setObject:singleString forKey:key];
        }
        if ([key isEqualToString:@"实际到账金额"]) {
            float actualMoney = [CalculateRefund getActualMoney:item.floatLoanMoney];
            NSString *actualString = [NSString stringWithFormat:@"%0.2f元",actualMoney];
            [tempDic setObject:actualString forKey:key];
        }
        if ([key isEqualToString:@"还款方式"]) {
            NSString *refundWay = @"等额本息 按期还款";
            [tempDic setObject:refundWay forKey:key];
        }
    }];
    NSLog(@"找到值的字典 %@",tempDic);
    return tempDic;
}
+ (NSMutableArray *)ez_itemsArrayForVerify:(LoanInfoItem *)item{
    NSMutableArray *data = [self itemsArrayForVerify:item];
    NSMutableArray *itemsArray  = [NSMutableArray array];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *oneDic = (NSDictionary *)obj;
            [oneDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                FormItem *formItem = [FormItem new];
                formItem.pTitle = key;
                formItem.detailText = obj;
                [itemsArray addObject:formItem];
            }];
        }
    }];
    return itemsArray;
}
@end
