//
//  TransferDate.h
//  MMD
//
//  Created by pencho on 16/4/20.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferDate : NSObject

/**
 *  根据时间戳换算成现在的时间,注意interval单位 s
 *
 *  @param interval 秒
 *
 *  @return 
 */
+ (NSString *)getYYYYMMDD_DateWith:(NSTimeInterval)interval;
+ (NSString *)getYYYYMMDDHHMMSS_DateWith:(NSTimeInterval)interval;

@end
