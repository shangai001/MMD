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
#import "RefundWebController.h"
#import "MMDInfoWebController.h"
#import "MessageCenterController.h"
#import "SupportCenterController.h"
#import "ImagesTitles_More_Header.h"


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
    
    MessageCenterController *messageCenter = [MessageCenterController new];
    [more.navigationController pushViewController:messageCenter animated:YES];
}
+ (void)gotoSupportCenter:(MoreViewController *)more{
    
    SupportCenterController *supportCenter = [SupportCenterController new];
    [more.navigationController pushViewController:supportCenter animated:YES];
}
+ (void)gotoLoanRules:(MoreViewController *)more{
    
    LoanRulesWebController *loanRuler = [[LoanRulesWebController alloc] init];
    loanRuler.URLString = [NSString stringWithFormat:@"%@/webview/applyNotice",kHostURL];
    [more.navigationController pushViewController:loanRuler animated:YES];
}
+ (void)gotoRefundRules:(MoreViewController *)more{
    
    RefundWebController *refunder = [[RefundWebController alloc] init];
    refunder.URLString = [NSString stringWithFormat:@"%@/webview/repaymentNotice",kHostURL];
    [more.navigationController pushViewController:refunder animated:YES];
}
+ (void)aboutMMD:(MoreViewController *)more{
    
    MMDInfoWebController *mmdInfoer = [[MMDInfoWebController alloc] init];
    mmdInfoer.URLString = [NSString stringWithFormat:@"%@/webview/about",kHostURL];
    [more.navigationController pushViewController:mmdInfoer animated:YES];
}
@end
