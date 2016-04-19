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

CGFloat buttonHeight = 44;

@interface RefundWebVController ()

@property (nonatomic, strong)UIButton *repayButton;

@end

@implementation RefundWebVController

- (UIButton *)repayButton{
    if (!_repayButton) {
        _repayButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_repayButton setTitle:@"在线支付" forState:UIControlStateNormal];
        [_repayButton setTintColor:[UIColor whiteColor]];
        _repayButton.backgroundColor = REDCOLOR;
        [_repayButton addTarget:self action:@selector(moveToRepay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _repayButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"借款详情";
    [self decideRepay];
}
- (void)decideRepay{
    if (self.detaiType == kRefundDetailType) {
        [self.view addSubview:self.repayButton];
        self.repayButton.sd_layout.leftSpaceToView(self.view,10).heightIs(buttonHeight).rightSpaceToView(self.view,10).bottomSpaceToView(self.view,0);
        self.repayButton.layer.cornerRadius = 10;
        self.repayButton.layer.masksToBounds = YES;
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
