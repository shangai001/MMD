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

    [self.loanSlider setThumbImage:[UIImage imageNamed:@"circle_blue_44"] forState:UIControlStateNormal];
    
    [self.refundTimeSlider setThumbImage:[UIImage imageNamed:@"Circle_Grey_44"] forState:UIControlStateNormal];
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
