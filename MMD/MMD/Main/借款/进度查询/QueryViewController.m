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
#import "MMDLoggin.h"
#import "QueryModel.h"
#import "QueryHeaderView.h"
#import "UIView+LoadViewFromNib.h"
#import "LoanDetaiController.h"
#import "AppUserInfoHelper.h"


/*借款信息头部视图*/
CGFloat const headerHeight = 100;
/*步骤数目*/
NSInteger const stageCount = 4;
/*步骤图高度*/
CGFloat const stageHeightY = 80;
/*滑动距离*/
CGFloat const deltH = 350;
/*左右间隔*/
CGFloat const gapW = 20;
/*滑到底部时，距离tabbar高度*/
CGFloat const contenToBottom = 20;
/*取消按钮距离bottomContentView高度*/
CGFloat const cacleButtonToBottom = 20;
CGFloat const cacleButtonHeight = 44;

@interface QueryViewController ()<GoseeLoanDetailDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView *bottombottomContentView;
@property (nonatomic, strong)QueryHeaderView *headerView;
@property (nonatomic, strong)StageView *stageView;
@property (nonatomic, strong)UIButton *cancleButon;
@end

@implementation QueryViewController

#pragma mark SubViewGetter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIView *)bottombottomContentView{
    if (!_bottombottomContentView) {
        _bottombottomContentView = [UIView new];
        _bottombottomContentView.backgroundColor = [UIColor whiteColor];
        _bottombottomContentView.layer.cornerRadius = 10.0f;
    }
    return _bottombottomContentView;
}
- (QueryHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [QueryHeaderView loadViewFromNib];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.layer.cornerRadius = 10.0f;
        _headerView.detailDelegate = self;
    }
    return _headerView;
}
- (UIButton *)cancleButon{
    if (!_cancleButon) {
        //创建button
        _cancleButon = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancleButon.backgroundColor = REDCOLOR;
        [_cancleButon setTitle:@"取消申请" forState:UIControlStateNormal];
        [_cancleButon setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancleButon.layer.cornerRadius = 5.0f;
        _cancleButon.layer.borderColor = [UIColor redColor].CGColor;
        _cancleButon.layer.borderWidth = 1.0f;
    }
    return _cancleButon;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    //查询是否有借款进度
    [self requestLoanStatus];
    [self haveNoLoanStatusInfo:YES];
}
//请求借款申请状态
- (void)requestLoanStatus{
    if ([MMDLoggin isLoggin]) {
        [QueryModel queryLoanStatus:nil success:^(NSDictionary *resultDic) {
            NSLog(@"查询借款结果  %@",resultDic);
        } failure:^(NSError *error) {
            
        }];
    }
}
#pragma mark ConfigureSubViews
//配置滑动视图
- (void)configureScroolView{
    
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
}
//配置头视图信息
- (void)configureHeaderView{
    [self.scrollView addSubview:self.headerView];
    self.headerView.sd_layout.leftSpaceToView(self.scrollView, 0).topSpaceToView(self.scrollView,0).rightSpaceToView(self.scrollView, 0).heightIs(headerHeight);
}
//配置内容视图
- (void)configurebottomContentView{
    
    CGSize viewSize = self.view.frame.size;
    [_scrollView addSubview:self.bottombottomContentView];
    //如果有借款申请
    self.bottombottomContentView.sd_layout
    .leftEqualToView(_scrollView)
    .rightEqualToView(_scrollView)
    .topSpaceToView(self.headerView, gapW)
    .heightIs(viewSize.height - gapW + deltH  - (contenToBottom + cacleButtonToBottom + headerHeight + gapW));
}
//配置步骤条
- (void)configureStageView{
    [self.bottombottomContentView updateLayout];
    //步骤图距离上端stageHeightY 距离取消按钮gaW
    self.stageView = [[StageView alloc] initWithStyle:kverticalTypeStyle stage:stageCount frame:CGRectMake(gapW, gapW/2, gapW, self.bottombottomContentView.frame.size.height - stageHeightY - cacleButtonToBottom - cacleButtonHeight - gapW)];
    [self.bottombottomContentView addSubview:self.stageView];
}
//配置取消按钮
- (void)configureCancelButton{
    
    [self.bottombottomContentView addSubview:self.cancleButon];
    //设置autolayout
    self.cancleButon.sd_layout
    .leftSpaceToView(self.bottombottomContentView, gapW)
    .rightSpaceToView(self.bottombottomContentView, gapW)
    .heightIs(cacleButtonHeight)
    .bottomSpaceToView(self.bottombottomContentView, cacleButtonToBottom);
    [self.cancleButon addTarget:self action:@selector(cancleLoanApply:) forControlEvents:UIControlEventTouchUpInside];
}
//取消申请借款
- (void)cancleLoanApply:(id)sender{
    
    [self didNotGetLoanStatusInfo];
}
#pragma mark 是否有借款信息
- (void)haveNoLoanStatusInfo:(BOOL)have{
    
    if (have) {
        [self didGetLoanStatusInfo];
    }else{
        [self didNotGetLoanStatusInfo];
    }
}
- (void)didGetLoanStatusInfo{
    
    [self configureScroolView];
    [self configureHeaderView];
    [self configurebottomContentView];
    [self configureStageView];
    [self configureCancelButton];
}
- (void)didNotGetLoanStatusInfo{
    
    [self.headerView removeFromSuperview];
    [self.bottombottomContentView removeFromSuperview];
    self.scrollView.backgroundColor = [UIColor cyanColor];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.view.frame.size.height);
}
#pragma mark SeeDetail
- (void)openLoanDetail:(id)sender{
    if ([MMDLoggin isLoggin]) {
        
        NSDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
        NSString *userId = tokenDic[@"userId"];
        NSString *token = tokenDic[@"token"];
        
        LoanDetaiController *detail = [LoanDetaiController new];
        detail.URLString = [NSString stringWithFormat:@"%@/webview/getApplyInfo?userId=%@&token=%@",kHostURL,userId,token];
        [self.navigationController pushViewController:detail animated:YES];
    }
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
