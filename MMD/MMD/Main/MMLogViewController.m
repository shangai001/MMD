//
//  MMLogViewController.m
//  MMD
//
//  Created by pencho on 16/2/16.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMLogViewController.h"
#import "checkoutPhoneNumber.h"
#import "MMDUser.h"
#import "MMDLogin.h"
#import <MJExtension.h>
#import "RegisterViewController.h"
#import "BaseNavgationController.h"
#import "PasswordLength.h"
#import "ColorHeader.h"

@interface MMLogViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)MMDUser *user;


@end

@implementation MMLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    // Do any additional setup after loading the view from its nib.
    [self addButtonStatusImage];
    [self addDissmissKeyboardAction];
    if (!self.user) {
        self.user = [MMDUser new];
    }
}
- (void)addDissmissKeyboardAction{
    UITapGestureRecognizer *disTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disKeyboard:)];
    [self.view addGestureRecognizer:disTap];
}
- (void)disKeyboard:(id)sender{
    [self.view endEditing:YES];
}
- (void)addButtonStatusImage{
    [self.rememberPasswordButton setImage:[UIImage imageNamed:@"approve_on"] forState:UIControlStateSelected];
    [self.rememberPasswordButton setImage:[UIImage imageNamed:@"approve_off"] forState:UIControlStateNormal];
    self.logButton.backgroundColor = REDCOLOR;
    
    [self.securityBUtton setImage:[UIImage imageNamed:@"no_visible"] forState:UIControlStateNormal];
    [self.securityBUtton setImage:[UIImage imageNamed:@"visible"] forState:UIControlStateSelected];
}
- (IBAction)changSecurityStarus:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        self.securityBUtton.selected = !self.securityBUtton.selected;
        self.passwordTextField.secureTextEntry = !self.passwordTextField.secureTextEntry;
    }
}
- (IBAction)rememberPassword:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = ! button.selected;
}
- (IBAction)logIn:(id)sender {
#warning 此处有BUG
    NSDictionary *info = self.user.mj_keyValues;
//    NSDictionary *info = @{@"phoneNumber":@"18632156680",@"password":@"123456"};
    
    [MMDLogin loginUser:info completionHandler:^(NSDictionary *resultDictionary) {
        if ([resultDictionary[@"code"] integerValue] == 0) {
            NSLog(@"登录成功");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } FailureHandler:^(NSError *error) {
        
    }];
    
}
- (IBAction)forgetPassword:(id)sender {
    RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:NSStringFromClass([RegisterViewController class]) bundle:[NSBundle mainBundle]];
    registerController.title = @"找回密码";
    registerController.type = 1;
    [self.navigationController pushViewController:registerController animated:YES];
}

- (IBAction)registerUser:(id)sender {
    RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:NSStringFromClass([RegisterViewController class]) bundle:[NSBundle mainBundle]];
    registerController.title = @"注册用户";
    registerController.type = 1;
    [self.navigationController pushViewController:registerController animated:YES];
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == self.numTextField) {
//        BOOL isOK = [checkoutPhoneNumber checkTelNumber:textField.text];
//        return isOK;
    }
    if (textField == self.passwordTextField) {

//        }
    }
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
 
    if ([textField isEqual:self.numTextField]) {
        BOOL isOK = [checkoutPhoneNumber checkTelNumber:textField.text];
        if (isOK) {
            self.user.phoneNumber = textField.text;
        }
    }else if ([textField isEqual:self.passwordTextField]){
        NSString *text = textField.text;
        if (text.length >= SHORTESTLENGTH && text.length <= LONGESTLENGTH) {
            self.user.password = text;
        }
    }
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.numTextField) {
        BOOL isOK = [checkoutPhoneNumber checkTelNumber:textField.text];
        if (isOK) {
            [textField resignFirstResponder];
            [self.passwordTextField becomeFirstResponder];
        }
        return isOK;
    }
    if (textField == self.passwordTextField) {
        NSString *text = textField.text;
        if (text.length >= SHORTESTLENGTH && text.length <= LONGESTLENGTH) {
            [textField resignFirstResponder];
            return YES;
        }
        return NO;
    }
    return NO;
}// called when 'return' key pressed. return NO to ignore.
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
