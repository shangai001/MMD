//
//  FirstStepController.m
//  MMD
//
//  Created by pencho on 16/3/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "FirstStepController.h"
#import "VerifyItem.h"
//#import "ZHPickView.h"
#import "STPickerArea.h"
#import "HeightHeader.h"
#import "ColorHeader.h"
#import <Masonry.h>

@interface FirstStepController ()<UITextFieldDelegate,STPickerAreaDelegate>
@property (nonatomic, strong)VerifyItem *item;
@property (nonatomic, strong)STPickerArea *pickerView;

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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_cityTextField]) {
        
        [textField resignFirstResponder];
        
        [textField resignFirstResponder];
        
        self.pickerView = [[STPickerArea alloc]init];
        [self.pickerView setDelegate:self];
        [self.pickerView setContentMode:STPickerContentModeBottom];
        [self.pickerView show];
        
//        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(superView);
//            make.bottom.mas_equalTo(superView);
//            make.right.mas_equalTo(superView);
//            make.height.mas_equalTo(200);
//        }];
//        [self.view setNeedsLayout];
//        AddressPickView *addressPickView = [AddressPickView shareInstance];
//        addressPickView.frame = CGRectMake(0, 200, 275, 200);
//        [self.view addSubview:addressPickView];
//        addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
//            self.item.city = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
//        };
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
//        self.item.contactName = _contactNameTextField.text;
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
