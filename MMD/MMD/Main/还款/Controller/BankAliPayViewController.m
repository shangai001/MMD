//
//  BankAliPayViewController.m
//  MMD
//
//  Created by pencho on 16/4/20.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BankAliPayViewController.h"
#import "ColorHeader.h"
#import "BankViewController.h"
#import "AppUserInfoHelper.h"
#import "AliPayViewController.h"




@interface BankAliPayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *bankButton;
@property (weak, nonatomic) IBOutlet UIButton *aliPayButton;

@end

@implementation BankAliPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.bankButton.backgroundColor = self.aliPayButton.backgroundColor = REDCOLOR;
    self.bankButton.layer.cornerRadius = self.aliPayButton.layer.cornerRadius = 10.0f;
    self.bankButton.tintColor = self.aliPayButton.tintColor = [UIColor whiteColor];
}
- (IBAction)bankPayAction:(id)sender {
    
    BankViewController *bank = [BankViewController new];
    bank.title = @"银行还款";
    NSString *userId = [AppUserInfoHelper tokenAndUserIdDictionary][@"userId"];
    NSString *token =  [AppUserInfoHelper tokenAndUserIdDictionary][@"token"];
    bank.URLString = [NSString stringWithFormat:@"%@/webview/repayByBank?repayAmount=%@&userId=%@&token=%@",kHostURL,self.repayAmount,userId,token];
    [self.navigationController pushViewController:bank animated:YES];
    
}
- (IBAction)aliPayAction:(id)sender {
    
    AliPayViewController *aliPay = [AliPayViewController new];
    aliPay.title = @"支付宝还款";
    NSString *userId = [AppUserInfoHelper tokenAndUserIdDictionary][@"userId"];
    NSString *token =  [AppUserInfoHelper tokenAndUserIdDictionary][@"token"];
    aliPay.URLString = [NSString stringWithFormat:@"%@/webview/repayByZfb?repayAmount=%@&userId=%@&token=%@",kHostURL,self.repayAmount,userId,token];
    [self.navigationController pushViewController:aliPay animated:YES];
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
