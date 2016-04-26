//
//  MessageCenterController.m
//  MMD
//
//  Created by pencho on 16/4/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MessageCenterController.h"
#import "ConstantTitle.h"
#import "MessageTableViewCell.h"
#import "MineModel.h"
#import "MessageCenterController.h"
#import "MessageTableViewCell+PutMessageInfo.h"
#import <SVProgressHUD.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import "ColorHeader.h"
#import <MJRefresh.h>



static NSString *reuseCellId = @"messageCellId";


@interface MessageCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger number;

@end

@implementation MessageCenterController


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGRect bounds = self.view.bounds;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 64, bounds.size.width - 2 * 20, bounds.size.height - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellId];
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self queryMessageList:NO];
        }];
        _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            [self queryMessageList:YES];
        }];;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = MESSAGECENTER_TITLE;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.number = 0;
    [self configureTableView];
    [self queryMessageList:NO];
}
- (void)configureTableView{
    [self.view addSubview:self.tableView];
}
- (void)queryMessageList:(BOOL)more{
    
    if (more) {
        self.number += 1;
    }else{
        self.number = 0;
    }
    [SVProgressHUD show];
    [MineModel queryUserMessage:nil pageNumber:self.number success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            NSArray *data = resultDic[@"data"];
            if (!more) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:data];
            [self.tableView reloadData];
        }
        
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId forIndexPath:indexPath];
    NSDictionary *itemDic = self.dataArray[indexPath.row];
    [cell setMessage:itemDic];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:reuseCellId configuration:^(id cell) {
        NSDictionary *itemDic = self.dataArray[indexPath.row];
        [cell setMessage:itemDic];
    }];
    return height;
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
