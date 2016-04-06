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
#import <UIView+SDAutoLayout.h>

@interface VerifyViewController ()

@property (nonatomic, strong)StageView *stageView;
@property (nonatomic, strong)FirstStepController *first;
@property (nonatomic, strong)SecondStaepController *second;
@property (nonatomic, strong)ThirdStepController *third;

@end

#define StageHeight 60
#define STAGETOLEFT 0

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
    self.stageView = [[StageView alloc] initWithStyle:kHorizontalStyle stage:3 frame:CGRectMake(STAGETOLEFT, kTopLayoutGuide, YYScreenSize().width - 2 * STAGETOLEFT , StageHeight)];
    [self.view addSubview:self.stageView];
}
- (void)addStepsController{
    self.first = [[FirstStepController alloc] initWithNibName:NSStringFromClass([FirstStepController class]) bundle:[NSBundle mainBundle]];
    [self addChildViewController:self.first];
    
    self.second = [[SecondStaepController alloc] initWithNibName:NSStringFromClass([SecondStaepController class]) bundle:[NSBundle mainBundle]];
    [self addChildViewController:self.second];
    
    self.third = [[ThirdStepController alloc] initWithNibName:NSStringFromClass([ThirdStepController class]) bundle:[NSBundle mainBundle]];
    //添加autolayout
    if (_status == 0) {
        [self.view addSubview:self.first.view];
        [self addSDautoLayout:self.first.view];
        [self.first didMoveToParentViewController:self];
    }else if (_status == 1){
        [self.view addSubview:self.second.view];
        [self addSDautoLayout:self.second.view];
        [self.second didMoveToParentViewController:self];
    }else if (_status == 2){
        [self.view addSubview:self.third.view];
        [self addSDautoLayout:self.third.view];
        [self.third didMoveToParentViewController:self];
    }
}
- (void)addSDautoLayout:(UIView *)view{
    view.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view,kTopLayoutGuide + StageHeight)
    .bottomEqualToView(self.view);
}
- (void)setStatus:(NSInteger)status{
    _status = status;
}
- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion{
    /*
     2.当调用willMoveToParentViewController方法或didMoveToParentViewController方法时，要注意他们的参数使用：
     
     当某个子视图控制器将从父视图控制器中删除时，parent参数为nil。
     
     即：[将被删除的子试图控制器 willMoveToParentViewController:nil];
     
     当某个子试图控制器将加入到父视图控制器时，parent参数为父视图控制器。
     
     即：[将被加入的子视图控制器 didMoveToParentViewController:父视图控制器];
     
     */
    [UIView animateKeyframesWithDuration:0.15 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        [self.view addSubview:toViewController.view];
        [fromViewController willMoveToParentViewController:nil];
        //添加autolayout
        toViewController.view.sd_layout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .bottomEqualToView(self.view)
        .topSpaceToView(self.view,kTopLayoutGuide + StageHeight);
        
    } completion:^(BOOL finished) {
        [toViewController didMoveToParentViewController:self];
    }];
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
