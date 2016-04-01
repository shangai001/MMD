//
//  NewApplyViewController.m
//  MMD
//
//  Created by pencho on 16/2/19.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "NewApplyViewController.h"
#import "ColorHeader.h"
//#import "MMLogViewController.h"
#import "VerifyViewController.h"

#import "BaseNavgationController.h"

@interface NewApplyViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation NewApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.nextButton.backgroundColor = REDCOLOR;
    
    [self configurePickerView];
    [self configureMoneyPicker];
    [self configureUI];
}
- (void)configureUI{
    self.view.layer.masksToBounds = YES;
    self.topView.layer.cornerRadius = 15.0f;
    self.bottomView.layer.cornerRadius = 15.0f;
}
- (void)configureMoneyPicker{
    self.moneyCount = 500;
    [self.increaseButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.increaseButton setImage:[UIImage imageNamed:@"add_press"] forState:UIControlStateHighlighted];
    [self.decreaseButton setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    [self.decreaseButton setImage:[UIImage imageNamed:@"minus_press"] forState:UIControlStateHighlighted];
}

- (IBAction)decreaseCount:(id)sender {
    if (500 < self.moneyCount) {
        self.moneyCount -= 500;
    }
}
- (IBAction)increaseCount:(id)sender {
    if (self.moneyCount < 5000) {
        self.moneyCount += 500;
    }
}
- (void)configurePickerView{
    self.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    self.monthPicker.delegate = self;
    self.monthPicker.dataSource = self;
}
- (void)setMoneyCount:(NSUInteger)moneyCount{
    _moneyCount = moneyCount;
    NSString *number = [NSString stringWithFormat:@"%ld",(long)moneyCount];
    UIColor *redTextColor = [UIColor colorWithRed:0.78 green:0.24 blue:0.14 alpha:1];
    NSDictionary *attInfo = @{NSForegroundColorAttributeName : redTextColor,NSFontAttributeName : [UIFont systemFontOfSize:14]};
    NSAttributedString *numberAttString = [[NSAttributedString alloc] initWithString:number attributes:attInfo];
    self.moneyNumLabel.attributedText = numberAttString;
}
- (void)updateRefundLabel{

}
#pragma mark UIPickerView
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 50;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0){
        if (row < self.dataArray.count) {
            NSString *normalString = [NSString stringWithFormat:@"%@",self.dataArray[row]];
            UIColor *monthColor = [UIColor colorWithRed:0.31 green:0.61 blue:0.73 alpha:1];
            NSDictionary *attInfo = @{NSForegroundColorAttributeName : monthColor,NSFontAttributeName : [UIFont systemFontOfSize:14]};
            NSAttributedString *mothAttString = [[NSAttributedString alloc] initWithString:normalString attributes:attInfo];
            return mothAttString;
        }
    }
    return nil;
}// attributed title is favored if both methods are implemented
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (self.dataArray.count > row) {
        NSString *text = self.dataArray[row];
        self.refundMonth = [text integerValue];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextAction:(id)sender {
    /*
    //登录
    MMLogViewController *logger = [[MMLogViewController alloc] initWithNibName:NSStringFromClass([MMLogViewController class]) bundle:[NSBundle mainBundle]];
    BaseNavgationController *baseNav = [[BaseNavgationController alloc] initWithRootViewController:logger];
    [self presentViewController:baseNav animated:YES completion:nil];
     */
    VerifyViewController *verifyer = [[VerifyViewController alloc] initWithNibName:NSStringFromClass([VerifyViewController class]) bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:verifyer animated:YES];
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
