//
//  ChangeCodeController.m
//  MMD
//
//  Created by pencho on 16/4/26.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ChangeCodeController.h"
#import "ColorHeader.h"
#import <SVProgressHUD.h>
#import "ChangePasswordModel.h"


@interface ChangeCodeController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nPassTextField;
@property (weak, nonatomic) IBOutlet UITextField *nPassTextField1;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *visibleButtons;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIView *backView;



@end

@implementation ChangeCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"修改密码";
    [self configureButtons];
}
- (void)configureButtons{
    
    for (NSInteger j = 0; j < self.visibleButtons.count; j ++) {
        UIButton *button = (UIButton *)self.visibleButtons[j];
        [button setImage:[UIImage imageNamed:@"no_visible"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"visible"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(makeTextFiledVisble:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.sureButton.layer.cornerRadius = 10.0f;
    self.sureButton.backgroundColor = REDCOLOR;
}
- (void)makeTextFiledVisble:(UIButton *)sender{
    
    NSInteger buttonTag = sender.tag;
    NSInteger textFieldTag = buttonTag - 100;
    UITextField *field = (UITextField *)[self.backView viewWithTag:textFieldTag];
    [field setSecureTextEntry:sender.selected];
    sender.selected = !sender.selected;
}
#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.oldPasswordTextField]) {
        
    }
    if ([textField isEqual:self.nPassTextField]) {
        
    }
    if ([textField isEqual:self.nPassTextField1]) {
        
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)sureAction:(id)sender {
    
    if ([self.nPassTextField.text isEqualToString:self.nPassTextField1.text]) {
        
        [SVProgressHUD show];
        NSString *oldP = self.oldPasswordTextField.text;
        NSString *newp = self.nPassTextField1.text;
        NSDictionary *infoDic = @{@"oldPassword":oldP,@"newPassword":newp};
        [ChangePasswordModel changePassword:infoDic success:^(NSDictionary *resultDic) {
            if ([resultDic[@"code"] integerValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"两次新密码不一致"];
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
