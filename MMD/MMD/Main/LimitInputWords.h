//
//  LimitInputWords.h
//  MMD
//
//  Created by pencho on 16/3/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LimitInputWords : NSObject

+ (void)limitInputText:(UITextField *)textField textCount:(NSUInteger)count;

@end
