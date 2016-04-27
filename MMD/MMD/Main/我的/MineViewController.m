//
//  MineViewController.m
//  MMD
//
//  Created by pencho on 16/4/4.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MineViewController.h"
#import "ConstantTitle.h"
#import "ConstantNotiName.h"
#import "MoreTableViewCell.h"
#import "MineHeaderTableViewCell.h"
#import <NSArray+YYAdd.h>
#import <YYCGUtilities.h>
#import "ImagesTitles_Mine_Header.h"
#import "MoreCellUIItem.h"
#import "MoreTableViewCell+MineUIInfo.h"
#import "ColorHeader.h"
#import "MineCellActionHelper.h"
#import "MineHeaderTableViewCell+UserInfo.h"
#import "LoggoutTableViewCell.h"
#import "MMDLoggin.h"
#import "LogoutModel.h"
#import <SVProgressHUD.h>


CGFloat const kEDGELENGTH = 20;

static NSString * const headerCellId = @"MineHeaderCellId";
static NSString * const bodyCellId = @"moreCellId";
static NSString * const loggoutCellId = @"loggoutCellId";

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)BOOL logStatus;

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
    }
    return _dataArray;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"我的";
    // Do any additional setup after loading the view.
    self.logStatus = [MMDLoggin isLoggin];
    [self initTableView];
    [self registerNotifications];
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
    [_mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LoggoutTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:loggoutCellId];
    [self.view addSubview:_mainTableView];
}
- (void)registerNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin:) name:UserDidLogin object:nil];
}
- (void)userLogin:(id)sender{
    self.logStatus = YES;
    [self.mainTableView reloadData];
}
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_logStatus) {
        return 6;
    }
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
    if (_logStatus && section == 5) {
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf;
    if (indexPath.section == 0) {
        MineHeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:headerCellId forIndexPath:indexPath];
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //本地查询用户信息
        [headerCell setCurrentUserInfo];
        return headerCell;
    }else{
        if (indexPath.section != 5) {
            MoreTableViewCell *bodyCell = [tableView dequeueReusableCellWithIdentifier:bodyCellId forIndexPath:indexPath];
            bodyCell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *section = self.dataArray[indexPath.section - 1];
            MoreCellUIItem *item = section[indexPath.row];
            [bodyCell putMineUIValue:item];
            return bodyCell;
        }else{
            LoggoutTableViewCell *bottomCell = [tableView dequeueReusableCellWithIdentifier:loggoutCellId forIndexPath:indexPath];
            bottomCell.logouHandler = ^(){
                [weakSelf logoutAction:nil];
            };
            bottomCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return bottomCell;
        }
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
    if (indexPath.section != 0 && indexPath.section != 5) {
        [MineCellActionHelper jumpFromViewController:self atIndex:indexPath];
    }
}
- (void)logoutAction:(id)sender{
    //退出
    [SVProgressHUD show];
    [LogoutModel logoutUserSuccess:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            self.logStatus = NO;
            @synchronized (self) {
                [SDUserDefault setBool:NO forKey:Loggin];
            }
            [self.mainTableView reloadData];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogout object:nil];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];

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
