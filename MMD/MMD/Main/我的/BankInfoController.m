//
//  BankInfoController.m
//  MMD
//
//  Created by pencho on 16/4/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BankInfoController.h"
#import "ColorHeader.h"
#import "QueryIdModel.h"
#import "BankItem.h"
#import "AppUserInfoHelper.h"


@interface BankInfoController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankCityLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;


@property (strong, nonatomic)BankItem *item;

@end

@implementation BankInfoController

- (BankItem *)item{
    if (!_item) {
        _item = [BankItem new];
    }
    return _item;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    // Do any additional setup after loading the view from its nib.

    [self configureButtons];
    [self ezgetBankInfo];
}
- (void)ezgetBankInfo{

    NSDictionary *userInfo = [AppUserInfoHelper userInfo];
    
    NSString *name = userInfo[@"name"];
    self.item.name = name;
    
    NSString *idNumber = userInfo[@"idcard"];
    self.item.idNumber = idNumber;
    
    NSDictionary *userBank = [AppUserInfoHelper userBank];
    
    NSString *bankNumber = userBank[@"bankCard"];
    self.item.bankNumber = bankNumber;
    
    NSString *bankName = userBank[@"deposit"];
    self.item.bankName = bankName;
    
    NSString *province = userBank[@"province"];
    NSString *city = userBank[@"city"];
    NSString *area = userBank[@"area"];
    
    NSString *bankCity = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    self.item.bankCity = bankCity;
    
    
    [self setBankInfo];
}
- (void)setBankInfo{
    
    self.nameLabel.text = self.item.name;
    self.idNumberLabel.text = self.item.idNumber;
    self.bankNumberLabel.text = self.item.bankNumber;
    self.bankNameLabel.text = self.item.bankName;
    self.bankCityLabel.text = self.item.bankCity;
}
- (void)configureButtons{
    
    self.changeButton.backgroundColor = REDCOLOR;
    self.changeButton.layer.cornerRadius = 10.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeBankInfoAction:(id)sender {
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
