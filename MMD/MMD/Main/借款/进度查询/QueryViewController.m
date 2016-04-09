//
//  QueryViewController.m
//  MMD
//
//  Created by pencho on 16/2/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "QueryViewController.h"
#import "StageView.h"
#import <YYCGUtilities.h>
#import "ColorHeader.h"
#import <UIView+SDAutoLayout.h>
#import "ConstantHeight.h"

/*步骤数目*/
NSInteger const stageCount = 4;
/*步骤图高度*/
CGFloat const stageHeightY = 80;
/*滑动距离*/
CGFloat const deltH = 200;
/*左右间隔*/
CGFloat const gapW = 20;
/*滑到底部时，距离tabbar高度*/
CGFloat const contenToBottom = 20;
/*取消按钮距离contentView高度*/
CGFloat const cacleButtonToBottom = 20;
CGFloat const cacleButtonHeight = 44;

@interface QueryViewController ()

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)StageView *stageView;
@property (nonatomic, strong)UIButton *cancleButon;
@end

@implementation QueryViewController

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor orangeColor];
        _contentView.layer.cornerRadius = 10.0f;
    }
    return _contentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self configureScroolView];
    [self configureStageView];
    [self initContentView];
}
- (void)configureScroolView{
    
    {
        [self.view addSubview:self.scrollView];
        //添加autolayout
        CGSize viewSize = self.view.frame.size;
        self.scrollView.contentSize = CGSizeMake(viewSize.width, viewSize.height + deltH);
        self.scrollView.sd_layout
        .leftSpaceToView(self.view,gapW)
        .rightSpaceToView(self.view,gapW)
        .topSpaceToView(self.view, gapW)
        .bottomSpaceToView(self.view, 0);
        [_scrollView updateLayout];
        [_scrollView addSubview:self.contentView];
        //如果有借款申请
        self.contentView.sd_layout
        .leftEqualToView(_scrollView)
        .rightEqualToView(_scrollView)
        .topEqualToView(_scrollView)
        .heightIs(viewSize.height - gapW + deltH  - (contenToBottom + cacleButtonToBottom));
    }
}
- (void)configureStageView{
    [self.contentView updateLayout];
    //步骤图距离上端stageHeightY 距离取消按钮gaW
    self.stageView = [[StageView alloc] initWithStyle:kverticalTypeStyle stage:stageCount frame:CGRectMake(gapW, stageHeightY, gapW, self.contentView.frame.size.height - stageHeightY - cacleButtonToBottom - cacleButtonHeight - gapW)];
    [self.contentView addSubview:self.stageView];
}
- (void)initContentView{
    
    _cancleButon = [UIButton buttonWithType:UIButtonTypeSystem];
    [_cancleButon setTitle:@"取消申请" forState:UIControlStateNormal];
    [_cancleButon setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _cancleButon.layer.cornerRadius = 5.0f;
    _cancleButon.layer.borderColor = [UIColor redColor].CGColor;
    _cancleButon.layer.borderWidth = 1.0f;
    [self.contentView addSubview:_cancleButon];
    _cancleButon.sd_layout
    .leftSpaceToView(self.contentView, gapW)
    .rightSpaceToView(self.contentView, gapW)
    .heightIs(cacleButtonHeight)
    .bottomSpaceToView(self.contentView, cacleButtonToBottom);
    [_cancleButon addTarget:self action:@selector(cancleLoanApply:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)cancleLoanApply:(id)sender{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
