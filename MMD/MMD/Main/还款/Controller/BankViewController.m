//
//  BankViewController.m
//  MMD
//
//  Created by pencho on 16/4/20.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BankViewController.h"
#import "ConstantNotiName.h"
#import "PostRepayController.h"


@interface BankViewController ()

@end

@implementation BankViewController


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRepayByBank:) name:UserDidRepayByBank object:nil];
}
- (void)didRepayByBank:(id)sender{
    
    PostRepayController *poster = [[PostRepayController alloc] initWithNibName:NSStringFromClass([PostRepayController class]) bundle:[NSBundle mainBundle]];
    poster.albumOptional = NO;
    [self.navigationController pushViewController:poster animated:YES];
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
