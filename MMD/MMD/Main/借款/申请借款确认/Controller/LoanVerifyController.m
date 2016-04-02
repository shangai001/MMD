//
//  LoanVerifyController.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoanVerifyController.h"
#import "HeightHeader.h"
#import "FormTableViewCell.h"
#import "HeaderLabel.h"
#import "FormItem.h"
#import "FormTableViewCell+PutValue.h"


#define EDGELENGTH 10

static NSString *cellReuseId = @"formTableCellId";

@interface LoanVerifyController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation LoanVerifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请借款确认";
    [self initTableView];
    [self requestData];
}
- (void)requestData{
    self.dataArray = [NSMutableArray array];
    for (NSUInteger k = 0; k < 3; k ++) {
        NSMutableArray *sectionArray = [NSMutableArray array];
        for (NSUInteger q = 0; q < 3; q ++) {
            FormItem *item = [FormItem new];
            item.pTitle = @"借款人信息";
            item.detailText = @"借钱是要还的";
            [sectionArray addObject:item];
        }
        [self.dataArray addObject:sectionArray];
    }
}
- (void)initTableView{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(EDGELENGTH, 0, kScreenWidth- 2 * EDGELENGTH, kScreenHeight) style:UITableViewStyleGrouped];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.estimatedRowHeight = 44;
    _mainTableView.estimatedSectionHeaderHeight = 30;
    _mainTableView.showsHorizontalScrollIndicator = _mainTableView.showsVerticalScrollIndicator = NO;
    [_mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FormTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellReuseId];
    [self.view addSubview:_mainTableView];
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
        return 3;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    FormItem *item = [self currentItem:indexPath];
    [cell putValue:item];
    return cell;
}
- (FormItem *)currentItem:(NSIndexPath *)indexPath{
    
    if (indexPath.section >= self.dataArray.count)  return nil;
    
    NSArray *sectionArray = self.dataArray[indexPath.section];
    
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.row >= sectionArray.count)  return nil;
    
    FormItem *item = (FormItem *)sectionArray[indexPath.row];
    
    return item;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [HeaderLabel initHeaderLabel:CGSizeMake(tableView.frame.size.width, 30)];
    label.text = @"借款人信息";
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
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
