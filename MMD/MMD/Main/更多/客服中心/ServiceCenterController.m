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
#import "AppUserInfoHelper.h"
#import "TransferDate.h"
#import <SVProgressHUD.h>
#import "MessageSaver.h"




//static NSInteger const size = 10;
static NSString *testCellId = @"messageCell";
static NSString * const messageFile = @"Message";

@interface ServiceCenterController ()<UITableViewDataSource,UITableViewDelegate,YYTextKeyboardObserver,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inputTextItem;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottom;


@property (strong, nonatomic)ChatModel *chatModel;

@property (assign, nonatomic)NSInteger pageNum;
@property (strong, nonatomic)NSTimer *timer;

@property (strong, nonatomic)NSMutableDictionary *mesDic;
@property (copy, nonatomic)NSString *userId;
@end

@implementation ServiceCenterController

- (NSMutableDictionary *)mesDic{
    if (!_mesDic) {
        _mesDic = [NSMutableDictionary dictionary];
    }
    return _mesDic;
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
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = SUPPORTCENTER_TITLE;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self configureTableView];
    //请求聊天记录
    [self queryMessageList];
    [self addTimerForQueryData];
    [self registerNotification];
}
- (void)addTimerForQueryData{
    
}
- (void)registerNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWillShow:(NSNotification *)sender{
    
    NSDictionary* info = [sender userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"height:%f",kbSize.height);
    if (kbSize.height > 0) {
        self.toolBarBottom.constant = kbSize.height;
        [self tableViewScrollToBottomAfterDelay:1];
    }
}
- (void)keyboardWillHide:(id)sender{
    self.toolBarBottom.constant = 0;
    [self tableViewScrollToBottomAfterDelay:1];
}
- (void)saveMessagesList:(NSArray *)messages{
    
    if (!messages) {
        messages = [NSArray array];
    }
    //先取聊天记录
    NSMutableDictionary *messageDic = [MessageSaver messageListWithUser:self.userId];
    NSMutableArray *data = [NSMutableArray array];
    
    if (messageDic) {
        //如果有
        data = messageDic[@"data"];
    }else{
        //如果没有
        messageDic = [NSMutableDictionary dictionary];
    }
    
    for (NSInteger k = 0; k < messages.count; k ++) {
        NSDictionary *oneDic = messages[k];
        [data addObject:oneDic];
    }
    [messageDic removeObjectForKey:@"data"];
    [messageDic setObject:data forKey:@"data"];
    [messageDic setObject:self.userId forKey:@"userId"];
    
    if ([MessageSaver saveMessages:messageDic user:self.userId]) {
        [self.chatModel.dataSource removeAllObjects];
        NSArray *dataArray = [MessageSaver messageListWithUser:self.userId][@"data"];
        for (NSInteger j = 0; j < dataArray.count; j ++) {
            
            NSDictionary *oneMessageDic = data[j];
            [self.chatModel addSpecifiedItem:oneMessageDic];
        }
        [self.chatTableView reloadData];
        if (self.toolBarBottom.constant == 0) {
            [self tableViewScrollToBottomAfterDelay:1];
        }
    }
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
    
    NSNumber *userIdNum = [AppUserInfoHelper tokenAndUserIdDictionary][@"userId"];
    self.userId = [NSString stringWithFormat:@"%@",userIdNum];
    
    [self.chatTableView registerClass:[EZMessageCell class] forCellReuseIdentifier:testCellId];
//    self.chatTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        [self requestPreviousData:YES];
//    }];
//    self.chatTableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
//        [self requestPreviousData:NO];
//    }];
//    self.chatTableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.chatTableView.mj_header.backgroundColor = self.chatTableView.mj_footer.backgroundColor = [UIColor clearColor];
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
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}
- (void)dealTheFunctionData:(NSDictionary *)dic
{
    NSArray *oneMessageArry = @[dic];
    [self saveMessagesList:oneMessageArry];
}
//延迟几秒滑到底部
- (void)tableViewScrollToBottomAfterDelay:(NSTimeInterval)seconds{
    
    WeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [weakSelf tableViewScrollToBottom];
        
    });
}
- (IBAction)inputAction:(id)sender {
    [self.inputField becomeFirstResponder];
}
- (IBAction)sendMessageAction:(id)sender {
    
    [self.inputField resignFirstResponder];
    //构造 dic,用户发送的 dic
    [SVProgressHUD show];
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSString *currentTime = [TransferDate getYYYYMMDDHHMMSS_DateWith:interval];
    [self.mesDic setObject:currentTime forKey:@"createTimeStr"];
    [self.mesDic setObject:self.userId forKey:@"userId"];
    [self.mesDic setObject:@(0) forKey:@"type"];
    
    [QueryMessageModel sendMessage:self.mesDic success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            [self dealTheFunctionData:self.mesDic];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
    }];
}
#pragma mark YYTextKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition{
    /*
    YYTextKeyboardManager *manager = [YYTextKeyboardManager defaultManager];
    CGRect toFrame =  [manager convertRect:transition.toFrame toView:self.view];
    BOOL fromVisible = transition.fromVisible;
    BOOL toVisible = transition.toVisible;
    UIView *keyboardView = manager.keyboardView;
    NSLog(@"view 高度 %@",keyboardView);
    if (!fromVisible && toVisible) {
        self.toolBarBottom.constant = toFrame.size.height;
        [self tableViewScrollToBottomAfterDelay:1];
    }
    if (fromVisible && !toVisible) {
        self.toolBarBottom.constant = 0;
    }
     */
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.chatModel.dataSource.count;
}
#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.inputField]) {
        NSString *message = textField.text;
        [self.mesDic setObject:message forKey:@"content"];
        textField.text = nil;
    }
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:testCellId forIndexPath:indexPath];
    [cell setMessageFrame:self.chatModel.dataSource[indexPath.row]];
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
