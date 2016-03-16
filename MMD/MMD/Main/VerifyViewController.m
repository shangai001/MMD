//
//  VerifyViewController.m
//  MMD
//
//  Created by pencho on 16/3/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "VerifyViewController.h"
#import "StageView.h"

@interface VerifyViewController ()

@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首次信息确认";
    StageView *stageV = [[StageView alloc] initWithStyle:kHorizontalStyle stage:3 frame:CGRectMake(10, 100, 300, 40)];
    stageV.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:stageV];
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
