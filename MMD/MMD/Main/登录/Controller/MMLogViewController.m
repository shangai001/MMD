//
//  MMLogViewController.m
//  MMD
//
//  Created by pencho on 16/2/16.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMLogViewController.h"
#import "checkoutPhoneNumber.h"
#import "LoginUser.h"
#import "LogginModel.h"
#import <MJExtension.h>
#import "RegisterViewController.h"
#import "BaseNavgationController.h"
#import "PasswordLength.h"
#import "ColorHeader.h"
#import "VerifyViewController.h"
#import "FailureView.h"
#import "UIView+LoadViewFromNib.h"
#import <SVProgressHUD.h>
#import "WarnLoginModel.h"
#import "UserInfoImporter.h"


#define FIRSTTIMELOGOIN @"firstTimeLogin"
#define REMEMBERBUTTONTOTOP_DEFAULT 25
#define INPUTROW_HEIGHT 30

@interface MMLogViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)LoginUser *user;
@property (nonatomic, assign)NSUInteger failureCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rememberButtonToTop;
@property (nonatomic, strong)FailureView *failureView;



@end

@implementation MMLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    // Do any additional setup after loading the view from its nib.
    [self addButtonStatusImage];
    [self addDissmissKeyboardAction];
    [self initDefaultValue];
}
- (void)initDefaultValue{
    
    if (!self.user) {
        self.user = [LoginUser new];
    }
    self.failureCount = 0;
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
    [self.view endEditing:YES];
    //TODO:这里需要验证
    NSDictionary *info = self.user.mj_keyValues;
    //记住密码
    [self savePasswordBeforeLogin];
    [LogginModel loginUser:info completionHandler:^(NSDictionary *resultDictionary) {
        if ([resultDictionary[@"code"] integerValue] == 0) {
            [self resetFailureValue];
            [self handleLoginResult:resultDictionary];
        }else{
            [self logginFailure:nil];
        }
    } FailureHandler:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error.localizedDescription]];
        NSLog(@"error = %@",error);
    }];
    
}

/**
 *  显示或者去掉 图形验证
 *
 *  @param hidden 验证图是否将要隐藏
 */
- (void)popRecognizeImageView:(BOOL)hidden{
    
    if (hidden) {
        //正常视图
        self.rememberButtonToTop.constant = REMEMBERBUTTONTOTOP_DEFAULT;
        [self.failureView removeFromSuperview];
    }else{
        //异常 验证视图
       self.rememberButtonToTop.constant = INPUTROW_HEIGHT + REMEMBERBUTTONTOTOP_DEFAULT;
        if (!self.failureView) {
            self.failureView = [FailureView loadViewFromNib];
        }
        //TODO:添加验证视图
        [self.view addSubview:self.failureView];
    }
    [self.view setNeedsLayout];
}
//登录成功
- (void)resetFailureValue{
    self.failureCount = 0;
    [self popRecognizeImageView:YES];
}
//登录失败处理
- (void)logginFailure:(id)sender{
    NSLog(@"登录失败 +1");
    self.failureCount += 1;
    if (self.failureCount >= 3) {
        [self popRecognizeImageView:NO];
        [self sendUnusualMessage:nil];
    }
}
//发送异常登录警告
- (void)sendUnusualMessage:(id)sender{
    
    NSDictionary *phoneDic = @{@"phone":self.user.phone};
    [WarnLoginModel postWarnningMessageToPhone:phoneDic success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            NSLog(@"%@",resultDic[@"msg"]);
        }
    } failure:^(NSError *error) {
        NSLog(@"异常登录短信发送失败");
    }];
}
#pragma mark SavePassword
- (void)savePasswordBeforeLogin{
    
    if (self.rememberPasswordButton.selected) {
        NSString *password = self.user.password;
        [SDUserDefault setValue:password forKey:PASSWORD];
    }else{
        if ([SDUserDefault valueForKey:PASSWORD]) {
            [SDUserDefault removeObjectForKey:PASSWORD];
        }
    }
    [SDUserDefault synchronize];
}
#pragma mark AfterLogin
- (void)handleLoginResult:(NSDictionary *)resultDictionary{
    if ([resultDictionary[@"code"] integerValue] == 0) {
        [UserInfoImporter updateUserInfo:resultDictionary];
    }
    //如果是第一次登录，验证身份证号码
    VerifyViewController *verifyer = [[VerifyViewController alloc] initWithNibName:NSStringFromClass([VerifyViewController class]) bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:verifyer animated:YES];
    
    if ([SDUserDefault boolForKey:FIRSTTIMELOGOIN]) {
        [SDUserDefault setBool:YES forKey:FIRSTTIMELOGOIN];
    }
}
#pragma mark ButtonOutletAction
- (IBAction)forgetPassword:(id)sender {
    RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:NSStringFromClass([RegisterViewController class]) bundle:[NSBundle mainBundle]];
    registerController.type = kForgetPassword;
    [self.navigationController pushViewController:registerController animated:YES];
}

- (IBAction)registerUser:(id)sender {
    RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:NSStringFromClass([RegisterViewController class]) bundle:[NSBundle mainBundle]];
    registerController.type = kRegisterType;
    [self.navigationController pushViewController:registerController animated:YES];
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
 
    if ([textField isEqual:self.numTextField]) {
        BOOL isOK = [checkoutPhoneNumber checkTelNumber:textField.text];
        if (isOK) {
            self.user.phone = textField.text;
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
