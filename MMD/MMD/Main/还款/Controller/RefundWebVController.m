//
//  RefundWebVController.m
//  MMD
//
//  Created by pencho on 16/4/20.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RefundWebVController.h"
#import "ColorHeader.h"
#import <UIView+SDAutoLayout.h>
#import "RBViewController.h"
#import "BankAliPayViewController.h"
#import "AppUserInfoHelper.h"
#import "AppInfo.h"

CGFloat buttonHeight = 44;

@interface RefundWebVController ()

@property (nonatomic, strong)UIButton *bankButton;
@property (nonatomic, strong)UIButton *repayButton;
@property (nonatomic, strong)UIView *bottomView;

@end

@implementation RefundWebVController

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (UIButton *)bankButton{
    if (!_bankButton) {
        _bankButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_bankButton setTitle:@"银行付款/支付宝转账" forState:UIControlStateNormal];
        [_bankButton setTintColor:REDCOLOR];
        _bankButton.backgroundColor = [UIColor whiteColor];
        [_bankButton addTarget:self action:@selector(moveToBankRepay:) forControlEvents:UIControlEventTouchUpInside];
        _bankButton.layer.borderWidth = 0.5f;
        _bankButton.layer.borderColor = REDCOLOR.CGColor;
        _bankButton.layer.masksToBounds = YES;
        _bankButton.layer.cornerRadius = 10.0f;
    }
    return  _bankButton;
}
- (UIButton *)repayButton{
    if (!_repayButton) {
        _repayButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_repayButton setTitle:@"在线支付" forState:UIControlStateNormal];
        [_repayButton setTintColor:[UIColor whiteColor]];
        _repayButton.backgroundColor = REDCOLOR;
        [_repayButton addTarget:self action:@selector(moveToOnlineRepay:) forControlEvents:UIControlEventTouchUpInside];
        _repayButton.layer.cornerRadius = 10;
        _repayButton.layer.masksToBounds = YES;
    }
    return _repayButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"借款详情";
    [self configureBottomView];
}
- (void)configureBottomView{
    
    [self.view addSubview:self.bottomView];
    
    self.bottomView.sd_layout.leftEqualToView(self.view).heightIs(2 * buttonHeight + 10).rightEqualToView(self.view).bottomEqualToView(self.view);
    [self.bottomView updateLayout];
    
    [self decideRepay];
}
- (void)decideRepay{
    
    [self.bottomView addSubview:self.repayButton];
    self.repayButton.sd_layout.leftSpaceToView(self.bottomView,5).heightIs(buttonHeight).rightSpaceToView(self.bottomView,5).topSpaceToView(self.bottomView,5);
    
    [self.bottomView addSubview:self.bankButton];
    self.bankButton.sd_layout.leftSpaceToView(self.bottomView,5).topSpaceToView(self.repayButton,5).rightSpaceToView(self.bottomView,5).heightIs(buttonHeight);
    [self.bankButton updateLayout];
}
- (void)moveToOnlineRepay:(id)sender{
    
    //融宝支付 H5
    RBViewController *rb = [RBViewController new];
    NSString *title = @"米米贷借贷还款";
    NSString *body = [NSString stringWithFormat:@"偿还借款第%@期",self.terms];
    NSString *imei = [AppInfo UUIDString];
    NSString *userId = [AppUserInfoHelper tokenAndUserIdDictionary][@"userId"];
    NSString *token = [AppUserInfoHelper tokenAndUserIdDictionary][@"token"];
    rb.URLString = [NSString stringWithFormat:@"%@/reapal/pay?title=%@&body=%@&totalFee=%@&userId=%@&token=%@&orderNo=%@&imei=%@",kHostURL,title,body,self.totalFee,userId,token,self.orderNo,imei];
    rb.URLString = [self encodeToPercentEscapeString:rb.URLString];
    NSLog(@"融宝 H5 = %@",rb.URLString);
    [self.navigationController pushViewController:rb animated:YES];
}
//将 URL 中的 中文 编码
- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                       NULL, /* allocator */
                                                                                       (__bridge CFStringRef)input,
                                                                                       NULL, /* charactersToLeaveUnescaped */
                                                                                       (CFStringRef)@"!*'();@+$,#[]",kCFStringEncodingUTF8);
    return outputStr;
}
- (void)moveToBankRepay:(id)sender{
    
    BankAliPayViewController *baPay = [BankAliPayViewController new];
    baPay.repayAmount = self.totalFee;
    [self.navigationController pushViewController:baPay animated:YES];
  
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
