//
//  LoanDetaiController.m
//  MMD
//
//  Created by pencho on 16/4/9.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoanDetaiController.h"
#import "ConstantNotiName.h"
#import "LoanProtroWebController.h"


@interface LoanDetaiController ()

@end

@implementation LoanDetaiController

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToApplyprotrol:) name:UserMoveToApplyProtrol object:nil];
}
- (void)moveToApplyprotrol:(id)sender{
    
    LoanProtroWebController *protrolWeb = [LoanProtroWebController new];
    
    [self.navigationController pushViewController:protrolWeb animated:YES];
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
