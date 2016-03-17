//
//  VerifyViewController.m
//  MMD
//
//  Created by pencho on 16/3/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "VerifyViewController.h"
#import "StageView.h"
#import <Masonry.h>
#import "ColorHeader.h"

@interface VerifyViewController ()
@property (weak, nonatomic) IBOutlet UIView *headerBackView;

@property (nonatomic, strong)StageView *stageView;

@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首次信息确认";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self initStageView];
}
- (void)initStageView{
    self.stageView = [[StageView alloc] initWithStyle:kHorizontalStyle stage:3 frame:CGRectMake(0, 64, ScreenWidth - 2 * 0 , 60)];
    [self.headerBackView addSubview:self.stageView];
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
