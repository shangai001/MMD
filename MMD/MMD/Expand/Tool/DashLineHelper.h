//
//  DashLineHelper.h
//  MMD
//
//  Created by pencho on 16/3/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DashLineHelper : NSObject

+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
@end
