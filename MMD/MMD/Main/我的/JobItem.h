//
//  JobItem.h
//  MMD
//
//  Created by pencho on 16/4/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobItem : NSObject

@property (copy, nonatomic)NSString *jobkey;
@property (copy, nonatomic)NSString *adress;
@property (copy, nonatomic)NSString *phone;
@property (copy, nonatomic)NSString *compangy;
@property (copy, nonatomic)NSString *province;
@property (copy, nonatomic)NSString *city;
@property (copy, nonatomic)NSString *area;

@end
