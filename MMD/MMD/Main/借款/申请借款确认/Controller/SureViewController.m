//
//  SureViewController.m
//  MMD
//
//  Created by pencho on 16/4/3.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "SureViewController.h"
#import "ColorHeader.h"
#import "LoanProtroWebController.h"
#import <SVProgressHUD.h>
#import "ConstantTitle.h"
#import "BaseNextButton.h"


@interface SureViewController ()

@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet BaseNextButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *showProtroButton;

@end

@implementation SureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.view.layer.cornerRadius = 10.0f;
    [self setupSubViews];
}
- (void)setupSubViews{
    
    self.nextButton.backgroundColor = REDCOLOR;
    [self.nextButton setTitle:@"确认本次借款申请" forState:UIControlStateNormal];
    [self.sureButton setImage:[UIImage imageNamed:@"步骤0"] forState:UIControlStateNormal];
    [self.sureButton setImage:[UIImage imageNamed:@"步骤"] forState:UIControlStateSelected];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:APPROVE_TEXT];
    NSDictionary *attDic = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    
    NSRange targetRange = NSMakeRange(4, attString.length - 4);
    [attString addAttributes:attDic range:targetRange];
    [self.showProtroButton setAttributedTitle:attString forState:UIControlStateNormal];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeButtonStatus:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)showProtro:(UIButton *)sender {
    
    LoanProtroWebController *protroWebController = [LoanProtroWebController new];
    [self.navigationController pushViewController:protroWebController animated:YES];

}
- (IBAction)nextAction:(UIButton *)sender {
    
    if (!self.sureButton.selected) {
        [SVProgressHUD showInfoWithStatus:@"请勾选米米贷微额贷款协议"];
        return;
    };
    if ([self.agreeDelegate respondsToSelector:@selector(didAgreeLoanProto:)]) {
        [self.agreeDelegate didAgreeLoanProto:self];
    }
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
