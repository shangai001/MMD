//
//  MoreCellActionHelper.m
//  MMD
//
//  Created by pencho on 16/4/4.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MoreCellActionHelper.h"
#import "MoreViewController.h"
#import "LoanRulesWebController.h"
#import "ProtocoRefundlWebController.h"
#import "MMDInfoWebController.h"
#import "MessageCenterController.h"
//#import "SupportCenterController.h"
#import "ColorHeader.h"

#import "MQChatViewManager.h"
#import "MQAssetUtil.h"

#import "HandleUserStatus.h"
#import "MMDLoggin.h"
#import "LogginHandler.h"



@implementation MoreCellActionHelper

+ (void)jumpFromViewController:(MoreViewController *)originalController
                       atIndex:(NSIndexPath *)indexPath{
    
    NSInteger section =  indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section) {
        case 0:
        {
            if (row == 0) {
                [self gotoMessageCenter:originalController];
            }else if (row == 1){
                [self gotoSupportCenter:originalController];
            }
        }
            break;
        case 1:
        {
            if (row == 0) {
                [self gotoLoanRules:originalController];
            }else{
                [self gotoRefundRules:originalController];
            }
        }
            break;
        case 2:
        {
            if (row == 0) {
                [self aboutMMD:originalController];
            }else if (row ==1){
//                [self shareMMD];
            }
        }
            break;
        default:
            break;
    }

    
}
#pragma mark GoToSubView
+ (void)gotoMessageCenter:(MoreViewController *)more{
    
    if ([MMDLoggin isLoggin]) {
        //检查用户状态
        if ([HandleUserStatus handleUserStatusAt:more]) {
            MessageCenterController *messageCenter = [MessageCenterController new];
            messageCenter.hidesBottomBarWhenPushed = YES;
            [more.navigationController pushViewController:messageCenter animated:YES];
        }
    }else{
        [LogginHandler shouldLogginAt:more];
    }
    
}
+ (void)gotoSupportCenter:(MoreViewController *)more{
    
    if ([MMDLoggin isLoggin]) {
        
        if ([HandleUserStatus handleUserStatusAt:more]) {
            MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
            //隐藏底部 tabbar
            [chatViewManager hidesBottomBarWhenPushed:YES];

            //默认欢迎短语
            [chatViewManager setChatWelcomeText:@"您好,请问有什么可以帮助您？"];
            [chatViewManager setAgentName:@"米米贷客服"];
            [chatViewManager setNavTitleText:@"客服中心"];
            
            
            [chatViewManager enableSendVoiceMessage:false];
            [chatViewManager enableSendImageMessage:NO];
            //圆角头像
            [chatViewManager enableRoundAvatar:YES];
            [chatViewManager enableIncomingAvatar:YES];
            //底部刷新
            [chatViewManager enableBottomPullRefresh:YES];
            [chatViewManager setIncomingBubbleColor:Color(0.52, 0.75, 0.93, 1)];
            [chatViewManager setIncomingMessageTextColor:Color(0.50, 0.59, 0.65, 1)];
            //底部新消息提示
            [chatViewManager enableShowNewMessageAlert:true];
            [chatViewManager setOutgoingBubbleColor:Color(0.52, 0.75, 0.93, 1)];
            [chatViewManager setOutgoingMessageTextColor:[UIColor darkTextColor]];
            [chatViewManager pushMQChatViewControllerInViewController:more];
            
//            SupportCenterController *supportCenter = [SupportCenterController new];
//            supportCenter.hidesBottomBarWhenPushed = YES;
//            [more.navigationController pushViewController:supportCenter animated:YES];
        }

    }else{
        [LogginHandler shouldLogginAt:more];
    }
}
+ (void)gotoLoanRules:(MoreViewController *)more{
    
    LoanRulesWebController *loanRuler = [[LoanRulesWebController alloc] init];

    [more.navigationController pushViewController:loanRuler animated:YES];
}
+ (void)gotoRefundRules:(MoreViewController *)more{
    
    ProtocoRefundlWebController *refunder = [[ProtocoRefundlWebController alloc] init];
 
    [more.navigationController pushViewController:refunder animated:YES];
}
+ (void)aboutMMD:(MoreViewController *)more{
    
    MMDInfoWebController *mmdInfoer = [[MMDInfoWebController alloc] init];

    [more.navigationController pushViewController:mmdInfoer animated:YES];
}
@end
