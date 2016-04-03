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
#import "MoreCellUIItem.h"
#import "MoreTableViewCell+InitMoreCellUI.h"
#import "ImagesTitles_More_Header.h"
//将所有的(除了分享)跳转逻辑抽离到以下类
#import "MoreCellActionHelper.h"




static NSString *cellId = @"moreCellId";
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataArray;

@end

@implementation MoreViewController

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        NSString *titleListPath = [[NSBundle mainBundle] pathForResource:ImagesTitles_More ofType:@"plist"];
        NSData *imagesTitleData = [NSData dataWithContentsOfFile:titleListPath];
        NSArray *tempDataArray = [NSMutableArray arrayWithPlistData:imagesTitleData];
        NSLog(@"data转换  %@",tempDataArray);
        for (NSInteger k = 0; k < tempDataArray.count; k ++) {
            NSMutableArray *singleCellArray = [NSMutableArray array];
            NSArray *oneSection = tempDataArray[k];
            NSLog(@"每一个组 %@",oneSection);
            for (NSInteger j = 0; j < oneSection.count; j ++) {
                MoreCellUIItem *item = [MoreCellUIItem new];
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
        return 2;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 3;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *moreCell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    NSArray *section = self.dataArray[indexPath.section];
    MoreCellUIItem *item = section[indexPath.row];
    [moreCell putValue:item];
    if (indexPath.section == 2 && indexPath.row == 2) {
        [moreCell addVersionLabelAfterHideGoButton];
        moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return moreCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
//控制cell不被点击
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 2) {
        return nil;
    }
    return indexPath;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //分享有可能特殊
    if (indexPath.section == 2 && indexPath.row == 1) {
        [self shareMMD];
    }else{
        [MoreCellActionHelper jumpFromViewController:self atIndex:indexPath];
    }
}
#pragma mark ShareAction

- (void)shareMMD{
    
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
