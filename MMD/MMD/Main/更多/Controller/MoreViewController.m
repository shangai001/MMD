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
#import "ConstantTitle.h"
//将所有的(除了分享)跳转逻辑抽离到以下类
#import "MoreCellActionHelper.h"
#import "MineModel.h"
#import <UIView+WZLBadge.h>




static NSString * const cellId = @"moreCellId";

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataArray;


@property (assign, nonatomic)NSInteger centerUnReadCount;
@property (assign, nonatomic)NSInteger servicesUnReadCount;
@end

@implementation MoreViewController

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        NSString *titleListPath = [[NSBundle mainBundle] pathForResource:MORE_IMAGETITLE_FILENAME ofType:@"plist"];
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self queryNoCenterUnreadCount];
    [self queryServiceUnReadCount];
}
//查询消息中心未读数目
- (void)queryNoCenterUnreadCount{
    [MineModel queryNotificationCenter:nil success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            self.centerUnReadCount = [resultDic[@"data"] integerValue];
        }
        //TEST
//        self.centerUnReadCount = 2;
    } failure:^(NSError *error) {
        
    }];
}
- (void)queryServiceUnReadCount{
    [MineModel queryServiceUnReadCount:nil success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            NSNumber *unRead = resultDic[@"data"][@"userNoRead"];
            self.servicesUnReadCount = [unRead integerValue];
        }
        //TEST
//        self.servicesUnReadCount = 2;
    } failure:^(NSError *error) {
        
    }];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
    [moreCell putMoreUIValue:item];
    moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    [self setUnReadInfo:indexPath cell:moreCell];
    if (indexPath.section == 2 && indexPath.row == 2) {
        [moreCell addVersionLabelAfterHideGoButton];
    }
    return moreCell;
}
- (void)setCenterUnReadCount:(NSInteger)centerUnReadCount{
    _centerUnReadCount = centerUnReadCount;
    if (_centerUnReadCount > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        MoreTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self setUnReadInfo:indexPath cell:cell];
    }
}
- (void)setServicesUnReadCount:(NSInteger)servicesUnReadCount{
    _servicesUnReadCount = servicesUnReadCount;
    if (_servicesUnReadCount > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        MoreTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self setUnReadInfo:indexPath cell:cell];
    }
}
- (void)setUnReadInfo:(NSIndexPath *)indexPath cell:(MoreTableViewCell *)cell{
    
    if (indexPath.section == 0) {
        cell.titleLabel.badgeCenterOffset = CGPointMake(20, 20);
        if (indexPath.row == 0) {
            //消息中心
            if (self.centerUnReadCount > 0) {
                [cell.titleLabel showBadge];
            }else{
                [cell.titleLabel clearBadge];
            }
        }
        if (indexPath.row == 1) {
            //客服中心
            if (self.servicesUnReadCount > 0) {
                [cell.titleLabel showBadge];
            }else{
                [cell.titleLabel clearBadge];
            }
        }
    }
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
