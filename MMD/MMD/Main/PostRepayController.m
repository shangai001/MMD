//
//  PostRepayController.m
//  MMD
//
//  Created by pencho on 16/4/21.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "PostRepayController.h"
#import "ColorHeader.h"
#import "RepayItem.h"
#import "UITextField+DatePicker.h"


@interface PostRepayController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UILabel *cardIdNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UIButton *addPicture;


@property (strong, nonatomic)RepayItem *item;

@end

@implementation PostRepayController

-(RepayItem *)item{
    if (!_item) {
        _item = [RepayItem new];
    }
    return _item;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureButton];
    [self configureTextField];
}
- (void)configureButton{
    
    self.sureButton.backgroundColor = REDCOLOR;
    self.sureButton.layer.cornerRadius = 10.0f;
    self.sureButton.tintColor = [UIColor whiteColor];
}
- (void)configureTextField{
    
    self.timeTextField.datePickerInput = YES;
    self.timeTextField.maxDate = [NSDate date];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sureAction:(id)sender {
}
- (IBAction)addPictureAction:(id)sender {
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
    
    if ([textField isEqual:self.cardIdNumLabel]) {
        self.item.cardNumber = textField.text;
    }
    if ([textField isEqual:self.numTextField]) {
        self.item.amount = textField.text;
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
