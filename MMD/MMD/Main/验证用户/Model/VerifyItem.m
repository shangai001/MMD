//
//  VerifyItem.m
//  MMD
//
//  Created by pencho on 16/3/30.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "VerifyItem.h"

@implementation VerifyItem

- (NSString *)description{
    NSString *des = [NSString stringWithFormat:@"cardNum=%@,bank=%@,city=%@,contactNum=%@,contactName=%@,contactRealtionship=%@",self.cardNum,self.bank,self.city,self.contactNum,self.contactName,self.contactRealtionship];
    return des;
}

@end
