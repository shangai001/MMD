//
//  VerticalDashLineView.h
//  MMD
//
//  Created by pencho on 16/3/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StageDirectionHeader.h"

@interface VerticalDashLineView : UIView
@property (nonatomic,assign)CGFloat lineWidth;//线宽
@property (nonatomic,assign)CGFloat realLineWidth;
@property (nonatomic,assign)CGFloat dashLineWidth;
@property (nonatomic, assign)kLineType lineType;
@end
