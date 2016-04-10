//
//  FirstStepController.m
//  MMD
//
//  Created by pencho on 16/3/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "FirstStepController.h"
#import "VerifyItem.h"
#import "STPickerSingle.h"
#import "STPickerArea.h"
#import "ConstantTitle.h"
#import "ColorHeader.h"
#import "BankModel.h"
#import "AppUserInfoHelper.h"
#import "VerifyModel.h"
#import <MJExtension.h>
#import "ZCAddressBook.h"
#import "IDCardModel.h"
#import <SVProgressHUD.h>
#import "VerifyViewController.h"
#import "BaseNextButton.h"


NSInteger const ShouldCheckoutCredit = 0;



@interface FirstStepController ()<UITextFieldDelegate,STPickerAreaDelegate,STPickerSingleDelegate>

@property (nonatomic, strong)VerifyItem *item;
@property (nonatomic, strong)STPickerArea *cityPickerView;
@property (nonatomic, strong)STPickerSingle *backPickerView;
@property (weak, nonatomic) IBOutlet BaseNextButton *nextButon;
@property (strong, nonatomic)NSArray *bankArray;
@end

@implementation FirstStepController

- (NSArray *)bankArray{
    if (!_bankArray) {
        _bankArray = [NSArray array];
    }
    return _bankArray;
}
- (VerifyItem *)item{
    if (!_item) {
        _item = [VerifyItem new];
    }
    return _item;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self congureNextButton];
}
- (void)congureNextButton{
    self.nextButon.backgroundColor = REDCOLOR;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取系统通讯录
- (IBAction)systemAddressClick:(id)sender {
    [[ZCAddressBook shareControl]showPhoneViewWithTarget:self Block:^(BOOL isSuccess, NSDictionary *dic) {
        NSArray *selectedPerson = dic[@"telphone"];
        NSString *phoneNumber = [NSString stringWithFormat:@"%@",[selectedPerson lastObject]];
        NSString *fullName = [NSString stringWithFormat:@"%@%@",dic[@"first"],dic[@"last"]];
        self.contactPhoneNumberTextField.text = phoneNumber;
        self.contactNameTextField.text = fullName;
        self.item.urgentName = fullName;
        self.item.urgentPhone = phoneNumber;
    }];
}
#pragma mark STPickerAreaDelegate
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area{
    NSString *cityAddress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    self.item.bankArea = area;
    self.item.bankCity = city;
    self.item.bankProvince = province;
    self.cityTextField.text = cityAddress;
}
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle{
    self.bankTextField.text = selectedTitle;
    self.item.bankId = [self findBankIdWithBankName:selectedTitle];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_cityTextField]) {
        [self showAreaPicker];
        return NO;
    }
    if ([textField isEqual:_bankTextField]) {
        [self showBankPicker];
        return NO;
    }
    if ([textField isEqual:_contactPhoneNumberTextField]) {
        [self systemAddressClick:_contactPhoneNumberTextField];
        return NO;
    }
    return YES;
}// return NO to disallow editing.
- (NSMutableArray *)formatBankList:(NSArray *)data{
    self.bankArray =  data;
    NSMutableArray *bankArray = [NSMutableArray arrayWithCapacity:data.count];
    for (NSDictionary *dic in data) {
        NSString *name = dic[@"name"];
        [bankArray addObject:name];
    }
    return bankArray;
}
- (NSString *)findBankIdWithBankName:(NSString *)name{
    
    for (NSInteger k = 0; k < self.bankArray.count; k ++) {
        NSDictionary *bankDic = self.bankArray[k];
        NSString *dicName = bankDic[@"name"];
        if ([dicName isEqualToString:name]) {
            NSString *bankId = [NSString stringWithFormat:@"%@",bankDic[@"id"]];
            return bankId;
        }
    }
    return nil;
}
#pragma mark ShowPickerView
- (void)showAreaPicker{
    [self.view endEditing:YES];
    self.cityPickerView = [[STPickerArea alloc]init];
    [self.cityPickerView setDelegate:self];
    [self.cityPickerView setContentMode:STPickerContentModeBottom];
    [self.cityPickerView show];
}
- (void)showBankPicker{
    
    [self.view endEditing:YES];
    if (!self.backPickerView) {
        self.backPickerView = [[STPickerSingle alloc] init];
    }
    //加载本地数据
    /*
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BankList" ofType:@"plist"];
    NSData *arrayData = [NSData dataWithContentsOfFile:plistPath];
    NSMutableArray *backArray = [NSMutableArray arrayWithPlistData:arrayData];
     */
    [BankModel getBankList:nil completation:^(NSDictionary *resultDic) {
        NSArray *data = resultDic[@"data"];
        NSMutableArray *bankArray = [self formatBankList:data];
        [self.backPickerView setArrayData:bankArray];
        [self.backPickerView ez_reloadAllComponents];
        [self.backPickerView setTitle:@"请选择银行"];
        self.backPickerView.widthPickerComponent = 160;
        [self.backPickerView setContentMode:STPickerContentModeBottom];
        [self.backPickerView setDelegate:self];
        [self.backPickerView show];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark CheckoutId
- (void)checkoutCreditCard:(NSString *)crediteCardNumber{
    
    NSDictionary *cardDic = @{@"bankCard":crediteCardNumber};
    
    [BankModel checkCreditCard:cardDic completation:^(NSDictionary *resultDic) {
        NSLog(@"检查银行卡是否注册%@",resultDic);
    } failure:^(NSError *error) {
        
    }];
}
/*
- (void)checkoutIDCard:(NSString *)idcard{
    
    NSDictionary *idcardInfo = @{@"idcard":idcard};
    [IDCardModel checkoutIDCard:idcardInfo completation:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            self.item.cardNum = _cardTextField.text;
        }else{
            [SVProgressHUD showInfoWithStatus:resultDic[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        NSAssert(error, @"验证身份证出错");
    }];
}
*/

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //安卓版本没有
    /*
    if ([textField isEqual:_nameTextField]) {
        self.item.name = _nameTextField.text;
    }
    if ([textField isEqual:_idCardTextField]) {
        self.item.idCardNum = _idCardTextField.text;
        [self checkoutIDCard:_idCardTextField.text];
    }
     */
    //银行卡信息---可以检查银行卡也可以不用检查
    if ([textField isEqual:_cardTextField]) {
        if (ShouldCheckoutCredit != 0) {
            [self checkoutCreditCard:_cardTextField.text];
        }
        self.item.bankCard = _cardTextField.text;
    }
    if ([textField isEqual:_bankTextField]) {
        self.item.bankId = [self findBankIdWithBankName:_bankTextField.text];;
    }
    if ([textField isEqual:_contactPhoneNumberTextField]) {
        [self systemAddressClick:_contactPhoneNumberTextField];
    }
    if ([textField isEqual:_contactNameTextField]) {
        self.item.urgentName = _contactNameTextField.text;
    }
    if ([textField isEqual:_contactRelationshipTextField]) {
        self.item.relationship = _contactRelationshipTextField.text;
    }
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}// called when 'return' key pressed. return NO to ignore.

- (IBAction)nextPage:(UIButton *)sender {
    
    NSLog(@"item = %@",self.item.debugDescription);
    NSMutableDictionary *userItemDic = self.item.mj_keyValues;;
    [VerifyModel postFirstInformation:userItemDic success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            
            [AppUserInfoHelper updateUserInfo:resultDic];
            VerifyViewController *paVC = (VerifyViewController *)self.parentViewController;
            paVC.status = 1;
            
        }else{
            [SVProgressHUD showInfoWithStatus:@"提交信息失败"];
        }
    } failure:^(NSError *error) {
        
    }];
    
//    VerifyViewController *paVC = (VerifyViewController *)self.parentViewController;
//    paVC.status = 1;
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
