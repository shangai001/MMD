//
//  LoanVerifyController.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoanVerifyController.h"
#import "ConstantHeight.h"
#import "FormTableViewCell.h"
#import "BottomTableViewCell.h"
#import "HeaderLabel.h"
#import "FormTableViewCell+PutValue.h"
#import "BottomTableViewCell+PutValue.h"
#import "SureViewController.h"
#import "LoanInfoItem.h"
#import "FormItem.h"
#import "BottomItem.h"
#import "SubmitLoanInfoModel.h"
#import "FormatVerifyDataHelper.h"
#import <YYCGUtilities.h>
#import <SVProgressHUD.h>



CGFloat const EDGELENGTH = 20;
CGFloat const SUREBOTTOMBARHEIGHT = 64;

static NSString * const cellReuseId = @"formTableCellId";
static NSString * const bottomCellId = @"BottomCellId";

@interface LoanVerifyController ()<UITableViewDataSource,UITableViewDelegate,AgreeLoanProtro>

@property (nonatomic, strong)UITableView *mainTableView;
//前2个section数据原
@property (nonatomic, strong)NSMutableArray *dataArray;
//最后1个section数据源
@property (nonatomic, strong)NSMutableArray *bottomDataArray;

@end

@implementation LoanVerifyController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)bottomDataArray{
    if (!_bottomDataArray) {
        _bottomDataArray = [NSMutableArray array];
    }
    return _bottomDataArray;
}
- (LoanInfoItem *)infoItem{
    if (!_infoItem) {
        _infoItem = [LoanInfoItem new];
        _infoItem.refundMoth = 0;
        _infoItem.refundMoneyEveryMoth = 0.00;
    }
    return _infoItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请借款确认";
    [self initTableView];
    [self requestSectionTitleData];
    [self addSureBottomBar];
}
- (void)requestSectionTitleData{
    NSAssert(self.infoItem.refundMoth > 0, @"缺少还款期数");
    NSMutableArray *keyValuesArray = [FormatVerifyDataHelper ez_itemsArrayForVerify:self.infoItem];
    self.dataArray = keyValuesArray;
    
    NSMutableArray *boItems = [FormatVerifyDataHelper ez_bottomItemArrayForBottomCell:self.infoItem];
    self.bottomDataArray = boItems;
}
- (void)initTableView{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(EDGELENGTH, 0, kScreenWidth- 2 * EDGELENGTH, kScreenHeight - SUREBOTTOMBARHEIGHT) style:UITableViewStyleGrouped];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.estimatedRowHeight = 44;
    _mainTableView.estimatedSectionHeaderHeight = 30;
    _mainTableView.showsHorizontalScrollIndicator = _mainTableView.showsVerticalScrollIndicator = NO;
    [_mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FormTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellReuseId];
    [_mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BottomTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:bottomCellId];
    [self.view addSubview:_mainTableView];
}
- (void)addSureBottomBar{
    SureViewController *sureVC = [[SureViewController alloc] initWithNibName:NSStringFromClass([SureViewController class]) bundle:[NSBundle mainBundle]];
    [self addChildViewController:sureVC];
    [self.view addSubview:sureVC.view];
    sureVC.view.frame = CGRectMake(0, kScreenHeight - SUREBOTTOMBARHEIGHT - 10, kScreenWidth, SUREBOTTOMBARHEIGHT + 10);
    [sureVC didMoveToParentViewController:self];
    sureVC.agreeDelegate = self;
}
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 6;
    }else if (section == 2){
        return self.infoItem.refundMoth + 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 | indexPath.section == 1) {
        FormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
        if (indexPath.section == 0) {
            
            cell.titleLabelWidth.constant = 100;
        }else{
            cell.titleLabelWidth.constant = 140;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FormItem *item = [self currentItem:indexPath];
        [cell putTitleValue:item];
        return cell;
    }else if (indexPath.section == 2){
        BottomTableViewCell *boCell = [tableView dequeueReusableCellWithIdentifier:bottomCellId forIndexPath:indexPath];
        BottomItem *boItem = (BottomItem *)self.bottomDataArray[indexPath.row];
        [boCell putLabelValue:boItem];
        boCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return boCell;
    }
    return nil;
}
- (FormItem *)currentItem:(NSIndexPath *)indexPath{
    
    if (indexPath.section >= self.dataArray.count)  return nil;
    NSArray *sectionArray = self.dataArray[indexPath.section];
    if (indexPath.row >= sectionArray.count)  return nil;
    FormItem *item = (FormItem *)sectionArray[indexPath.row];
    return item;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [HeaderLabel initHeaderLabel:CGSizeMake(tableView.frame.size.width, 30)];
    if (section == 0) {
        label.text = @"借款人信息";
    }else if (section == 1){
        label.text = @"借款概要";
    }else if (section == 2){
        label.text = @"还款概要";
    }
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
#pragma AgreeProtro
- (void)didAgreeLoanProto:(id)sender{
    //检查能否提交
    [SubmitLoanInfoModel checkIfUserCanSubmitLoanApplySuccess:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            NSInteger data = [resultDic[@"data"] integerValue];
            if (data == 1) {
                //可以提交
                [self submitLoanApply];
            }else if (data == 0){
                [SVProgressHUD showInfoWithStatus:resultDic[@"msg"]];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)submitLoanApply{
    
    [SVProgressHUD show];
    NSDictionary *info = @{@"capital":@(self.infoItem.floatLoanMoney),@"termLine":@(self.infoItem.refundMoth)};
    [SubmitLoanInfoModel submitLoanInfo:info success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            [SVProgressHUD dismiss];
            NSLog(@"提交成功");
        }else{
            [SVProgressHUD showInfoWithStatus:resultDic[@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"提交失败");
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
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
