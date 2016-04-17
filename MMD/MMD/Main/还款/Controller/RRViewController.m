//
//  RRViewController.m
//  MMD
//
//  Created by pencho on 16/4/15.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RRViewController.h"
#import "ColorHeader.h"
//#import "ShouldRefundTableViewController.h"
//#import "AlreadyRefundTableViewController.h"
#import <UIView+SDAutoLayout.h>
#import "RRFirstViewController.h"
#import "RRSecondViewController.h"


CGFloat const gap = 20;

@interface RRViewController ()


@property (nonatomic, strong)RRFirstViewController *first;
@property (nonatomic, strong)RRSecondViewController *second;

@property (nonatomic, strong)UIViewController *currenrController;


@property (weak, nonatomic) IBOutlet UIView *buttonHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *shouldButton;
@property (weak, nonatomic) IBOutlet UIButton *alreadyButton;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineCenterX;


@end

@implementation RRViewController
- (RRFirstViewController *)first{
    if (!_first) {
        _first = [RRFirstViewController new];
    }
    return _first;
}
- (RRSecondViewController *)second{
    if (!_second) {
        _second = [RRSecondViewController new];
    }
    return _second;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"还款";
    self.view.backgroundColor = [UIColor yellowColor];
    [self configureButtons];
    [self addViewControllers];
}
- (void)configureButtons{
    
    [self.shouldButton setTitleColor:REDCOLOR forState:UIControlStateNormal];
    [self.alreadyButton setTitleColor:REDCOLOR forState:UIControlStateNormal];
    
}
- (void)addViewControllers{
    
    [self addChildViewController:self.first];
    [self addChildViewController:self.second];
    [self.view addSubview:self.first.view];
    [self addLayoutToView:self.first.view];
    [self.first.view updateLayout];
    [self.first didMoveToParentViewController:self];
    self.currenrController = self.first;
    [self.view layoutIfNeeded];
}
//添加 layout
- (void)addLayoutToView:(UIView *)view{

    view.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.buttonHeaderView,gap).bottomSpaceToView(self.view,0);
    [view updateLayout];
}
- (IBAction)shouldAction:(id)sender {
    
    if (self.currenrController == self.first) {
        //刷新数据
    }else{
        [self goFrom:self.currenrController to:self.first];
    }
    [self lineViewAnniation:self.shouldButton.tag];
}
- (IBAction)alreadyAction:(id)sender {
    if (self.currenrController == self.second) {
        //刷新数据
        
    }else{
        [self goFrom:self.currenrController to:self.second];
    }
    [self lineViewAnniation:self.alreadyButton.tag];
}
//移动底部线条
- (void)lineViewAnniation:(NSInteger)senderTag{
    
    CGFloat width = self.buttonHeaderView.frame.size.width/2;
    if (senderTag == 100) {
        self.lineCenterX.constant = 0;
    }else if (senderTag == 101){
        self.lineCenterX.constant = width;
    }
    [self.buttonHeaderView layoutIfNeeded];
}
//切换子控制器
- (void)goFrom:(UIViewController *)fromController to:(UIViewController *)toViewController{
    
    [self transitionFromViewController:fromController toViewController:toViewController duration:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        [fromController willMoveToParentViewController:nil];
        [self addLayoutToView:toViewController.view];
    } completion:^(BOOL finished) {
        [toViewController didMoveToParentViewController:self];
        self.currenrController = toViewController;
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
