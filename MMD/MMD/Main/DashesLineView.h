//
//  DashesLineView.h
//  MMD
//
//  Created by pencho on 16/3/16.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,kLineType) {
    kRedRealType = 0,
    kRedDasheType = 1,
    kGrayRealType = 2
};

@interface DashesLineView : UIView

@property (nonatomic)CGPoint startPoint;//虚线起点
@property (nonatomic)CGPoint endPoint;//虚线终点
//@property (nonatomic,strong)UIColor* lineColor;//虚线颜色
@property (nonatomic,assign)CGFloat lineWidth;//线宽
@property (nonatomic,assign)CGFloat realLineWidth;
@property (nonatomic,assign)CGFloat dashLineWidth;
@property (nonatomic, assign)kLineType lineType;

@end
