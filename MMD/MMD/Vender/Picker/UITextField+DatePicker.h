//
//  UITextField+DatePicker.h
//  Sjyr_ERP
//
//  Created by tujinqiu on 15/11/28.
//  Copyright © 2015年 mysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (DatePicker)

@property (nonatomic, assign) BOOL datePickerInput;
@property (nonatomic, strong)NSDate *maxDate;

+ (UIDatePicker *)sharedDatePicker;
//获取默认时间
- (void)getDefaultRightDate;
@end
