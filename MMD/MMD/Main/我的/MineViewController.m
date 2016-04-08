//
//  MineViewController.m
//  MMD
//
//  Created by pencho on 16/4/4.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MineViewController.h"
#import "ConstantTitle.h"
#import "MoreTableViewCell.h"
#import "MineHeaderTableViewCell.h"
#import <NSArray+YYAdd.h>
#import <YYCGUtilities.h>
#import "ImagesTitles_Mine_Header.h"
#import "MoreCellUIItem.h"
#import "MoreTableViewCell+MineUIInfo.h"
#import "ColorHeader.h"
#import "MineCellActionHelper.h"

CGFloat const kEDGELENGTH = 20;

static NSString * const headerCellId = @"MineHeaderCellId";
static NSString * const bodyCellId = @"moreCellId";

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation MineViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSString *titleListPath = [[NSBundle mainBundle] pathForResource:ImagesTitles_Mine ofType:@"plist"];
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
    self.view.backgroundColor = BACKGROUNDCOLOR;
    // Do any additional setup after loading the view.
    [self initTableView];
}
- (void)initTableView{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(kEDGELENGTH, 0, kScreenWidth- 2 * kEDGELENGTH, kScreenHeight) style:UITableViewStyleGrouped];
    _mainTableView.backgroundColor = [UIColor clearColor];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.estimatedRowHeight = 44;

    _mainTableView.showsHorizontalScrollIndicator = _mainTableView.showsVerticalScrollIndicator = NO;
    [_mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MineHeaderTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:headerCellId];
    [_mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoreTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:bodyCellId];
    [self.view addSubview:_mainTableView];
}
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 3;
    }else if (section == 3){
        return 2;
    }else if (section == 4){
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MineHeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:headerCellId forIndexPath:indexPath];
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headerCell;
    }else{
        MoreTableViewCell *bodyCell = [tableView dequeueReusableCellWithIdentifier:bodyCellId forIndexPath:indexPath];
        NSArray *section = self.dataArray[indexPath.section - 1];
        MoreCellUIItem *item = section[indexPath.row];
        [bodyCell putValue:item];
        return bodyCell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 132;
    }else{
        return 44;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //除了第一组cell(不响应点击事件)
    if (indexPath.section != 0) {
        [MineCellActionHelper jumpFromViewController:self atIndex:indexPath];
    }
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
