//
//  StageView.m
//  MMD
//
//  Created by pencho on 16/3/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "StageView.h"
#import <Masonry.h>

#define buttonWidthHeight 30
#define buttonToLeft 10

@interface StageView ()

@property (assign, nonatomic)NSUInteger stage;
@property (assign, nonatomic)kDirectionStyle style;

@end

@implementation StageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

 //从代码加载
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [self initWithStage:0 frame:frame];
    
    return self;
}
- (instancetype)initWithStage:(NSUInteger)stage{
    
    self = [self initWithStage:stage frame:CGRectZero];
    
    return self;
}
- (instancetype)initWithStage:(NSUInteger)stage frame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.style = kHorizontalStyle;
        self.stage = stage;
    }
    return self;
}
- (instancetype)initWithStyle:(kDirectionStyle)style frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.stage = 0;
    }
    return self;
}
- (instancetype)initWithStyle:(kDirectionStyle)style stage:(NSUInteger)stage frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.stage = stage;
    }
    return self;
}
- (void)setStage:(NSUInteger)stage{
    _stage = stage;
    for (NSUInteger j = 0; j < _stage; j ++) {

        UIButton *button =  [StageView initStageButton:j];
        [self addSubview:button];
        [self addMasonryLayout:button stage:_stage j:j];
        [self setNeedsLayout];
    }
}
- (void)addMasonryLayout:(UIButton *)button stage:(NSUInteger)stage j:(NSUInteger)j{
    
    CGRect superFrame = self.frame;
    if (self.style == kHorizontalStyle) {
        //第n+1个button左边距离第n个button左边距离
        CGFloat buttonLeftToButtonLeft = (superFrame.size.width - 2 * buttonToLeft - stage * buttonWidthHeight)/(_stage - 1);
        
        CGFloat leftToSuper = buttonToLeft + buttonWidthHeight * j + buttonLeftToButtonLeft * j;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(self.mas_left).with.offset(leftToSuper);
            make.centerY.mas_equalTo(self);
        }];
    }else{
        //第n+1个button上边距离第n个button上边距离
        CGFloat buttonTopToButtonTop = (superFrame.size.width - 2 * buttonToLeft - stage * buttonWidthHeight)/(_stage - 1);
        CGFloat topToSuper = buttonToLeft + buttonWidthHeight * j + buttonTopToButtonTop * j;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.top.mas_equalTo(self.mas_top).with.offset(topToSuper);
            make.centerX.mas_equalTo(self);
        }];
    }
}
+ (UIButton *)initStageButton:(NSUInteger)j {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"步骤"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"步骤0"] forState:UIControlStateNormal];
    button.tag = j + 100;
    if (j == 0) {
        button.selected = YES;
    }
    return button;
}
- (void)matchStage:(NSUInteger)stage sender:(id)sender{
    
}
@end
