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
#import <UIView+SDAutoLayout.h>

static NSString * const reuseCellId = @"refudnCellId";
static CGFloat const GAP = 20;
static CGFloat const HeaderHeight = 80;

@interface RRFirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)ShouldRefundView *headView;
@property (strong, nonatomic)UITableView *tableView;

@end


@implementation RRFirstViewController
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
        _headView.backgroundColor = [UIColor brownColor];
        
    }
    return _headView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];
    self.view.backgroundColor = [UIColor redColor];
}
- (void)configureTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RefundTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellId];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.frame = CGRectMake(GAP, GAP, self.view.frame.size.width - 2 * GAP, self.view.frame.size.height);
    self.headView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, HeaderHeight);
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
