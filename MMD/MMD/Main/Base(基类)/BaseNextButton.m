//
//  BaseNextButton.m
//  MMD
//
//  Created by pencho on 16/4/10.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseNextButton.h"

@implementation BaseNextButton


- (instancetype)init{
    self = [super init];
    if (self) {
        [self customInitialize];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInitialize];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInitialize];
    }
    return self;
}
//initialize
- (void)customInitialize{
    
    self.layer.cornerRadius = 10.0f;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
