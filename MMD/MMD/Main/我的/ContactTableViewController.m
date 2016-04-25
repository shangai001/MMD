//
//  ContactTableViewController.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ContactTableViewController.h"
#import "ContactsItem.h"
#import "QueryIdModel.h"
#import "ContactsTableViewCell.h"
#import "ContactsTableViewCell+PutContentInfo.h"
#import <SVProgressHUD.h>
#import "ColorHeader.h"
#import "EditeContactViewController.h"


static NSString *reuseCellId = @"contectCellId";


@interface ContactTableViewController ()

@property (strong, nonatomic)NSMutableArray *dataArray;


@end

@implementation ContactTableViewController


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
    self.title = @"联系人";
    [self configureTableView];
    [self queryContacts];
}
- (void)initAddItem{
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(moveToEditeVc:)];
    [addItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = addItem;
}
- (void)moveToEditeVc:(id)sender{
    
    EditeContactViewController *editeVC = [[EditeContactViewController alloc] initWithNibName:NSStringFromClass([EditeContactViewController class]) bundle:[NSBundle mainBundle]];
    editeVC.isAdding = YES;
    [self.navigationController pushViewController:editeVC animated:YES];
}
- (void)configureTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContactsTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseCellId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
}
- (void)queryContacts{
    
    [SVProgressHUD show];
    [QueryIdModel queryContactsSuccess:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            [self.dataArray removeAllObjects];
            NSArray *data = resultDic[@"data"];
            for (NSInteger j = 0; j < data.count; j ++) {
                NSDictionary *oneDic = data[j];
                ContactsItem *item = [ContactsItem new];
                item.name = oneDic[@"name"];
                item.relation = oneDic[@"relation"];
                item.phone = oneDic[@"phone"];
                item.checkState = oneDic[@"checkState"];
                [self.dataArray addObject:item];
            }
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.row < self.dataArray.count) {
        ContactsItem *item = self.dataArray[indexPath.row];
        [cell putContentInfo:item];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ContactsItem *item = self.dataArray[indexPath.row];
    
    EditeContactViewController *editeVC = [[EditeContactViewController alloc] initWithNibName:NSStringFromClass([EditeContactViewController class]) bundle:[NSBundle mainBundle]];
    editeVC.item = item;
    
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
