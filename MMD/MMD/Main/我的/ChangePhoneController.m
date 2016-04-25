//
//  ChangePhoneController.m
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ChangePhoneController.h"
#import "ColorHeader.h"
#import "ChnagePhoneItem.h"
#import "AppUserInfoHelper.h"
#import "MessageModel.h"
#import "checkoutPhoneNumber.h"
#import <SVProgressHUD.h>
#import <NSTimer+YYAdd.h>
#import <MJExtension.h>
#import "ChangePhoneModel.h"



@interface ChangePhoneController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *nPhoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *messageCodeField;
@property (weak, nonatomic) IBOutlet UIButton *getMessageButton;

@property (strong, nonatomic)ChnagePhoneItem *item;
@property (strong, nonatomic)NSTimer *timer;


@end

@implementation ChangePhoneController

- (ChnagePhoneItem *)item{
    if (!_item) {
        _item = [ChnagePhoneItem new];
    }
    return _item;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"修改手机号";
    [self initDeafuleValue];
}
- (void)initDeafuleValue{
    
    self.sureButton.layer.cornerRadius = 10.0f;
    self.sureButton.backgroundColor = REDCOLOR;
    
    NSDictionary *userDic = [AppUserInfoHelper user];
    NSString *oldPhone = userDic[@"phone"];
    self.phoneNumLabel.text = oldPhone;
}
#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.passwordField]) {
        self.item.password = textField.text;
    }
    if ([textField isEqual:self.nPhoneNumField]) {
        BOOL isPhoneOk = [checkoutPhoneNumber checkTelNumber:textField.text];
        if (isPhoneOk) {
            self.item.nPhone = textField.text;
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        }
    }
    if ([textField isEqual:self.messageCodeField]) {
        self.item.code = textField.text;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)getMessageAction:(id)sender {
    
    if (self.item.nPhone) {
        [self makeTimer:nil];
        //先获得短信 token
        [MessageModel getSecurityMessageToken:nil completion:^(NSDictionary *resultDic) {
            if ([resultDic[@"code"] integerValue] == 0) {
                NSString *messageToken = resultDic[@"data"];
                NSString *nPhoneNum = self.item.nPhone;
                NSDictionary *nPhoneDic = @{@"phone":nPhoneNum,@"token":messageToken};
                //获取短信验证码
                [MessageModel getSecurityMessageCode:nPhoneDic completion:^(NSDictionary *resultDic) {
                    if ([resultDic[@"code"] integerValue] != 0) {
                        [SVProgressHUD showInfoWithStatus:resultDic[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    
                }];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
- (void)makeTimer:(id)sender{
    
    if (self.item.nPhone) {
        __block NSTimeInterval seconds = 0;
        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
                seconds += 1;
                NSInteger leftSeconds = 60 - seconds;
                NSString *buttonTitle =[NSString stringWithFormat:@"%@S后获取验证码",@(leftSeconds)];
                [self.getMessageButton setTitle:buttonTitle forState:UIControlStateNormal];
                if (seconds >= 60) {
                    if ([timer isValid]) {
                        [timer invalidate];
                        timer = nil;
                        seconds = 0;
                        [self.getMessageButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                    }
                }
            } repeats:YES];
        }
    }
}

- (IBAction)submitNPhone:(id)sender {
    
    if (self.item.nPhone) {
        NSMutableDictionary *itemDic = [self.item mj_keyValues];
        [itemDic removeObjectForKey:@"nPhone"];
        [itemDic setObject:self.item.nPhone forKey:@"newPhone"];
        
        [ChangePhoneModel changePhoneNumber:itemDic success:^(NSDictionary *resultDic) {
            if ([resultDic[@"code"] integerValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:resultDic[@"msg"]];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

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
