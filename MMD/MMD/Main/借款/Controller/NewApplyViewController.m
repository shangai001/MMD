//
//  NewApplyViewController.m
//  MMD
//
//  Created by pencho on 16/2/19.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "NewApplyViewController.h"
#import "ColorHeader.h"
#import "MMLogViewController.h"
#import "VerifyViewController.h"
#import "BaseNavgationController.h"

//-------test----------
#import "HttpRequest.h"
#import "LoanVerifyController.h"
#import "CalculateRefund.h"


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
    [self initDefaultValue];
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
- (void)initDefaultValue{
    self.moneyCount = 500;
    self.refundMonth = 1;
    [self updateRefundLabel];
}
- (IBAction)decreaseCount:(id)sender {
    if (500 < self.moneyCount) {
        self.moneyCount -= 500;
    }
    [self updateRefundLabel];
}
- (IBAction)increaseCount:(id)sender {
    if (self.moneyCount < 5000) {
        self.moneyCount += 500;
    }
    [self updateRefundLabel];
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
    [self updateRefundLabel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextAction:(id)sender {
    //判断是否登录
    BOOL isLogged = NO;
    if (isLogged) {
        //已经登录
        
    }else{
        /*
        NSString *testUrl = @"http://123.103.22.206:8081/api/getBootCoverImage?userId=0&type=1&version=1.2.7";
        [HttpRequest getWithURLString:testUrl parameters:nil success:^(id responseObject) {
            NSLog(@"-->%@",responseObject);
        } failure:^(NSError *error) {
            NSLog(@"-->%@",error);
        }];
         */

        //未登录
        MMLogViewController *logger = [[MMLogViewController alloc] initWithNibName:NSStringFromClass([MMLogViewController class]) bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:logger animated:YES];
        /*
        LoanVerifyController *loanVerifyer = [LoanVerifyController new];
        [self.navigationController pushViewController:loanVerifyer animated:YES];
         */
    }
    /*
    VerifyViewController *verifyer = [[VerifyViewController alloc] initWithNibName:NSStringFromClass([VerifyViewController class]) bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:verifyer animated:YES];
     */
    
}
#pragma mark UpdateRefundNumber
- (void)updateRefundLabel{
    
    NSUInteger loanCount = self.moneyCount;
    NSUInteger timeMonth = self.refundMonth;
    NSUInteger refundCount = [CalculateRefund calculateRefundWithNumber:loanCount time:timeMonth];
    
    NSString *countString = [NSString stringWithFormat:@"%@",@(refundCount)];
    NSString *timeString = [NSString stringWithFormat:@"%@",@(timeMonth)];
    //借款到账日后30天还款，每期还款XXX元，共X期
    NSString *baseString = @"借款到账日后30天还款，每期还款元，共期";
    NSString *aString = @"每期还款";
    NSString *bString = @"共";
    NSRange countRange = NSMakeRange(0,countString.length);
    NSRange timeRange = NSMakeRange(0, timeString.length);
    
    //计算还款数位置
    if ([baseString rangeOfString:aString].location != NSNotFound) {
        NSRange aRange = [baseString rangeOfString:aString];
        countRange.location = aRange.location + aRange.length;
    }
    //计算还款时间未知
    if ([baseString rangeOfString:bString].location != NSNotFound) {
        NSRange bRange = [baseString rangeOfString:bString];
        timeRange.location = bRange.location + bRange.length;
    }
    if (countRange.location != 0 && timeRange.location != 0) {
        NSMutableAttributedString *refundTipString = [[NSMutableAttributedString alloc] initWithString:baseString];
        //非数字属性字符串
        [refundTipString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, refundTipString.length)];
        //还款数 属性字符串
        NSAttributedString *countAttString = [[NSAttributedString alloc] initWithString:countString attributes:@{NSForegroundColorAttributeName:REDCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        //插入还款数
        [refundTipString insertAttributedString:countAttString atIndex:countRange.location];
        //还款时间属性字符串
        NSAttributedString *timeAttString = [[NSAttributedString alloc] initWithString:timeString attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        //插入时间(不要忘记位置偏移还款数的位数!!!)
        [refundTipString insertAttributedString:timeAttString atIndex:timeRange.location + countAttString.length];
        self.infoLabel.attributedText = refundTipString;
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
