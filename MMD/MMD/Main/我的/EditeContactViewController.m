//
//  EditeContactViewController.m
//  MMD
//
//  Created by pencho on 16/4/25.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "EditeContactViewController.h"
#import "ColorHeader.h"
#import "ContactsItem.h"
#import "ZCAddressBook.h"
#import <MJExtension.h>
#import "EditeContactModel.h"
#import <SVProgressHUD.h>


@interface EditeContactViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;
@property (weak, nonatomic) IBOutlet UITextField *contactName;
@property (weak, nonatomic) IBOutlet UITextField *relationTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (assign, nonatomic)BOOL ischanged;


@end

@implementation EditeContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureButtons];
    [self initDefaultValue];
    self.title = @"添加联系人";
    [self setDefaultValue];
}
- (void)setDefaultValue{
    if (_item && !self.isAdding) {
        NSLog(@"name - %@, phone - %@, relation- %@",_item.name,_item.phone,_item.relation);
        self.phoneLabel.text = _item.phone;
        self.contactName.text = _item.name;
        self.relationTextField.text = _item.relation;
    }
}
- (void)initDefaultValue{
    
    if (!self.item) {
        self.item = [ContactsItem new];
    }
}
- (void)configureButtons{
    
    self.sureButton.layer.cornerRadius = 10.0f;
    self.sureButton.backgroundColor = REDCOLOR;
}
- (void)setItem:(ContactsItem *)item{
    _item = item;

}
#pragma mark UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.contactName]) {
        self.item.name = textField.text;
        self.ischanged = YES;
    }
    if ([textField isEqual:self.relationTextField]) {
        self.item.relation = textField.text;
        self.ischanged = YES;
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
- (IBAction)sureAction:(id)sender {
    
    if (self.isAdding || self.ischanged) {
        NSDictionary *itemDic = [self.item mj_keyValues];
        
        [EditeContactModel uploadEditeContacts:itemDic success:^(NSDictionary *resultDic) {
            if ([resultDic[@"code"] integerValue] == 0) {
                [SVProgressHUD showSuccessWithStatus:resultDic[@"msg"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"联系人未有改动"];
    }
    
}
- (IBAction)getContactAction:(id)sender {
    
    [[ZCAddressBook shareControl]showPhoneViewWithTarget:self Block:^(BOOL isSuccess, NSDictionary *dic) {
        if (isSuccess) {
            NSArray *selectedPerson = dic[@"telphone"];
            NSString *phoneNumber = [NSString stringWithFormat:@"%@",[selectedPerson lastObject]];
            NSString *fullName = [NSString stringWithFormat:@"%@%@",dic[@"first"],dic[@"last"]];
            self.phoneLabel.text = phoneNumber;
            self.contactName.text = fullName;
            self.item.name = fullName;
            self.item.phone = phoneNumber;
            self.ischanged = YES;
        }
    }];
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
