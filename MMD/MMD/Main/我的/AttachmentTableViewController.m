//
//  AttachmentTableViewController.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "AttachmentTableViewController.h"
#import "AttachmentTableViewCell.h"
#import "ColorHeader.h"
#import "QueryAttachmentModel.h"
#import "AttachmentTableViewCell+PutUIInfo.h"
#import "EditeAttachmentViewController.h"


static NSString *reuseCellId  = @"attachmentCellId";

@interface AttachmentTableViewController ()

@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation AttachmentTableViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self configureTableView];
    [self requestAttachmentList];
}
- (void)initAddItem{
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(moveToAddAttachment:)];
    
    [addItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = addItem;
}
- (void)moveToAddAttachment:(id)sender{
    
}
- (void)requestAttachmentList{
    
    [QueryAttachmentModel queryAttachment:nil success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            [self.dataArray removeAllObjects];
            NSArray *data = resultDic[@"data"];
            for (NSInteger j = 0; j < data.count; j ++) {
                NSDictionary *oneDic = data[j];
                [self.dataArray addObject:oneDic];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AttachmentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellId];
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AttachmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId forIndexPath:indexPath];
    // Configure the cell...
    NSDictionary *dic = self.dataArray[indexPath.row];
    [cell putUIInfo:dic];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *attDic = self.dataArray[indexPath.row];
    EditeAttachmentViewController *editeVC = [[EditeAttachmentViewController alloc] initWithNibName:NSStringFromClass([EditeAttachmentViewController class]) bundle:[NSBundle mainBundle]];
    editeVC.attDic = attDic;
    [self.navigationController pushViewController:editeVC animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
