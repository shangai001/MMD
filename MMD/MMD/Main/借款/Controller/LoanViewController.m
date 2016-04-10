//
//  LoanViewController.m
//  MMD
//
//  Created by pencho on 16/2/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoanViewController.h"
#import "LoanHeader.h"
#import "ConstantHeight.h"
#import <UIView+SDAutoLayout.h>
#import "ColorHeader.h"
#import "MMDLoggin.h"
#import "HandleUserStatus.h"
#import "LogginHandler.h"




CGFloat const TOP_Y = 113;

@interface LoanViewController ()<HeaderViewDelegate,UITabBarControllerDelegate>

@property (nonatomic, strong)HeaderView *headerView;
@property (nonatomic, strong)NewApplyViewController *apply;
@property (nonatomic, strong)LatestActivityController *activity;
@property (nonatomic, strong)QueryViewController *query;
@property (nonatomic,strong)UIViewController *currentViewController;

@end

@implementation LoanViewController

#pragma mark UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    UINavigationController *NAV = (UINavigationController *)tabBarController.selectedViewController;
    if (index == 1 || index == 2) {
        if ([MMDLoggin isLoggin]) {
            //已经登录去完善页面
            return [HandleUserStatus handleUserStatusAt:NAV.topViewController];
        }else{
            //未登录去登录页面
            [LogginHandler shouldLogginAt:NAV];
            return NO;
        }
    }
    return YES;
}
#pragma mark LazyLoad
- (HeaderView *)headerView{
    if (!_headerView) {
        _headerView = [HeaderView loadViewFromNib];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.headerDelegate = self;
        _headerView.selectedIndex = 0;
    }
    return _headerView;
}
- (NewApplyViewController *)apply{
    if (!_apply) {
        _apply = [[NewApplyViewController alloc] initWithNibName:NSStringFromClass([NewApplyViewController class]) bundle:[NSBundle mainBundle]];
    }
    return _apply;
}
- (LatestActivityController *)activity{
    if (!_activity) {
        _activity = [LatestActivityController new];
    }
    return _activity;
}
- (QueryViewController *)query{
    if (!_query) {
        _query = [[QueryViewController alloc] initWithNibName:NSStringFromClass([QueryViewController class]) bundle:[NSBundle mainBundle]];
    }
    return _query;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"借款";
    // Do any additional setup after loading the view.
    [self initHeaderView];
    [self initViewControllers];
    
    self.tabBarController.delegate = self;
}
- (void)initHeaderView{
    //Masonry布局
    [self.view addSubview:self.headerView];
    self.headerView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view,kTopLayoutGuide).heightIs(49);
    [_headerView updateLayout];
}
- (void)initViewControllers{
    
    [self addChildViewController:self.apply];
    [self addChildViewController:self.activity];
    [self addChildViewController:self.query];
    
    [self.view addSubview:self.apply.view];
    self.apply.view.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view,TOP_Y).rightEqualToView(self.view).bottomEqualToView(self.view);
    [self.apply didMoveToParentViewController:self];
    self.currentViewController = self.apply;
    
}
- (void)setChildViewFrame:(UIView *)view{
    UIView *parentView = view.superview;
    view.sd_layout.leftSpaceToView(parentView,TOP_Y).rightEqualToView(parentView).bottomEqualToView(parentView).topSpaceToView(parentView,TOP_Y);
}
#pragma mark HeaderViewDelegate
- (void)didSelectButton:(UIButton *)button buttonIndex:(NSUInteger)index{

    UIViewController *toVC = nil;
    switch (index) {
        case 0:
        {
            toVC = self.apply;
            [self goFromViewController:self.currentViewController toViewController:toVC];
        }
            break;
        case 1:
        {
            toVC = self.activity;
            [self goFromViewController:self.currentViewController toViewController:toVC];
        }
            break;
        case 2:
        {
            toVC = self.query;
            [self checkoutUserCanGo:toVC];
        }
            break;
        default:
            break;
    }
}
- (void)checkoutUserCanGo:(UIViewController *)toVC{
    //检查是否登录
    if ([MMDLoggin isLoggin]) {
        //登录成功,检查用户用户状态
        if ([HandleUserStatus handleUserStatusAt:self]) {
            [self goFromViewController:self.currentViewController toViewController:toVC];
        }
    }else{
        //去登录
        [LogginHandler shouldLogginAt:self];
    }
}
- (void)goFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController{
    
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.2 options:UIViewAnimationOptionTransitionNone animations:^{
        
        [fromViewController willMoveToParentViewController:nil];
    } completion:^(BOOL finished) {
        if ([toViewController isEqual:self.query]) {
            [self.query requestLoanStatus];
        }else if ([toViewController isEqual:self.activity]){
            self.activity.URLString = kProgressHostURL;
            [self.activity requestUrl:kProgressHostURL];
        }
        toViewController.view.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view,TOP_Y).rightEqualToView(self.view).bottomEqualToView(self.view);
        self.currentViewController = toViewController;
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
