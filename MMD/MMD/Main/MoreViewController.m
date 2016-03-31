//
//  MoreViewController.m
//  MMD
//
//  Created by pencho on 16/3/31.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MoreViewController.h"
#import "ColorHeader.h"
#import "MoreTableViewCell.h"
#import <NSArray+YYAdd.h>
#import "MoreItem.h"
#import "MoreTableViewCell+PutValue.h"

static NSString *cellId = @"moreCellId";
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataArray;

@end

@implementation MoreViewController

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        NSString *titleListPath = [[NSBundle mainBundle] pathForResource:@"ImagesTitles" ofType:@"plist"];
        NSData *imagesTitleData = [NSData dataWithContentsOfFile:titleListPath];
        NSArray *tempDataArray = [NSMutableArray arrayWithPlistData:imagesTitleData];
        NSLog(@"data转换  %@",tempDataArray);
        for (NSInteger k = 0; k < tempDataArray.count; k ++) {
            NSMutableArray *singleCellArray = [NSMutableArray array];
            
            
            NSArray *oneSection = tempDataArray[k];
            NSLog(@"每一个组 %@",oneSection);
            for (NSInteger j = 0; j < oneSection.count; j ++) {
                MoreItem *item = [MoreItem new];
                NSDictionary *infoDic = oneSection[j];
                item.imageName = infoDic[@"imageName"];
                item.title = infoDic[@"title"];
                [singleCellArray addObject:item];
            }
            [_dataArray addObject:singleCellArray];
        }
        NSLog(@"构建玩  %@",_dataArray);
        
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the vview.
    [self setupTableView];
}
- (void)setupTableView{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoreTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
}
#pragma mark UITabbleviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 5;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *moreCell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    NSArray *section = self.dataArray[indexPath.section];
    MoreItem *item = section[indexPath.row];
    [moreCell putValue:item];
    return moreCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
