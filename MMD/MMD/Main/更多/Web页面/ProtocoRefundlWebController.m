//
//  ProtocoRefundlWebController.m
//  MMD
//
//  Created by pencho on 16/4/22.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ProtocoRefundlWebController.h"
#import "ConstantTitle.h"



@interface ProtocoRefundlWebController ()

@end

@implementation ProtocoRefundlWebController

- (void)viewDidLoad {
    
    self.URLString = [NSString stringWithFormat:@"%@/webview/repaymentNotice",kHostURL];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = REFUND_TITLE;
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
