//
//  ServiceCenterController.m
//  MMD
//
//  Created by pencho on 16/4/27.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ServiceCenterController.h"
#import "ColorHeader.h"
#import "ConstantTitle.h"
#import <YYTextKeyboardManager.h>
#import "ChatModel.h"
#import <MJRefresh.h>
#import "EZMessageCell.h"
#import "UUMessageFrame.h"
#import "QueryMessageModel.h"
#import "TrasferMessageDic.h"
#import <YYCache.h>
#import <YYDiskCache.h>

#import "AppUserInfoHelper.h"

static NSInteger const size = 10;
static NSString *testCellId = @"messageCell";
static NSString * const messageFile = @"Message";

@interface ServiceCenterController ()<UITableViewDataSource,UITableViewDelegate,YYTextKeyboardObserver>

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inputTextItem;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottom;


@property (strong, nonatomic)ChatModel *chatModel;

@property (strong, nonatomic)YYCache *fileCache;
@property (assign, nonatomic)NSInteger pageNum;


@end

@implementation ServiceCenterController

- (YYCache *)fileCache{
    
    if (!_fileCache) {
        
        NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [cacheFolder stringByAppendingPathComponent:messageFile];
        _fileCache = [YYCache cacheWithPath:path];
    }
    return _fileCache;
}
- (ChatModel *)chatModel{
    if (!_chatModel) {
        _chatModel = [ChatModel new];
        _chatModel.isGroupChat = NO;
        _chatModel.dataSource = [NSMutableArray array];
    }
    return _chatModel;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[YYTextKeyboardManager defaultManager] addObserver:self];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = SUPPORTCENTER_TITLE;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self configureTableView];
    //请求聊天记录
    [self queryMessageList];
}

- (void)saveMessagesList:(NSArray *)messages{
    
    if (!messages) {
        messages = [NSArray array];
    }
    NSNumber *userIdNum = [AppUserInfoHelper tokenAndUserIdDictionary][@"userId"];
    NSString *userId  = [userIdNum stringValue];
    
    BOOL exist = [self.fileCache containsObjectForKey:userId];
    //如果存在
    if (exist) {
        NSMutableDictionary *messageDic = (NSMutableDictionary *)[self.fileCache objectForKey:userId];
        NSArray *data = messageDic[@"messages"];
        NSMutableArray *muData = [NSMutableArray arrayWithArray:data];
        for (NSInteger k = 0; k < messages.count; k ++) {
            NSDictionary *oneMessageDic = messages[k];
            [muData addObject:oneMessageDic];
        }
        [messageDic setObject:muData forKey:@"messages"];
        [self.fileCache setObject:messageDic forKey:userId];
    }else{
        //不存在
        NSMutableDictionary *baseDic = [NSMutableDictionary dictionaryWithObject:userId forKey:@"userId"];
        [baseDic setObject:messages forKey:@"messages"];
        [self.fileCache setObject:baseDic forKey:userId];
    }
    self.fileCache.diskCache.customFileNameBlock = ^(NSString *key){
        return userId;
    };
    //增加数据
    
    NSArray *data = [self.fileCache objectForKey:userId][@"messages"];
    for (NSInteger k = 0; k < data.count; k ++) {
        NSDictionary *oneMessageDic = data[k];
        [self.chatModel addSpecifiedItem:oneMessageDic];
    }
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}
- (void)queryMessageList{
    
    [QueryMessageModel getMessageList:nil success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            NSArray *data = resultDic[@"data"];
            [self saveMessagesList:data];
        }
    } failure:^(NSError *error) {
        [self saveMessagesList:nil];
    }];
}
- (void)configureTableView{
    
    [self.chatTableView registerClass:[EZMessageCell class] forCellReuseIdentifier:testCellId];
    
    self.chatTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self requestPreviousData:YES];
    }];
    self.chatTableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [self requestPreviousData:NO];
    }];
    self.chatTableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.chatTableView.mj_header.backgroundColor = self.chatTableView.mj_footer.backgroundColor = [UIColor clearColor];
    NSLog(@"刷新头 = %@  尾部 = %@",self.chatTableView.mj_header,self.chatTableView.mj_footer);
}
- (void)requestPreviousData:(BOOL)isPrevious{
    
    //请求消息
    if ([self.chatTableView.mj_header isRefreshing]) {
        [self.chatTableView.mj_header endRefreshing];
    }
    if ([self.chatTableView.mj_footer isRefreshing]) {
        [self.chatTableView.mj_footer endRefreshing];
    }
}
//tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (self.chatModel.dataSource.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (void)dealTheFunctionData:(NSDictionary *)dic
{
    [self.chatModel addSpecifiedItem:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}
- (IBAction)inputAction:(id)sender {
    [self.inputField becomeFirstResponder];
}
- (IBAction)sendMessageAction:(id)sender {
    [self.inputField resignFirstResponder];
    [self dealTheFunctionData:nil];
}
#pragma mark YYTextKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition{
    
    YYTextKeyboardManager *manager = [YYTextKeyboardManager defaultManager];
    CGRect toFrame =  [manager convertRect:transition.toFrame toView:self.view];
    BOOL fromVisible = transition.fromVisible;
    BOOL toVisible = transition.toVisible;
    if (!fromVisible && toVisible) {
        self.toolBarBottom.constant = toFrame.size.height;
        [self tableViewScrollToBottom];
    }
    if (fromVisible && !toVisible) {
        self.toolBarBottom.constant = 0;
    }
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.chatModel.dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:testCellId forIndexPath:indexPath];
    [cell setMessageFrame:self.chatModel.dataSource[indexPath.row]];
//    cell.messageFrame = self.chatModel.dataSource[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.chatModel.dataSource[indexPath.row] cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
