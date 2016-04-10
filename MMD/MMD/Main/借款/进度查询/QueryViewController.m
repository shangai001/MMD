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
#import "QueryItem.h"
#import <SVProgressHUD.h>
#import "NoInfoView.h"
#import "BaseNextButton.h"


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
@property (nonatomic, strong)QueryHeaderView *queryHeaderView;
@property (nonatomic, strong)StageView *stageView;
@property (nonatomic, strong)BaseNextButton *cancleButon;

@property (nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, strong)QueryItem *item;

@property (nonatomic, strong)NoInfoView *noInfoView;


@end

@implementation QueryViewController

#pragma mark SubViewGetter
- (NoInfoView *)noInfoView{
    if (!_noInfoView) {
        _noInfoView = [NoInfoView loadViewFromNib];
    }
    return _noInfoView;
}
- (QueryItem *)item{
    if (!_item) {
        _item = [QueryItem new];
    }
    return _item;
}
- (NSDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSDictionary dictionary];
    }
    return _dataDic;
}
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
- (QueryHeaderView *)queryHeaderView{
    if (!_queryHeaderView) {
        _queryHeaderView = [QueryHeaderView loadViewFromNib];
        _queryHeaderView.backgroundColor = [UIColor whiteColor];
        _queryHeaderView.layer.cornerRadius = 10.0f;
        _queryHeaderView.detailDelegate = self;
        //查看借款详情已经通过协议实现
    }
    return _queryHeaderView;
}
- (BaseNextButton *)cancleButon{
    if (!_cancleButon) {
        //创建button
        _cancleButon = [[BaseNextButton alloc] init];
        _cancleButon.backgroundColor = [UIColor whiteColor];
        [_cancleButon setTitle:@"取消申请" forState:UIControlStateNormal];
        [_cancleButon setTitleColor:REDCOLOR forState:UIControlStateNormal];
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
//    [self haveNoLoanStatusInfo:YES];
}
//请求借款申请状态
- (void)requestLoanStatus{
    if ([MMDLoggin isLoggin]) {
        [SVProgressHUD show];
        [QueryModel queryLoanStatus:nil success:^(NSDictionary *resultDic) {
            if ([resultDic[@"code"] integerValue] == 0) {

                [self haveNoLoanStatusInfo:YES];
                [self creatItem:resultDic];
                [SVProgressHUD dismiss];
            }else{
                [self haveNoLoanStatusInfo:NO];
                [SVProgressHUD dismiss];
            }

        } failure:^(NSError *error) {
            
        }];
    }
}
//构造数据
- (void)creatItem:(NSDictionary *)resultDic{
    NSDictionary *dataDic = resultDic[@"data"];
    self.item.contractId = dataDic[@"contractId"];
    self.item.state = dataDic[@"state"];
    self.item.term = dataDic[@"term"];
    self.item.loanCount = dataDic[@"amount"];
    [self reloadProgressView:self.item];
}
//刷新视图
- (void)reloadProgressView:(QueryItem *)item{
    //设置借款数目
    [self setLoanInfo:item label:self.queryHeaderView.loanTextLabel];
    //设置还款时间
    [self setLoanInfo:item label:self.queryHeaderView.loanTimeLabel];
    //根据申请状态设置取消按钮状态
    [self resetCancleButtonStatus:[item.state integerValue]];
    
 }
//TODO:需要知道借款申请状态
- (void)resetCancleButtonStatus:(NSInteger)state{
    
    if (state == 1) {
        self.cancleButon.backgroundColor = [UIColor lightGrayColor];
        self.cancleButon.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.cancleButon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cancleButon.enabled = NO;
    }else{
        
    }
}
- (void)setLoanInfo:(QueryItem *)item label:(UILabel *)textLabel{
    
    NSString *numberString = @"";
    NSString *frontString = @"";
    NSInteger numberLength = 0;
    UIColor *numberColor = nil;
    if ([textLabel isEqual:self.queryHeaderView.loanTextLabel]) {
        numberString = [item.loanCount stringValue];
        frontString =  [NSString stringWithFormat:@"%@元",numberString];
        numberColor = Color(0.97, 0.43, 0.36, 1);
    }else if([textLabel isEqual:self.queryHeaderView.loanTimeLabel]){
        numberString = [item.term stringValue];
        frontString =  [NSString stringWithFormat:@"%@个月",numberString];
        numberColor = Color(0.24, 0.78, 0.94, 1);
    }
    numberLength = numberString.length;
    NSMutableAttributedString *loanAttributeString = [[NSMutableAttributedString alloc] initWithString:frontString];
    
    NSRange numberRange = NSMakeRange(0,numberLength);
    
    NSDictionary *numberDic = @{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:numberColor};
    [loanAttributeString addAttributes:numberDic range:numberRange];
    NSDictionary *textDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]};
    NSRange textRange = NSMakeRange(numberLength, frontString.length - numberLength);
    [loanAttributeString addAttributes:textDic range:textRange];
    textLabel.attributedText = loanAttributeString;
}

