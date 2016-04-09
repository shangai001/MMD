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
#import "AppUserInfoHelper.h"


CGFloat const TOP_Y = 108;


@interface LoanViewController ()<HeaderViewDelegate>

@property (nonatomic, strong)HeaderView *headerView;


@property (nonatomic, strong)NewApplyViewController *apply;
@property (nonatomic, strong)LatestActivityController *activity;
@property (nonatomic, strong)QueryViewController *query;


@property (nonatomic,strong)UIViewController *currentViewController;

@end

@implementation LoanViewController
#pragma LazyLoad
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
        _activity.URLString = kProgressHostURL;
    }
    return _activity;
}
- (QueryViewController *)query{
    if (!_query) {
        _query = [[QueryViewController alloc] initWithNibName:NSStringFromClass([QueryViewController class]) bundle:[NSBundle mainBundle]];
    }
    return _query;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.title = @"借款";
    // Do any additional setup after loading the view.
    [self initHeaderView];
    [self initViewControllers];
}
- (void)initHeaderView{
    //Masonry布局
    [self.view addSubview:self.headerView];
    UIView *superHeaderView = self.headerView.superview;
    _headerView.sd_layout.leftEqualToView(superHeaderView).rightEqualToView(superHeaderView).topSpaceToView(superHeaderView,kTopLayoutGuide).heightIs(kNavigationBarHeight);
}
- (void)initViewControllers{
    
    [self addChildViewController:self.apply];
    [self addChildViewController:self.activity];
    [self addChildViewController:self.query];
    
    [self.view addSubview:self.apply.view];
    self.apply.view.frame = CGRectMake(0, TOP_Y, self.view.frame.size.width, self.view.frame.size.height - TOP_Y);
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
            if ([MMDLoggin isLoggin]) {
                //判断用户审核状态
                NSInteger status = [AppUserInfoHelper UserStatus];
            }
        }
            break;
        default:
            break;
    }
}
- (void)goFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController{
    
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.15 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        [fromViewController willMoveToParentViewController:nil];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.15 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut |UIViewAnimationOptionTransitionCurlDown animations:^{
            toViewController.view.frame = CGRectMake(0, TOP_Y, self.view.frame.size.width, self.view.frame.size.height - 108);
        } completion:nil];
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
