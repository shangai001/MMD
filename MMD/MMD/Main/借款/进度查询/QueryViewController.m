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
#import "ConstantApplyState.h"


/*借款信息头部视图*/
CGFloat const headerHeight = 100;
/*步骤数目*/
NSInteger const stageCount = 5;
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

@property (nonatomic, strong)UILabel *firstLabel;
@property (nonatomic, strong)UILabel *firstTimeLabel;
@property (nonatomic, strong)UILabel *secondLabel;
@property (nonatomic, strong)UILabel *secondTimeLabel;
@property (nonatomic, strong)UILabel *thirdLabel;
@property (nonatomic, strong)UILabel *thirdTimeLabel;
@property (nonatomic, strong)UILabel *fourthLabel;
@property (nonatomic, strong)UILabel *fourthTimeLabel;
@property (nonatomic, strong)UILabel *fifthLabel;
@property (nonatomic, strong)UILabel *fifthTimeLabel;

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
    self.dataDic = dataDic;
    
    self.item.contractId = dataDic[@"contractId"];
    self.item.state = dataDic[@"state"];
    self.item.term = dataDic[@"term"];
    self.item.loanCount = dataDic[@"amount"];
    self.item.applyTime = dataDic[@"applyTime"];
    
    NSDictionary *loanStateTimeDic = dataDic[@"loanStateTime"];
    self.item.applyConfirmTime = loanStateTimeDic[@"applyConfirmTime"];
    self.item.auditTime = loanStateTimeDic[@"auditTime"];
    self.item.auditConfirmTime = loanStateTimeDic[@"auditConfirmTime"];
    self.item.grantFundsTime = loanStateTimeDic[@"grantFundsTime"];
    self.item.cancelTime = loanStateTimeDic[@"cancelTime"];
    
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
    //根据申请状态设置状态蚊子
    [self setStateDetailText:item];
 }
