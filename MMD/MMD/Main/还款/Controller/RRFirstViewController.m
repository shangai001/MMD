//
//  RRFirstViewController.m
//  MMD
//
//  Created by pencho on 16/4/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RRFirstViewController.h"
#import "RefundTableViewCell.h"
#import "ShouldRefundView.h"
#import "UIView+LoadViewFromNib.h"
#import "ConstantHeight.h"
#import "RefundModel.h"
#import <MJRefresh.h>
#import "NoInfoView.h"
#import <SVProgressHUD.h>
#import "RefundItem.h"
#import "RefundTableViewCell+PutUIinfo.h"
#import <YYCGUtilities.h>



static NSString * const reuseCellId = @"refudnCellId";
static CGFloat const GAP = 20;
static CGFloat const HeaderHeight = 80;

@interface RRFirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)ShouldRefundView *headView;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NoInfoView *infoView;
@property (strong, nonatomic)NSMutableArray *dataArray;


@end


@implementation RRFirstViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NoInfoView *)infoView{
    if (!_infoView) {
        _infoView = [NoInfoView loadViewFromNib];
        CGRect viewFrame = self.view.frame;
        _infoView.frame = CGRectMake(40, 100, viewFrame.size.width - 40 * 2,viewFrame.size.height - 40 * 2 + 30);
    }
    return _infoView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 140;
        _tableView.directionalLockEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}
- (ShouldRefundView *)headView{
    if (!_headView) {
        _headView = [ShouldRefundView loadViewFromNib];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    [self configureTableView];
    [self requestData];
}
/*
- (void)configureInfoView{
    
    [self.view addSubview:self.infoView];
    self.infoView.frame = CGRectMake(40, 100, self.view.frame.size.width - 40 * 2, self.view.frame.size.width - 40 * 2 + 30);
    self.infoView.infLabel.text = @"暂时没有该款项信息";
}
 */
- (void)configureTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RefundTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellId];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.frame = CGRectMake(GAP, 0, self.view.frame.size.width - 2 * GAP, self.view.frame.size.height  - HeaderHeight - kTabbarHeight - kTopLayoutGuide);
    self.headView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, HeaderHeight);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
}
- (void)requestData{
    
    [SVProgressHUD show];
    [RefundModel queryWillRefundInfo:nil success:^(NSDictionary *resultDic) {
        
        NSDictionary *data = resultDic[@"data"];
        BOOL result = [data isEqual:[NSNull null]];
        //如果是空，不隐藏 view（显示 View）
        [self hideNofoView:!result];
        if (!result) {
            //刷新 tableView
            [self initItemsArrayWith:data];
            [self.tableView reloadData];
        }else{
            [self.dataArray removeAllObjects];
        }
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (void)checkoutRefresh{
    [self requestData];
}
- (void)initItemsArrayWith:(NSDictionary *)data{
    
    [self.dataArray removeAllObjects];
    NSArray *repays = data[@"repays"];
    for (NSInteger j = 0; j < repays.count; j ++) {
        
        RefundItem *item = [RefundItem new];
        item.repayAmount = data[@"repayAmount"];
        item.remainAmount = data[@"remainAmount"];
        
        NSDictionary *oneDic = repays[j];
        item.term = oneDic[@"term"];
        item.overdue = oneDic[@"overdue"];
        item.playdate = oneDic[@"playdate"];
        [self.dataArray addObject:item];
    }
}
- (void)hideNofoView:(BOOL)hidden{
    
    if (hidden) {
        [self.infoView removeFromSuperview];
        self.headView.hidden = NO;
    }else{
        if (![self.view.subviews containsObject:self.infoView]) {
            [self.view addSubview:self.infoView];
        }
        CGRect viewFrame = self.view.frame;
        self.infoView.frame = CGRectMake(40, 100, viewFrame.size.width - 40 * 2,viewFrame.size.height - 40 * 2 + 30);
        self.infoView.infLabel.text = @"暂时没有该款项信息";
        [self.view bringSubviewToFront:self.infoView];
        
        self.headView.hidden = YES;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RefundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId forIndexPath:indexPath];
    // Configure the cell...
    RefundItem *item = self.dataArray[indexPath.row];
    [cell putItemInfo:item];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
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
