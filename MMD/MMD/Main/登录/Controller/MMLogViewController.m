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
#import "LoginModel.h"
#import "LogginHandler.h"
#import <MJExtension.h>
#import "ContantLength.h"
#import "ConstantNotiName.h"
#import "RegisterViewController.h"
#import "BaseNavgationController.h"
#import "ColorHeader.h"
#import "FailureView.h"
#import "UIView+LoadViewFromNib.h"
#import <SVProgressHUD.h>
#import <UIView+SDAutoLayout.h>
#import "WarnLoginModel.h"
#import "HandleUserStatus.h"
#import "GraphicVerification.h"
#import "MMDLoggin.h"
#import "AppUserInfoHelper.h"
#import "AppInfo.h"
#import "MessageModel.h"


CGFloat const REMEMBERBUTTONTOTOP_DEFAULT = 25;
CGFloat const INPUTROW_HEIGHT = 30;


@interface MMLogViewController ()<UITextFieldDelegate,didEndInputCode>

@property (nonatomic, strong)LoginUser *user;
@property (nonatomic, assign)NSUInteger failureCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rememberButtonToTop;
@property (nonatomic, strong)FailureView *failureView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconToLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;

@end

@implementation MMLogViewController

- (FailureView *)failureView{
    if (!_failureView) {
        _failureView = [FailureView loadViewFromNib];
        _failureView.delegate = self;
    }
    return _failureView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    // Do any additional setup after loading the view from its nib.
    [self addButtonStatusImage];
    [self initDefaultValue];    
}
- (void)initDefaultValue{
    if (!self.user) {
        self.user = [LoginUser new];
    }
    self.failureCount = 0;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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
    //如果正在输入验证码，停止输入
    if ([self.view.subviews containsObject:self.failureView]) {
        [self.failureView willEndInput];
    }
    [self.view endEditing:YES];
    NSDictionary *info = self.user.mj_keyValues;
    [SVProgressHUD show];
    [LoginModel loginUser:info completionHandler:^(NSDictionary *resultDictionary) {
        if ([resultDictionary[@"code"] integerValue] == 0) {
            [self resetFailureValue];
            [self handleLoginResult:resultDictionary];
            [SVProgressHUD dismiss];
        }else{
            [self logginFailure:nil];
            [SVProgressHUD showInfoWithStatus:resultDictionary[@"msg"]];
        }
    } FailureHandler:^(NSError *error) {
        [SVProgressHUD dismiss];
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
        self.rememberButtonToTop.constant = INPUTROW_HEIGHT + REMEMBERBUTTONTOTOP_DEFAULT + self.passwordToTop.constant;
        [self showCodeImageView];
    }
    [self.view setNeedsLayout];
}
- (void)showCodeImageView{
    
    
    if (![self.view.subviews containsObject:self.failureView]) {
        [self.view addSubview:self.failureView];
    }
    {
        //设置错误验证码视图autolayout
        self.failureView.sd_layout
        .leftSpaceToView(self.view,self.iconToLeft.constant)
        .topSpaceToView(self.passwordTextField,self.passwordToTop.constant)
        .rightSpaceToView(self.view,self.iconToLeft.constant)
        .heightIs(INPUTROW_HEIGHT);
    }
    
    [self refreshCodeImage];
}
- (void)refreshCodeImage{
    {
        //请求验证码
        NSString *uuid = [AppInfo UUIDString];
        NSDictionary *info = @{@"uuid":uuid};
        self.user.uuid = uuid;
        [GraphicVerification getGraphicVerification:info completation:^(UIImage *codeImage) {
            NSLog(@"图形验证码%@",codeImage);
            self.failureView.codeImage.image = codeImage;
            [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
        } failure:^(NSError *error) {
            NSLog(@"error %@",error);
        }];
    }
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
    
    [MessageModel getSecurityMessageToken:nil completion:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            NSString *messageToken = resultDic[@"data"];
            NSDictionary *phoneDic = @{@"phone":self.user.phone,@"token":messageToken};
            [WarnLoginModel postWarnningMessageToPhone:phoneDic success:^(NSDictionary *resultDic) {
                if ([resultDic[@"code"] integerValue] == 0) {
                    NSLog(@"%@",resultDic[@"msg"]);
                }
            } failure:^(NSError *error) {
                NSLog(@"异常登录短信发送失败");
            }];
        }
    } failure:^(NSError *error) {
        
    }];

}
#pragma mark DidEndInputCode
- (void)didEndInputCode:(NSString *)codeString{
    self.user.code = codeString;
}
- (void)shouldRefreshCode{
    [self refreshCodeImage];
}
#pragma mark SavePassword
- (void)recordUserPassword{
    if (self.rememberPasswordButton.selected) {
        NSString *phoneNumber = self.user.phone;
        NSString *password = self.user.password;
        [MMDLoggin ez_RecordUser:phoneNumber password:password];
    }
}
#pragma mark AfterLogin
- (void)handleLoginResult:(NSDictionary *)resultDictionary{

    //记录用户信息(可以单独写出来)
    [AppUserInfoHelper updateUserInfo:resultDictionary];
    //是否需要记住密码
    [self recordUserPassword];
    //检查用户资料完善情况
    [self checkoutUserCompleteInfo];
    //上传用户联系人
    [self uploadContacts];
    //上传设备信息
    [self uploadDeviceinfo:resultDictionary];
    //发送已经登录通知
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogin object:nil];
}
- (void)uploadDeviceinfo:(NSDictionary *)resultDictionary{
    
    [LogginHandler shouldUploadDeviceInfo:resultDictionary success:^(NSDictionary *resultDic) {
        NSLog(@"上传设备信息 %@",resultDic);
    } failure:^(NSError *error) {
        
    }];
}
- (void)uploadContacts{
    
    [LogginHandler shouldUploadContacts:nil success:^(NSDictionary *resultDic) {
        NSLog(@"上传用户联系人 %@",resultDic);
    } failure:^(NSError *error) {
        
    }];
}
- (void)checkoutUserCompleteInfo{
    
    if ([HandleUserStatus handleUserStatusAt:self]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark ButtonOutletAction
- (IBAction)forgetPassword:(id)sender {
    RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:NSStringFromClass([RegisterViewController class]) bundle:[NSBundle mainBundle]];
    registerController.type = kForgetPassword;
    registerController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerController animated:YES];
}

- (IBAction)registerUser:(id)sender {
    RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:NSStringFromClass([RegisterViewController class]) bundle:[NSBundle mainBundle]];
    registerController.type = kRegisterType;
    registerController.hidesBottomBarWhenPushed = YES;
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
        if (text.length >= MINPD_LENGTH && text.length <= MAXPD_LENGTH) {
            self.user.password = text;
        }
    }
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([textField isEqual:self.numTextField]) {
        NSString * toBePhoneNumberString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *password = [MMDLoggin ez_FindPasswordForPhone:toBePhoneNumberString];
        if (password) {
            self.passwordTextField.text = password;
            self.user.password = password;
        }
    }
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
        if (text.length >= MINPD_LENGTH && text.length <= MAXPD_LENGTH) {
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
