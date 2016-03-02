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

#define PHONENUM_LENGTH 11
#define LONGESTPASSWORD_LENGTH 12
#define SHORTESTPASSWORD_LENGTH 6



@interface RegisterViewController ()<UITextFieldDelegate>

@property (strong, nonatomic)NSTimer *nextMessageTimer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *securityNButtonHeight;

@end

@implementation RegisterViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (RegisterItem *)registerItem{
    if (!_registerItem) {
        _registerItem = [RegisterItem new];
    }
    return _registerItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ez_TextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    [self configureButton];
}
- (void)configureButton{
    self.getSecurityCodeButton.backgroundColor = [UIColor colorWithRed:0.41 green:0.79 blue:0.53 alpha:1];
    self.getSecurityCodeButton.layer.cornerRadius = self.securityNButtonHeight.constant/2.0;
}
- (IBAction)getSecurityCode:(id)sender {
    
}
-(void)ez_TextFiledEditChanged:(NSNotification *)obj{
    
    UITextField *textField = (UITextField *)obj.object;
    NSUInteger textCount = 0;
    if (textField == self.phoneNumberField) {
        textCount = PHONENUM_LENGTH;
    }
    if (textField == self.password1 || textField == self.password2) {
        textCount = LONGESTPASSWORD_LENGTH;
    }
    [LimitInputWords limitInputText:textField textCount:textCount];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
    
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == self.phoneNumberField) {
        
    }
    if (textField == self.securityCode) {
        
    }
    if (textField == self.password1) {
        
    }
    if (textField == self.password2) {
        
    }
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.phoneNumberField) {
        
    }
    if (textField == self.securityCode) {
        
    }
    if (textField == self.password1) {
        
    }
    if (textField == self.password2) {
        
    }
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.phoneNumberField) {
        BOOL isPhoneNum = [checkoutPhoneNumber checkTelNumber:textField.text];
        if (isPhoneNum) {
            self.registerItem.phoneNum = textField.text;
        }
        return isPhoneNum;
    }
    if (textField == self.securityCode) {
        
    }
    if (textField == self.password1) {
        NSUInteger lenth = textField.text.length;
        BOOL isOk = lenth >= SHORTESTPASSWORD_LENGTH && lenth <= LONGESTPASSWORD_LENGTH;
        return isOk;
    }
    if (textField == self.password2) {
        NSUInteger lenth = textField.text.length;
        BOOL isOk = lenth >= SHORTESTPASSWORD_LENGTH && lenth <= LONGESTPASSWORD_LENGTH;
        
        BOOL isSame = NO;
        NSString *pass1 = self.password1.text;
        NSString *pass2 = self.password2.text;
        if ([pass1 isEqualToString:pass2]) {
            isSame = YES;
        }else{
            isSame = NO;
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