#pragma mark ConfigureSubViews
//配置滑动视图
- (void)configureScroolView{
    
    [self.view addSubview:self.scrollView];
    //添加autolayout
    CGSize viewSize = self.view.frame.size;
    self.scrollView.sd_layout
    .leftSpaceToView(self.view,gapW)
    .rightSpaceToView(self.view,gapW)
    .topSpaceToView(self.view, gapW)
    .bottomSpaceToView(self.view, 0);
    [_scrollView updateLayout];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, viewSize.height + deltH);
}
//配置头视图信息
- (void)configureHeaderView{
    [self.scrollView addSubview:self.queryHeaderView];
    self.queryHeaderView.sd_layout.leftSpaceToView(self.scrollView, 0).topSpaceToView(self.scrollView,0).rightSpaceToView(self.scrollView, 0).heightIs(headerHeight);

}
//配置内容视图
- (void)configurebottomContentView{
    
    CGSize viewSize = self.view.frame.size;
    [_scrollView addSubview:self.bottombottomContentView];
    //如果有借款申请
    self.bottombottomContentView.sd_layout
    .leftEqualToView(_scrollView)
    .rightEqualToView(_scrollView)
    .topSpaceToView(self.queryHeaderView, gapW)
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
    
    WeakSelf;
    //弹出框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认取消" message:@"取消借款申请" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cacncleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf callCancleAction];
    }];
    [alert addAction:sureAction];
    [alert addAction:cacncleAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)callCancleAction{
    
    
    NSLog(@"借款申请状态%@",self.item.state);
    //loanApplyId
    NSDictionary *infoDic = @{@"loanApplyId":self.item.contractId};
    
    [QueryModel cancleLoanApply:infoDic success:^(NSDictionary *resultDic) {
        NSLog(@"取消借款申请返回%@",resultDic);
        if ([resultDic[@"code"] integerValue] == 0) {
            [self resetCancleButtonStatus:1];
        }else{
            [SVProgressHUD showInfoWithStatus:resultDic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"取消借款申请错误%@",error);
    }];
}
#pragma mark 是否有借款信息
- (void)haveNoLoanStatusInfo:(BOOL)have{
    
    if (have) {
        [self didGetLoanStatusInfo];
    }else{
        [self didNotGetLoanStatusInfo];
        [self showNoInfoView];
    }
}
- (void)didGetLoanStatusInfo{
    
    [self configureScroolView];
    [self configureHeaderView];
    [self configurebottomContentView];
    [self configureStageView];
    [self configureCancelButton];
    
    [self.noInfoView removeFromSuperview];
}
- (void)didNotGetLoanStatusInfo{
    
    [self.queryHeaderView removeFromSuperview];
    [self.bottombottomContentView removeFromSuperview];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.view.frame.size.height);
}
- (void)showNoInfoView{
    
    [self.view addSubview:self.noInfoView];
    self.noInfoView.sd_layout.widthIs(150).heightIs(180).centerXEqualToView(self.view).topSpaceToView(self.view,100);
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
