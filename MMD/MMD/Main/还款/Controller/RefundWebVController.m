//
//  RefundWebVController.m
//  MMD
//
//  Created by pencho on 16/4/20.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RefundWebVController.h"
#import "ColorHeader.h"
#import <UIView+SDAutoLayout.h>

@interface RefundWebVController ()

@property (nonatomic, strong)UIButton *repayButton;

@end

@implementation RefundWebVController

- (UIButton *)repayButton{
    if (!_repayButton) {
        _repayButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_repayButton setTitle:@"在线支付" forState:UIControlStateNormal];
        _repayButton.backgroundColor = REDCOLOR;
        [_repayButton addTarget:self action:@selector(moveToRepay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _repayButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decideRepay];
}
- (void)decideRepay{
    if (self.detaiType == kRefundDetailType) {
        [self.view addSubview:self.repayButton];
        self.repayButton.sd_layout.leftEqualToView(self.view).heightIs(60).rightEqualToView(self.view).bottomEqualToView(self.view);
        [self.repayButton updateLayout];
    }
}
- (void)moveToRepay:(id)sender{
    
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
