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
#import <Masonry.h>
#import <NSArray+YYAdd.h>

@interface FirstStepController ()<UITextFieldDelegate,STPickerAreaDelegate,STPickerSingleDelegate>

@property (nonatomic, strong)VerifyItem *item;
@property (nonatomic, strong)STPickerArea *cityPickerView;
@property (nonatomic, strong)STPickerSingle *backPickerView;

@end

@implementation FirstStepController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self.view endEditing:YES];
        self.cityPickerView = [[STPickerArea alloc]init];
        [self.cityPickerView setDelegate:self];
        [self.cityPickerView setContentMode:STPickerContentModeBottom];
        [self.cityPickerView show];
        return NO;
    }
    if ([textField isEqual:_bankTextField]) {
        [self.view endEditing:YES];
        self.backPickerView = [[STPickerSingle alloc] init];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BankList" ofType:@"plist"];
        NSData *arrayData = [NSData dataWithContentsOfFile:plistPath];
        NSMutableArray *backArray = [NSMutableArray arrayWithPlistData:arrayData];
        [self.backPickerView setArrayData:backArray];
        [self.backPickerView setTitle:@"请选择银行"];
        self.backPickerView.widthPickerComponent = 120;
        [self.backPickerView setContentMode:STPickerContentModeBottom];
        [self.backPickerView setDelegate:self];
        [self.backPickerView show];
        return NO;
    }
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isFirstResponder]) {
        NSLog(@"成为第一响应者");
    }
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:_nameTextField]) {
        self.item.name = _nameTextField.text;
    }
    if ([textField isEqual:_idCardTextField]) {
        self.item.idCardNum = _nameTextField.text;
    }
    if ([textField isEqual:_cardTextField]) {
        self.item.cardNum = _cardTextField.text;
    }
    if ([textField isEqual:_bankTextField]) {
        self.item.bank = _bankTextField.text;
    }

    if ([textField isEqual:_contactNameTextField]) {
    }
    if ([textField isEqual:_contactPhoneNumberTextField]) {

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
