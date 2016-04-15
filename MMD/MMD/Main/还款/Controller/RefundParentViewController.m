//
//  RefundParentViewController.m
//  MMD
//
//  Created by pencho on 16/4/14.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "RefundParentViewController.h"
#import "ShouldRefundTableViewController.h"
#import "AlreadyRefundTableViewController.h"
#import "RefundHeaderView.h"
#import "UIView+LoadViewFromNib.h"
#import <UIView+SDAutoLayout.h>
#import "ColorHeader.h"



CGFloat const Edge = 20;

@interface RefundParentViewController ()

@property (nonatomic ,strong)ShouldRefundTableViewController *first;
@property (nonatomic, strong)AlreadyRefundTableViewController *second;
@property (nonatomic, strong)RefundHeaderView *reHeaderView;

@property (strong, nonatomic)UIViewController *currentViewController;

@end

@implementation RefundParentViewController
- (ShouldRefundTableViewController *)first{
    if (!_first) {
        _first = [ShouldRefundTableViewController new];
    }
    return _first;
}
- (AlreadyRefundTableViewController *)second{
    if (!_second) {
        _second = [AlreadyRefundTableViewController new];
    }
    return _second;
}
- (RefundHeaderView *)reHeaderView{
    if (!_reHeaderView) {
        _reHeaderView = [RefundHeaderView loadViewFromNib];
        _reHeaderView.backgroundColor = [UIColor orangeColor];
    }
    return _reHeaderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"还款";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initHeaderView];
    [self addchildVC];
}
- (void)initHeaderView{

    self.reHeaderView.SwitchBlock= ^(NSInteger index){
        
    };
    [self.view addSubview:self.reHeaderView];

    self.reHeaderView.sd_layout.leftSpaceToView(self.view,Edge).topSpaceToView(self.view,Edge).heightIs(44).rightSpaceToView(self.view,Edge);
}
- (void)addchildVC{
    
    [self addChildViewController:self.first];
    [self addChildViewController:self.second];
    
    [self.view addSubview:self.first.view];
    
    self.first.view.sd_layout.leftSpaceToView(self.view,Edge).topSpaceToView(self.reHeaderView,Edge).rightSpaceToView(self.view,Edge).bottomSpaceToView(self.view,Edge);
    
    [self.first didMoveToParentViewController:self];
    self.currentViewController = self.first;
}
/*
- (void)setIndex:(NSInteger)index{
    _index = index;
    if (![self.childViewControllers containsObject:self.first]) {
        [self addChildViewController:self.first];
    }
    if (![self.childViewControllers containsObject:self.second]) {
        [self addChildViewController:self.second];
    }
    UIViewController *toViewController = nil;
    if (_index == 0) {
        toViewController = self.first;
    }else if (_index == 1){
        toViewController = self.second;
    }
    

    
    if (toViewController) {
        
        [self transitionFromViewController:self.currentViewController toViewController:toViewController duration:0.15 options:UIViewAnimationOptionTransitionNone animations:^{
            
            [self.currentViewController willMoveToParentViewController:nil];
            [self.view addSubview:toViewController.view];
            
            toViewController.view.sd_layout.leftSpaceToView(self.view,Edge).topSpaceToView(self.reHeaderView,Edge).rightSpaceToView(self.view,Edge).bottomSpaceToView(self.view,Edge);
        } completion:^(BOOL finished) {
            
            [toViewController didMoveToParentViewController:self];
            self.currentViewController = toViewController;
            
        }];

    }
 }
 */

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
