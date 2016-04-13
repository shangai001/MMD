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
#import "BottomItem.h"


@implementation FormatVerifyDataHelper

+ (NSArray *)formatDatarefundMoth:(NSUInteger)month{
    
    NSArray *originalArray = [ReadFiler readArrayFile:@"LoanVerifySectionTitle" fileType:@"txt"];
    return originalArray;
}
//够造数组<字典>
+ (NSArray *)itemsArrayForVerify:(LoanInfoItem *)item{
    
    NSArray *titleArray = [self formatDatarefundMoth:item.refundMoth];
    __block NSMutableArray *keyValuesArray = [NSMutableArray arrayWithCapacity:titleArray.count];
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *oneDic = (NSMutableDictionary *)obj;
            NSDictionary *keyValuesDic = [self findValueForkey:oneDic item:item];
            [keyValuesArray addObject:keyValuesDic];
        }
    }];
    return keyValuesArray;
}

+ (NSMutableDictionary *)findValueForkey:(NSMutableDictionary *)dic item:(LoanInfoItem *)item{
    
    NSDictionary *userInfo = [AppUserInfoHelper userInfo];
    NSDictionary *userBank = [AppUserInfoHelper userBank];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"借款人"]) {
            NSString *userName = userInfo[@"name"];
            [self setNonullObject:userName Forkey:key inDic:tempDic];
        }
        if ([key isEqualToString:@"身份证"]) {
            [self setNonullObject:userInfo[@"idcard"] Forkey:key inDic:tempDic];
        }
        if ([key isEqualToString:@"银行卡"]) {
            [self setNonullObject:userBank[@"bankCard"] Forkey:key inDic:tempDic];
        }
        if ([key isEqualToString:@"开户银行"]) {
            NSString *bankAdress = [NSString stringWithFormat:@"%@%@%@",userBank[@"province"],userBank[@"city"],userBank[@"area"]];
            [self setNonullObject:bankAdress Forkey:key inDic:tempDic];
        }
        if ([key isEqualToString:@"借款金额"]) {
            NSString *loanFloatString = [NSString stringWithFormat:@"%0.2f元",item.floatLoanMoney];
            [self setNonullObject:loanFloatString Forkey:key inDic:tempDic];
        }
        if ([key isEqualToString:@"借款期限"]) {
            NSString *time = [NSString stringWithFormat:@"%ld个月",(long)item.refundMoth];
            [self setNonullObject:time Forkey:key inDic:tempDic];
        }
        if ([key isEqualToString:@"综合管理费"]) {
            float manageMent = [CalculateRefund manageMentMoney];
            float totalManageMent = manageMent * item.refundMoth;
            NSString *totalString = [NSString stringWithFormat:@"%0.2f元",totalManageMent];
            [self setNonullObject:totalString Forkey:key inDic:tempDic];
        }
        if ([key isEqualToString:@"月管理费"]) {
            float manageMent = [CalculateRefund manageMentMoney];
            NSString *singleString = [NSString stringWithFormat:@"%0.2f元",manageMent];
            [self setNonullObject:singleString Forkey:key inDic:tempDic];
        }
        if ([key isEqualToString:@"实际到账金额"]) {
            float actualMoney = [CalculateRefund getActualMoney:item.floatLoanMoney];
            NSString *actualString = [NSString stringWithFormat:@"%0.2f元",actualMoney];
            [self setNonullObject:actualString Forkey:key inDic:tempDic];
        }
        if ([key isEqualToString:@"还款方式"]) {
            NSString *refundWay = @"等额本息 按期还款";
            [self setNonullObject:refundWay Forkey:key inDic:tempDic];
        }
    }];
    return [tempDic mutableCopy];
}
+ (void)setNonullObject:(id)object Forkey:(NSString *)key inDic:(NSMutableDictionary *)tempDic{
    
    //非空判断
    if (![object isKindOfClass:[NSNull class]]) {
        [tempDic setObject:object forKey:key];
    }
}
+ (NSMutableArray *)ez_itemsArrayForVerify:(LoanInfoItem *)item{
    
    NSArray *data = [self itemsArrayForVerify:item];
    NSLog(@"字典数组是  ---> %@ ",data);
    
    NSMutableArray *fullArray = [NSMutableArray array];
    [[self itemsArrayForVerify:item] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *oneDic = (NSDictionary *)obj;
            NSMutableArray *sectionArray = [self makeupOneSectionArray:oneDic];
            [fullArray addObject:sectionArray];
        }
    }];
    [self sortedArray:fullArray];
    return [fullArray mutableCopy];
}
+ (NSMutableArray *)makeupOneSectionArray:(NSDictionary *)onedic{
    NSMutableArray *sectionArray  = [NSMutableArray array];
    [onedic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        FormItem *formItem = [FormItem new];
        formItem.pTitle = key;
        formItem.detailText = obj;
        [self setSortId:key forItem:formItem];
        [sectionArray addObject:formItem];
    }];
    return sectionArray;
}
+ (void)setSortId:(NSString *)key forItem:(FormItem *)item{
    NSDictionary *sortInfo = [ReadFiler readDictionaryFile:@"SortIdDic" fileType:@"txt"];
    NSNumber *sortId = sortInfo[key];
    item.sortId = sortId;
}
+ (NSMutableArray *)ez_bottomItemArrayForBottomCell:(LoanInfoItem *)item{
    
    NSMutableArray *boItemArray = [NSMutableArray array];
    float refundMoney = [CalculateRefund calculateRefundWith:item];
    for (NSInteger k = 0; k < item.refundMoth + 1; k++) {
        BottomItem *boItem = [BottomItem new];
        if (k == 0) {
            boItem.refundIndexMonth = @"还款期数";
            boItem.refundMoneyString = @"还款金额";
            boItem.timeLine = @"到期还款日";
        }else{
            NSString *indexMoth = [NSString stringWithFormat:@"第%ld期",(long)k];
            boItem.refundIndexMonth = indexMoth;
            boItem.refundMoneyString= [NSString stringWithFormat:@"%0.2f元",refundMoney];
            boItem.timeLine = [NSString stringWithFormat:@"%ld个月后",(long)k];
        }
        [boItemArray addObject:boItem];
    }
    return boItemArray;
}
+ (void)sortedArray:(NSMutableArray *)itemArray{
    
    for (NSMutableArray *childArray in itemArray) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sortId" ascending:YES];
        [childArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    }
    
}
@end
