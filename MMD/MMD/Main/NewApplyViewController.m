//
//  NewApplyViewController.m
//  MMD
//
//  Created by pencho on 16/2/19.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "NewApplyViewController.h"
#import "ColorHeader.h"

@interface NewApplyViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation NewApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    self.nextButton.backgroundColor = REDCOLOR;
    
    [self configurePickerView];
    [self configureMoneyPicker];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