//TODO:需要知道借款申请状态
- (void)resetCancleButtonStatus:(NSInteger)state{
    
    if (state == 1) {
        self.cancleButon.backgroundColor = [UIColor lightGrayColor];
        self.cancleButon.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.cancleButon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cancleButon.enabled = NO;
    }else if(state == 10 || state == 11){
        self.cancleButon.enabled = NO;
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
//设置状态指示文字
- (void)setStateDetailText:(QueryItem *)item{
    
    NSInteger state = [item.state integerValue];
//    NSInteger state = 1;
    if (state == LOAN_APPLY_CONFIRM
        || state == LOAN_AUDIT_WAITING
        || state == LAON_AUDIT_CONFIRM_FAIL
        || state == LAON_FINACE_AUDIT_FAIL) {
        //刚刚提交申请状态
        [self setBeforeTimeLabelInfo:item];
        [self.stageView updateProsess:1];
    }else if (state == LOAN_AUDIT_SUCCESS){
        //审核确认进行中
        [self setCheckLabelInfo:item];
        [self.stageView updateProsess:2];
    }else if (state == LAON_AUDIT_CONFIRM_SUCCESS ||
              state == LAON_FINACE_AUDIT_SUCCESS){
        //发放贷款资金中
        [self setSetLoanLabelInfo:item];
        [self.stageView updateProsess:3];
    }else if (state == LAON_CRANT_FUNDS_SUCCESS){
        //已经完结
        [self setNormalFinishLabelInfo:item];
        [self.stageView updateProsess:4];
    }else if (state == LOAN_APPLY_CANCLE ||
              state == LOAN_AUDIT_FAIL ||
              state == LAON_AUDIT_CANCLE){
        //显示不正常完结
        [self setUnNormalFinishLabelInfo:item];
        [self.stageView updateProsess:4];
    }
}
- (NSString *)convertDateToString:(double)internal{
    
    if (internal != 0) {
        NSTimeInterval _interval= internal/1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        NSTimeZone *tZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:tZone];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeString =[formatter stringFromDate:date];
        return timeString;
    }
    return nil;
}
//设置提交审核时间
- (void)setBeforeTimeLabelInfo:(QueryItem *)item{
    self.firstTimeLabel.text = [self convertDateToString:[item.applyTime doubleValue]];
}
//设置综合评审进行中
- (void)setZongheCheckInfo:(QueryItem *)item{
    [self setBeforeTimeLabelInfo:item];
    self.secondLabel.text = @"综合评估进行中";
    self.secondTimeLabel.textColor = self.secondLabel.textColor = [UIColor blackColor];
    self.secondTimeLabel.text = [self convertDateToString:[item.auditTime doubleValue]];
}
//设置审核确认进行中
- (void)setCheckLabelInfo:(QueryItem *)item{
    [self setZongheCheckInfo:item];
    self.thirdLabel.text = @"审核确认进行中";
    self.thirdLabel.textColor = self.thirdTimeLabel.textColor = [UIColor blackColor];
    self.thirdTimeLabel.text = [self convertDateToString:[item.auditConfirmTime doubleValue]];
}
//设置发放贷款资金中
- (void)setSetLoanLabelInfo:(QueryItem *)item{
    [self setCheckLabelInfo:item];
    self.fourthLabel.text = @"发放借贷资金中";
    self.fourthLabel.textColor = self.fourthTimeLabel.textColor = [UIColor blackColor];
    self.fourthTimeLabel.text = [self convertDateToString:[item.grantFundsTime doubleValue]];
}
//设置正常完结状态
- (void)setNormalFinishLabelInfo:(QueryItem *)item{
    [self setSetLoanLabelInfo:item];
    self.fifthLabel.text = @"已经完结";
    self.fifthLabel.textColor = self.fifthTimeLabel.textColor =[UIColor blackColor];
    self.fifthTimeLabel.text = [self convertDateToString:[item.cancelTime doubleValue]];
}
//设置非正常完结状态
- (void)setUnNormalFinishLabelInfo:(QueryItem *)item{
    [self setSetLoanLabelInfo:item];
    self.fifthLabel.textColor = self.fifthTimeLabel.textColor = [UIColor blackColor];
    /*
     LoanConstants.LOAN_APPLY_CANCEL  申请已取消
     LoanConstants.LOAN_AUDIT_CANCEL 审核取消
     LoanConstants.LOAN_AUDIT_FAIL  审核拒绝
     */
    if ([item.state integerValue] == LOAN_AUDIT_FAIL) {
        self.fifthLabel.text = @"审核拒绝";
    }else if ([item.state integerValue] == LAON_AUDIT_CANCLE){
        self.fifthLabel.text = @"审核取消";
    }else if ([item.state integerValue] == LOAN_APPLY_CANCLE){
        self.fifthLabel.text = @"申请已取消";
    }
    self.fourthTimeLabel.text = [self convertDateToString:[item.cancelTime doubleValue]];
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
//创建详细文字指示 Label
- (void)configureDetailTextLabel{

    [self.stageView layoutIfNeeded];
    for (NSInteger j = 0; j < 5; j ++) {
        UILabel *textLabel = [UILabel new];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.textColor = [UIColor grayColor];
        textLabel.numberOfLines = 1;
        
        UIButton *button = [self.stageView getButtonWith:j];
        CGFloat buttonY = button.frame.origin.y;
        textLabel.frame = CGRectMake(gapW + gapW + 10, buttonY + gapW, self.bottombottomContentView.frame.size.width - self.stageView.frame.origin.x - gapW - 5, 20);
        textLabel.tag = 1000 + j;
        textLabel.text = @"正在综合审核";
        [self.bottombottomContentView addSubview:textLabel];
        NSLog(@"textLabel = %@",textLabel);
        
        UILabel *timeLabel = [UILabel new];
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.numberOfLines = 1;
        timeLabel.tag = 2000 + j;
        CGRect textFrame = textLabel.frame;
        timeLabel.frame = CGRectMake(textFrame.origin.x, textFrame.origin.y + textFrame.size.height, textFrame.size.width, textFrame.size.height);
        [self.bottombottomContentView addSubview:timeLabel];
        
        NSArray *texts = @[@"提交申请",@"综合评估申请中",@"审核确认进行中",@"发放信贷资金中",@"已完结"];
        textLabel.text = texts[j];
        UIColor *blackColor =  [UIColor blackColor];
        if (j == 0) {
            self.firstLabel = textLabel;
            self.firstLabel.textColor = blackColor;
            self.firstTimeLabel = timeLabel;
            self.firstTimeLabel.textColor = blackColor;
        }else if (j == 1){
            self.secondLabel = textLabel;
            self.secondLabel.textColor = blackColor;
            self.secondTimeLabel = timeLabel;
            self.secondTimeLabel.textColor = blackColor;
        }else if (j == 2){
            self.thirdLabel = textLabel;
            self.thirdTimeLabel = timeLabel;
        }else if (j == 3){
            self.fourthLabel = textLabel;
            self.fourthTimeLabel = timeLabel;
        }else if (j == 4){
            self.fifthLabel = textLabel;
            self.fifthTimeLabel = timeLabel;
        }
    }
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
    [self configureDetailTextLabel];
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
        detail.URLString = [NSString stringWithFormat:@"%@/webview/getApplyInfo?userId=%@&token=%@&id=%@",kHostURL,userId,token,self.dataDic[@"contractId"]];
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
