//
//  VerifyViewController.m
//  MMD
//
//  Created by pencho on 16/3/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "VerifyViewController.h"
#import "StageView.h"
#import "ColorHeader.h"
#import "HeightHeader.h"
#import "FirstStepController.h"
#import "SecondStaepController.h"
#import "ThirdStepController.h"


@interface VerifyViewController ()

@property (nonatomic, strong)StageView *stageView;
@property (nonatomic, strong)FirstStepController *first;
@property (nonatomic, strong)SecondStaepController *second;
@property (nonatomic, strong)ThirdStepController *third;

@end

#define StageHeight 60


@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首次信息确认";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self initStageView];
    [self addStepsController];
}
- (void)initStageView{
    
    self.stageView = [[StageView alloc] initWithStyle:kHorizontalStyle stage:3 frame:CGRectMake(0, kTopLayoutGuide, ScreenWidth - 2 * 0 , StageHeight)];
    [self.view addSubview:self.stageView];
}
- (void)addStepsController{
    _first = [[FirstStepController alloc] initWithNibName:NSStringFromClass([FirstStepController class]) bundle:[NSBundle mainBundle]];
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
