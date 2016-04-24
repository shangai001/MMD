//
//  RRSecondViewController.m
//  MMD
//
//  Created by pencho on 16/4/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RRSecondViewController.h"
#import "RefundTableViewCell.h"
#import "ConstantHeight.h"
#import <Masonry.h>
#import <UIView+SDAutoLayout.h>
#import "RefundModel.h"
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import "NoInfoView.h"
#import "UIView+LoadViewFromNib.h"
#import "RefundItem.h"
#import <SVProgressHUD.h>
#import "RefundTableViewCell+PutUIinfo.h"
#import "RefundWebVController.h"
#import "AppUserInfoHelper.h"


CGFloat const GAP1 = 20;
static NSString * const reuseCellId = @"refudnCellId";


@interface RRSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NoInfoView *infoView;
@property (strong, nonatomic)NSMutableArray *dataArray;

@property (nonatomic, strong)NSNumber *repayAmount;
@property (nonatomic, strong)NSNumber *remainAmount;

@end


@implementation RRSecondViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NoInfoView *)infoView{
    if (!_infoView) {
        _infoView = [NoInfoView loadViewFromNib];
    }
    return _infoView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GAP1, 300) style:UITableViewStyleGrouped];
        _tableView.estimatedRowHeight = 140;
        _tableView.directionalLockEnabled = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    [self configureTableView];
    [self requestData];
}
- (void)configureTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RefundTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellId];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sd_layout.leftSpaceToView(self.view, GAP1).topEqualToView(self.view).rightSpaceToView(self.view, GAP1).bottomSpaceToView(self.view, GAP1 + kTabbarHeight);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
}
- (void)requestData{
    
    [SVProgressHUD show];
    [RefundModel queryDidRefundInfo:nil success:^(NSDictionary *resultDic) {
        
        NSDictionary *data = resultDic[@"data"];
        NSArray *repays = data[@"repays"];
        BOOL same = [data isEqual:[NSNull null]] || repays.count == 0;
        [self hideNofoView:!same];
        if (!same) {
            [self initItemsArrayWith:data];
            [self.tableView reloadData];
        }else{
            //显示没有借款
            [self.dataArray removeAllObjects];
        }
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self hideNofoView:NO];
    }];
}
- (void)initItemsArrayWith:(NSDictionary *)data{
    
    [self.dataArray removeAllObjects];
    self.repayAmount = data[@"repayAmount"];
    self.remainAmount = data[@"remainAmount"];
    
    NSArray *repays = data[@"repays"];
    for (NSInteger j = 0; j < repays.count; j ++) {
        
        RefundItem *item = [RefundItem new];
        
        NSDictionary *oneDic = repays[j];
 
        item.refundId = oneDic[@"id"];
        item.loanId = oneDic[@"loanId"];
        item.term = oneDic[@"terms"];
        item.overdue = oneDic[@"overdue"];
        item.playdate = oneDic[@"playdate"];
        item.totalFee = oneDic[@"totalFee"];
        
        [self.dataArray addObject:item];
    }
}

- (void)hideNofoView:(BOOL)hidden{
    
    if (hidden) {
        
        [self.infoView removeFromSuperview];
    }else{
        if (![self.view.subviews containsObject:self.infoView]) {
            [self.view addSubview:self.infoView];
        }
        
        [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(InfoViewWidth);
            make.height.mas_equalTo(InfoViewHeight);
            make.center.mas_equalTo(self.tableView);
        }];
        self.infoView.infLabel.text = @"暂时没有该款项信息";
        [self.view bringSubviewToFront:self.infoView];
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RefundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId forIndexPath:indexPath];
    // Configure the cell...
    cell.cellType = kDidRefundType;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RefundItem *item = self.dataArray[indexPath.row];
    [cell putItemInfo:item];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
//已还款 不能点击
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.row < self.dataArray.count) {
        
        NSDictionary *tokenDic = [AppUserInfoHelper tokenAndUserIdDictionary];
        NSString *userId = tokenDic[@"userId"];
        NSString *token = tokenDic[@"token"];
        
        RefundItem *item = self.dataArray[indexPath.row];
        RefundWebVController *webVC = [RefundWebVController new];
        webVC.URLString = [NSString stringWithFormat:@"%@/webview/getLoanInfoOfRepay?userId=%@&token=%@&loanId=%@&terms=%@",kHostURL,userId,token,item.loanId,item.term];
        webVC.detaiType = kDidRefundDetailType;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
*/
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

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
