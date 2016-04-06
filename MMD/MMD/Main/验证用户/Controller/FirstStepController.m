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
#import "HeightHeader.h"
#import "ColorHeader.h"
#import "BankModel.h"
#import <NSArray+YYAdd.h>
#import "ZCAddressBook.h"



@interface FirstStepController ()<UITextFieldDelegate,STPickerAreaDelegate,STPickerSingleDelegate>

@property (nonatomic, strong)VerifyItem *item;
@property (nonatomic, strong)STPickerArea *cityPickerView;
@property (nonatomic, strong)STPickerSingle *backPickerView;
@property (weak, nonatomic) IBOutlet UIButton *nextButon;

@end

@implementation FirstStepController

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
    self.nextButon.layer.cornerRadius = 10.0f;
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
        self.item.contactName = fullName;
        self.item.contactNum = phoneNumber;
    }];
}
#pragma mark STPickerAreaDelegate
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area{
    NSString *cityAddress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    self.item.city = cityAddress;
    self.cityTextField.text = cityAddress;
}
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle{
    self.item.bank = selectedTitle;
    self.bankTextField.text = selectedTitle;
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
    return YES;
}// return NO to disallow editing.
- (NSMutableArray *)formatBankList:(NSArray *)data{
    NSMutableArray *bankArray = [NSMutableArray arrayWithCapacity:data.count];
    for (NSDictionary *dic in data) {
        NSString *name = dic[@"name"];
        [bankArray addObject:name];
    }
    return bankArray;
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
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:_nameTextField]) {
        self.item.name = _nameTextField.text;
    }
    if ([textField isEqual:_idCardTextField]) {
        self.item.idCardNum = _idCardTextField.text;
    }
    //银行卡信息
    if ([textField isEqual:_cardTextField]) {
        
        NSMutableDictionary *info = @{};
        self.item.cardNum = _cardTextField.text;
    }
    if ([textField isEqual:_bankTextField]) {
        self.item.bank = _bankTextField.text;
    }
    if ([textField isEqual:_contactPhoneNumberTextField]) {
        self.item.contactNum = _contactPhoneNumberTextField.text;
    }
    if ([textField isEqual:_contactNameTextField]) {
        self.item.contactName = _contactNameTextField.text;
    }
    if ([textField isEqual:_contactRelationshipTextField]) {
        self.item.contactRealtionship = _contactRelationshipTextField.text;
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
    
    NSLog(@"item = %@",self.item.description);
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
