//
//  StageView.m
//  MMD
//
//  Created by pencho on 16/3/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "StageView.h"
#import "HorizontalDashLineView.h"
#import "VerticalDashLineView.h"

#import <Masonry.h>

#define buttonWidthHeight 30
#define buttonToLeft 10
#define StageViewHeight 4

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
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.style = kHorizontalStyle;
        self.stage = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
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
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (instancetype)initWithStyle:(kDirectionStyle)style frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.stage = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (instancetype)initWithStyle:(kDirectionStyle)style stage:(NSUInteger)stage frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.stage = stage;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setStage:(NSUInteger)stage{
    _stage = stage;
    if (_stage > 0) {
        for (NSUInteger j = 0; j < _stage; j ++) {
            UIButton *button =  [StageView initStageButton:j];
            [self addSubview:button];
            [self addMasonryLayoutButton:button stage:_stage j:j];
            [self setNeedsLayout];
        }
        for (NSUInteger k = 0; k < _stage - 1; k ++) {
            CGRect superFrame = self.frame;
            if (self.style == kHorizontalStyle) {
                CGFloat buttonLeftToButtonLeft = (superFrame.size.width - 2 * buttonToLeft - _stage * buttonWidthHeight)/(_stage - 1);
                CGFloat leftToSuper = buttonToLeft + buttonWidthHeight + (buttonWidthHeight + buttonLeftToButtonLeft) * k;
                HorizontalDashLineView *lineView = [[HorizontalDashLineView alloc] initWithFrame:CGRectMake(leftToSuper, (superFrame.size.height - StageViewHeight)/2, buttonLeftToButtonLeft, StageViewHeight)];
                lineView.lineType = k == 0 ? kRedDasheType : kGrayRealType;
                [self addSubview:lineView];
            }else{
                CGFloat buttonTopToButtonTop = (superFrame.size.height - 2 * buttonToLeft - _stage * buttonWidthHeight)/(_stage - 1);
                CGFloat topToSuper = buttonToLeft + buttonWidthHeight + (buttonTopToButtonTop + buttonWidthHeight) * k;
                VerticalDashLineView *lineView = [[VerticalDashLineView alloc] initWithFrame:CGRectMake((superFrame.size.width - StageViewHeight)/2, topToSuper,StageViewHeight , buttonTopToButtonTop)];
                lineView.lineType = k == 0 ? kRedDasheType : kGrayRealType;
                [self addSubview:lineView];
            }
        }
 
    }
}
- (void)addMasonryLayoutButton:(UIButton *)button stage:(NSUInteger)stage j:(NSUInteger)j{
    
    CGRect superFrame = self.frame;
    if (self.style == kHorizontalStyle) {
        //第n+1个button左边距离第n个button左边距离
        CGFloat buttonLeftToButtonLeft = (superFrame.size.width - 2 * buttonToLeft - stage * buttonWidthHeight)/(_stage - 1);
        
        CGFloat leftToSuper = buttonToLeft + buttonWidthHeight * j + buttonLeftToButtonLeft * j;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(buttonWidthHeight, buttonWidthHeight));
            make.left.mas_equalTo(self.mas_left).with.offset(leftToSuper);
            make.centerY.mas_equalTo(self);
        }];
        [self addTitleLabel:j below:button];
    }else{
        //第n+1个button上边距离第n个button上边距离
        CGFloat buttonTopToButtonTop = (superFrame.size.height - 2 * buttonToLeft - stage * buttonWidthHeight)/(_stage - 1);
        CGFloat topToSuper = buttonToLeft + buttonWidthHeight * j + buttonTopToButtonTop * j;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(buttonWidthHeight, buttonWidthHeight));
            make.top.mas_equalTo(self.mas_top).with.offset(topToSuper);
            make.centerX.mas_equalTo(self);
        }];
    }
}

- (void)addTitleLabel:(NSInteger)index below:(UIButton *)button{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor lightGrayColor];
    NSString *title = [NSString stringWithFormat:@"第%ld步",index];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidthHeight, buttonWidthHeight/2));
        make.centerX.mas_equalTo(button);
        make.top.mas_equalTo(button.mas_bottom);
    }];
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
- (void)updateProsess:(NSUInteger)stage{
    UIButton *button = (UIButton *)[self viewWithTag:stage + 100];
    button.selected = YES;
}

@end
