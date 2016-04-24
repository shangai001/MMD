//
//  EditeBankController.m
//  MMD
//
//  Created by pencho on 16/4/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "EditeBankController.h"
#import "BankItem.h"
#import "ColorHeader.h"
#import "STPickerSingle.h"
#import "STPickerArea.h"
#import "BankModel.h"
#import "NewBankItem.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>


@interface EditeBankController ()<UITextFieldDelegate,STPickerAreaDelegate,STPickerSingleDelegate>



@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idNumLabel;
@property (weak, nonatomic) IBOutlet UITextField *bankNumberTextFileld;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankCityTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (nonatomic, strong)STPickerArea *cityPickerView;
@property (nonatomic, strong)STPickerSingle *backPickerView;
@property (nonatomic, strong)NSArray *bankArray;

@property (nonatomic, strong)NewBankItem *changedBankItem;

@end

@implementation EditeBankController

- (NSArray *)bankArray{
    if (!_bankArray) {
        _bankArray = [NSArray array];
    }
    return _bankArray;
}
- (STPickerSingle *)backPickerView{
    if (!_backPickerView) {
        _backPickerView = [[STPickerSingle alloc] init];
    }
    return _backPickerView;
}
- (STPickerArea *)cityPickerView{
    if (!_cityPickerView) {
        _cityPickerView = [[STPickerArea alloc] init];
    }
    return _cityPickerView;
}
- (BankItem *)item{
    if (!_item) {
        _item = [BankItem new];
    }
    return _item;
}
- (NewBankItem *)changedBankItem{
    if (!_changedBankItem) {
        _changedBankItem = [NewBankItem new];
    }
    return _changedBankItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self setBaseBankInfo];
    [self configureButtons];
}
- (void)configureButtons{
    self.doneButton.layer.cornerRadius = 10.0f;
    self.doneButton.backgroundColor = REDCOLOR;
}
- (void)setBaseBankInfo{
    
    self.nameLabel.text = self.item.name;
    self.idNumLabel.text = self.item.idNumber;
    self.bankNumberTextFileld.text = self.item.bankNumber;
    self.bankCityTextField.text = self.item.bankCity;
    self.bankNameTextField.text = self.item.bankName;
    
    [self.bankNumberTextFileld becomeFirstResponder];
}

- (NSMutableArray *)formatBankList:(NSArray *)data{
    self.bankArray =  data;
    NSMutableArray *bankArray = [NSMutableArray arrayWithCapacity:data.count];
    for (NSDictionary *dic in data) {
        NSString *name = dic[@"name"];
        [bankArray addObject:name];
    }
    return bankArray;
}
#pragma mark STPickerAreaDelegate
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area{
    
    NSString *cityAddress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    self.changedBankItem.bankArea = area;
    self.changedBankItem.bankCity = city;
    self.changedBankItem.bankProvince = province;
    self.bankCityTextField.text = cityAddress;
}
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle{
    self.bankNameTextField.text = selectedTitle;
    self.changedBankItem.bankId = [self findBankIdWithBankName:selectedTitle];
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
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.bankNameTextField]) {

        [self.view endEditing:YES];
        if (!self.backPickerView) {
            self.backPickerView = [[STPickerSingle alloc] init];
        }
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
        return NO;
    }
    if ([textField isEqual:self.bankCityTextField]) {
        
        [self.view endEditing:YES];
        self.cityPickerView = [[STPickerArea alloc]init];
        [self.cityPickerView setDelegate:self];
        [self.cityPickerView setContentMode:STPickerContentModeBottom];
        [self.cityPickerView show];
        return NO;
    }
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.bankNumberTextFileld]) {
        self.changedBankItem.bankCard = textField.text;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneAction:(id)sender {
    
    [SVProgressHUD show];
    NSDictionary *info = [self.changedBankItem mj_keyValues];
    [BankModel changeBankIdInfo:info completation:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:resultDic[@"msg"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
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
