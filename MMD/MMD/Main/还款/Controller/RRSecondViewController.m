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


static CGFloat const GAP = 20;
static NSString * const reuseCellId = @"refudnCellId";
@interface RRSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UITableView *tableView;
@end


@implementation RRSecondViewController

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
    self.view.backgroundColor = [UIColor clearColor];
    [self configureTableView];
}
- (void)configureTableView{
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RefundTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellId];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.frame = CGRectMake(GAP, GAP, self.view.frame.size.width- 2 *GAP, self.view.frame.size.height - kTabbarHeight - GAP);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
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
