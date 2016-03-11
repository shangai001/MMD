//
//  RegisterViewController.m
//  MMD
//
//  Created by pencho on 16/2/29.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterItem.h"
#import "checkoutPhoneNumber.h"
#import "LimitInputWords.h"
#import "MMDLogin.h"
#import "LXMKeyboardManager.h"
#import "RegisterContentView.h"
#import "UIView+LoadViewFromNib.h"
#import <MJExtension.h>
#import "UpdateUserInfo.h"


#define PHONENUM_LENGTH 11
#define LONGESTPASSWORD_LENGTH 12
#define SHORTESTPASSWORD_LENGTH 6



@interface RegisterViewController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollView;
@property (strong, nonatomic)LXMKeyboardManager *lxManager;
@property (strong, nonatomic)NSTimer *nextMessageTimer;
@property (assign, nonatomic)NSUInteger seconds;


@end

@implementation RegisterViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark getter
- (RegisterItem *)registerItem{
    if (!_registerItem) {
        _registerItem = [RegisterItem new];
    }
    return _registerItem;
}
- (RegisterContentView *)contentView{
    if (!_contentView) {
        _contentView = [RegisterContentView loadViewFromNib];
    }
    return  _contentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self registerNotification];
    [self addDissmissKeyboardGesture];
    [self addKeyboardManager];
    [self setupUI];
    [self addButtonAction];
}
#pragma Prepare
//注册通知，限制字数
- (void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ez_TextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];
}
//添加取消输入手势
- (void)addDissmissKeyboardGesture{
    UITapGestureRecognizer *keyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeKeyBoard)];
    [self.view addGestureRecognizer:keyboardTap];
}
//添加自动调整输入框位置管理器
- (void)addKeyboardManager{
    if (!self.lxManager) {
        self.lxManager = [[LXMKeyboardManager alloc] initWithScrollView:self.baseScrollView];
    }
}
//分别修改UI/标题
- (void)setupUI{
    [self resetUIFrame];
}
//修改UI Frame
- (void)resetUIFrame{
    
    [self.baseScrollView addSubview:self.contentView];
    CGSize baseScrollViewSie = self.baseScrollView.frame.size;
    self.contentView.frame = CGRectMake(30, 44, baseScrollViewSie.width - 30 * 2, baseScrollViewSie.height - 44 - 30);
    [self.contentView setNeedsLayout];
    self.contentView.phoneNumberField.delegate = self;
    self.contentView.securityCodeTextField.delegate = self;
    self.contentView.password1.delegate = self;
    self.contentView.password2.delegate = self;
    self.baseScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 55);
}
//获取验证码/确定 点击事件
- (void)addButtonAction{
    [self.contentView.getSecurityCodeButton addTarget:self action:@selector(getSecurityCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.sureButton addTarget:self action:@selector(doneUser:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)removeKeyBoard{
    [self.view endEditing:YES];
}
- (void)setType:(kUserType)type{
    _type = type;
    if (_type == kRegisterType) {
        self.title = @"注册用户";
    }else if (_type == kForgetPassword){
        self.title = @"找回密码";
    }
    [self.contentView changeSureButtonStatus:_type];
}
#pragma mark ButtonAction
//改变获取验证码Button状态
- (void)changeSecurityButtonTitle:(id)sender{
    self.seconds += 1;
    long afterSeconds = 60 -self.seconds;
    [self.contentView changeSecurityButtonWaitingStatus:afterSeconds];
    if (self.seconds == 60) {
        [self endTimer:sender];
    }
}
//开始定时器
- (void)startTimer:(id)sender{
    //如果定时器对象不存在，则创建一个并启动
    if (!self.nextMessageTimer) {
        self.seconds = 0;
        self.nextMessageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeSecurityButtonTitle:) userInfo:nil repeats:YES];
    }
}
//关闭定时器
- (void)endTimer:(id)sender{
    if (self.nextMessageTimer) {
        if ([self.nextMessageTimer isValid]) {
            [self.nextMessageTimer invalidate];
            self.nextMessageTimer = nil;
            self.seconds = 0;
        }
    }
    [self.contentView changeSecurityButtonNormalStatus];
}
- (void)getSecurityCode:(id)sender {
    BOOL isPhoneNum = [checkoutPhoneNumber checkTelNumber:self.contentView.phoneNumberField.text];
    //如果是手机号
    if (isPhoneNum) {
        //注册
        if (self.type == kRegisterType) {
            NSString *phoneNumber = self.contentView.phoneNumberField.text;
            NSDictionary *info = @{@"phone":phoneNumber};
            [MMDLogin getSecurityCode:info completionHandler:^(NSDictionary *resultDictionary) {
                [self handleGetSecurityCodeInfo:resultDictionary];
            } FailureHandler:^(NSError *error) {
            }];
            //找回密码
        }else if (self.type == kForgetPassword){
            NSString *phoneNumber = self.contentView.phoneNumberField.text;
            NSDictionary *info = @{@"phone":phoneNumber};
            [MMDLogin forgetPassword:info completionHandler:^(NSDictionary *resultDictionary) {
                
            } FailureHandler:^(NSError *error) {
                
            }];
        }
        [self startTimer:sender];
    }else{
        NSLog(@"这不是正确的电话号码！");
    }
}

- (void)saveReturnUserInfo:(NSDictionary *)dic{
    NSNumber *code = dic[@"code"];
    if ([code integerValue] == 0) {
        NSUserDefaults *stUserDefault = [NSUserDefaults standardUserDefaults];
        NSNumber *sid = dic[@"data"][@"result"][@"sid"];
        [stUserDefault setObject:sid forKey:@"sid"];
    }
}
- (void)doneUser:(id)sender{
    
    [self.view endEditing:YES];
    NSDictionary *info = self.registerItem.mj_keyValues;
    if (self.type == kRegisterType) {
        [MMDLogin registerUserCount:info completionHandler:^(NSDictionary *resultDictionary) {
            [self handleRegisterResult:resultDictionary];
        } FailureHandler:^(NSError *error) {
            
        }];
    }
    if (self.type == kForgetPassword) {
        [MMDLogin resetPassword:info completionHandler:^(NSDictionary *resultDictionary) {
            [self handleResetResult:resultDictionary];
        } FailureHandler:^(NSError *error) {
            
        }];
    }
}
//处理注册手机号码结果
- (void)handleGetSecurityCodeInfo:(NSDictionary *)resultDictionary{
    NSInteger codeStatus = [resultDictionary[@"code"] integerValue];
    switch (codeStatus) {
        case 0:
        {
            NSLog(@"获取验证码成功！");
        }
            break;
        case 1:
        {
            NSLog(@"手机号未注册！");
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}
//处理注册结果
- (void)handleRegisterResult:(NSDictionary *)resultDictionary{
    NSInteger codeStatus = [resultDictionary[@"code"] integerValue];
    if (codeStatus == 0) {
        NSDictionary *data = resultDictionary[@"data"];
        [UpdateUserInfo updateUserInfo:data];
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([resultDictionary[@"code"] integerValue] == 1){
        NSLog(@"手机号已经注册！");
    }
}
//处理重设密码结果
- (void)handleResetResult:(NSDictionary *)resultDictionary{
    if ([resultDictionary[@"code"] integerValue] == 0) {
        NSLog(@"密码重置成功");
    }
}
-(void)ez_TextFiledEditChanged:(NSNotification *)obj{
    
    UITextField *textField = (UITextField *)obj.object;
    NSUInteger textCount = 0;
    if (textField == self.contentView.phoneNumberField) {
        textCount = PHONENUM_LENGTH;
    }else if (textField == self.contentView.password1 || textField == self.contentView.password2) {
        textCount = LONGESTPASSWORD_LENGTH;
    }else{
        textCount = 12;
    }
    [LimitInputWords limitInputText:textField textCount:textCount];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.lxManager scrollToIdealPositionWithTargetView:textField];
    return YES;
    
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == self.contentView.phoneNumberField) {
        
    }
    if (textField == self.contentView.securityCodeTextField) {
        
    }
    if (textField == self.contentView.password1) {
        
    }
    if (textField == self.contentView.password2) {
        
    }
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.contentView.phoneNumberField) {
        self.registerItem.phone = textField.text;
    }
    if (textField == self.contentView.securityCodeTextField) {
        self.registerItem.code = textField.text;
    }
    BOOL isPass1 = textField == self.contentView.password1;
    BOOL isPass2 = textField == self.contentView.password2;
    BOOL isSame = [self.contentView.password1.text isEqualToString:self.contentView.password2.text];
    if ( (isPass1 || isPass2)  && isSame) {
        self.registerItem.password = textField.text;
    }
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.contentView.phoneNumberField) {
        BOOL isPhoneNum = [checkoutPhoneNumber checkTelNumber:textField.text];
        if (isPhoneNum) {
            [self.contentView.securityCodeTextField becomeFirstResponder];
        }
        return isPhoneNum;
    }
    if (textField == self.contentView.securityCodeTextField) {
        [self.contentView.password1 becomeFirstResponder];
        return YES;
    }
    if (textField == self.contentView.password1) {
        NSUInteger lenth = textField.text.length;
        BOOL isOk = lenth >= SHORTESTPASSWORD_LENGTH && lenth <= LONGESTPASSWORD_LENGTH;
        if (isOk) {
            [self.contentView.password2 becomeFirstResponder];
        }
        return isOk;
    }
    if (textField == self.contentView.password2) {
        NSUInteger lenth = textField.text.length;
        BOOL isOk = lenth >= SHORTESTPASSWORD_LENGTH && lenth <= LONGESTPASSWORD_LENGTH;
        
        BOOL isSame = NO;
        NSString *pass1 = self.contentView.password1.text;
        NSString *pass2 = self.contentView.password2.text;
        if ([pass1 isEqualToString:pass2]) {
            isSame = YES;
        }else{
            isSame = NO;
        }
        if (isOk && isSame) {
            [textField resignFirstResponder];
        }
        return isOk && isSame;
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
