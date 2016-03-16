//
//  StageView.h
//  MMD
//
//  Created by pencho on 16/3/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,kDirectionStyle) {
    kHorizontalStyle,
    kverticalTypeStyle
};
@interface StageView : UIView

- (instancetype)initWithStyle:(kDirectionStyle)style stage:(NSUInteger)stage frame:(CGRect)frame;
//stage:几个button
- (void)updateProsess:(NSUInteger)stage;

@end
