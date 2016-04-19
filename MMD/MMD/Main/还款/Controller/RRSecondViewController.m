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
#import <UIView+SDAutoLayout.h>
#import "RefundModel.h"
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import "NoInfoView.h"
#import "UIView+LoadViewFromNib.h"


static CGFloat const GAP = 20;
static NSString * const reuseCellId = @"refudnCellId";
@interface RRSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NoInfoView *infoView;

@end


@implementation RRSecondViewController

- (NoInfoView *)infoView{
    if (!_infoView) {
        _infoView = [NoInfoView loadViewFromNib];
    }
    return _infoView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GAP, 300) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 140;
        _tableView.directionalLockEnabled = YES;
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
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RefundTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellId];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sd_layout.leftSpaceToView(self.view, GAP).topEqualToView(self.view).rightSpaceToView(self.view, GAP).bottomSpaceToView(self.view, GAP + kTabbarHeight);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
}
- (void)requestData{
    
    [RefundModel queryDidRefundInfo:nil success:^(NSDictionary *resultDic) {
        NSLog(@"已经还款信息 %@",resultDic);
        NSArray *data = resultDic[@"data"];
        if (![data isEqual:[NSNull null]]) {
            
        }else{
            //显示没有借款
            
        }
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)hideNofoView:(BOOL)hidden{
    
    if (hidden) {
        //        self.infoView.hidden = YES;
        [self.view sendSubviewToBack:self.infoView];
    }else{
        //        self.infoView.hidden = NO;
        [self.view bringSubviewToFront:self.infoView];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RefundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}
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
