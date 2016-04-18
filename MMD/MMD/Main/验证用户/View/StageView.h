//
//  StageView.h
//  MMD
//
//  Created by pencho on 16/3/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StageDirectionHeader.h"


@interface StageView : UIView

- (instancetype)initWithStyle:(kDirectionStyle)style stage:(NSUInteger)stage frame:(CGRect)frame;
//stage:几个button
- (void)updateProsess:(NSUInteger)stage;
//获得第几个 button
- (UIButton *)getButtonWith:(NSInteger)tag;
@end
