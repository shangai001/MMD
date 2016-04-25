//
//  UIViewController+LoadFromNib.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "UIViewController+LoadFromNib.h"

@implementation UIViewController (LoadFromNib)

+ (instancetype)loadFromNib{
    
    return [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

@end
