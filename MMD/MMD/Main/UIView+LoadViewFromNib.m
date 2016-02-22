//
//  UIView+LoadViewFromNib.m
//  PAI2.0
//
//  Created by pencho on 15/10/21.
//  Copyright © 2015年 pencho. All rights reserved.
//

#import "UIView+LoadViewFromNib.h"

@implementation UIView (LoadViewFromNib)

+ (instancetype)loadViewFromNib{
    NSArray *elements = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    for (id object in elements) {
        if ([object isKindOfClass:self]) {
            return object;
        }
    }
    return nil;
}
@end
