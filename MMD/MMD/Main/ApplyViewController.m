//
//  ApplyViewController.m
//  MMD
//
//  Created by pencho on 16/2/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ApplyViewController.h"

@interface ApplyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loanTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanCountLbale;
@property (weak, nonatomic) IBOutlet UISlider *loanSlider;
@property (weak, nonatomic) IBOutlet UILabel *refundTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *refundTimeSlider;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;


@property (assign, nonatomic)int loanCount;
@property (assign, nonatomic)int refundMonth;

@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNextButton];
    [self configureSliders];
}
#pragma mark ConfigureUI
- (void)configureNextButton{
    self.nextButton.layer.cornerRadius = 4.0f;
}
- (void)configureSliders{

    {
        self.loanSlider.minimumValue = 5;
        self.loanSlider.maximumValue = 50;
        self.loanSlider.value = 5;
        
        
        [self.loanSlider setThumbImage:[UIImage imageNamed:@"circle_blue_44"] forState:UIControlStateNormal];
        [self.loanSlider addTarget:self action:@selector(loanCountChanged:) forControlEvents:UIControlEventValueChanged];
    }
    {
        self.refundTimeSlider.minimumValue = 1;
        self.refundTimeSlider.maximumValue = 6;
        self.refundTimeSlider.value = 1;
        
        [self.refundTimeSlider setThumbImage:[UIImage imageNamed:@"Circle_Grey_44"] forState:UIControlStateNormal];
        [self.refundTimeSlider addTarget:self action:@selector(refundTimeChanged:) forControlEvents:UIControlEventValueChanged];
    }
}
- (void)loanCountChanged:(UISlider *)slider{
    float value = slider.value;
    float newValue = roundf(value);
    int count = newValue * 100;
    self.loanCount = count;
    [self changeLoanCountLabel:count textColor:[UIColor redColor]];
}
#pragma mark 此处还需要获取当前颜色值
- (void)changeLoanCountLabel:(int)count textColor:(UIColor *)color{
    NSMutableAttributedString *attCountString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld元",(long)count]];
    NSRange numberRange = NSMakeRange(0, attCountString.length -1);
    NSDictionary *attrs = @{NSForegroundColorAttributeName : color};
    [attCountString addAttributes:attrs range:numberRange];
    self.loanCountLbale.attributedText = attCountString;
}
- (void)refundTimeChanged:(UISlider *)slider{
    float value = slider.value;
    float newValue = roundf(value);
    int count = (int)newValue;
    self.refundMonth = count;
    [self changeRefundMoth:count textColor:[UIColor orangeColor]];
}
- (void)changeRefundMoth:(int)count textColor:(UIColor *)color{
    NSMutableAttributedString *attCountString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld月",(long)count]];
    NSRange numberRange = NSMakeRange(0, attCountString.length -1);
    NSDictionary *attrs = @{NSForegroundColorAttributeName : color};
    [attCountString addAttributes:attrs range:numberRange];
    self.loanTimeLabel.attributedText = attCountString;
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
