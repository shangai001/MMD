//
//  LoanViewController.m
//  MMD
//
//  Created by pencho on 16/2/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoanViewController.h"
#import "LoanHeader.h"
#import "Masonry.h"



#define TOP_Y 108

@interface LoanViewController ()<HeaderViewDelegate>

@property (nonatomic, strong)HeaderView *headerView;


@property (nonatomic, strong)NewApplyViewController *apply;
@property (nonatomic, strong)ActivityViewController *activity;
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
- (ActivityViewController *)activity{
    if (!_activity) {
        _activity = [[ActivityViewController alloc] initWithNibName:NSStringFromClass([ActivityViewController class]) bundle:[NSBundle mainBundle]];
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"借款";
    // Do any additional setup after loading the view.
    [self initHeaderView];
    [self initViewControllers];
}
- (void)initHeaderView{
    //Masonry布局
    [self.view addSubview:self.headerView];
    UIView *superHeaderView = self.headerView.superview;
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superHeaderView.mas_left);
        make.right.equalTo(superHeaderView.mas_right);
        make.top.equalTo(superHeaderView.mas_top).with.offset(64);
        make.height.mas_equalTo(44);
    }];
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
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(parentView.mas_top).with.offset(TOP_Y);
        make.left.equalTo(parentView.mas_left);
        make.right.equalTo(parentView.mas_right);
        make.bottom.equalTo(parentView.mas_bottom);
    }];
}
#pragma mark HeaderViewDelegate
- (void)didSelectButton:(UIButton *)button buttonIndex:(NSUInteger)index{

    UIViewController *toVC = nil;
    switch (index) {
        case 0:
        {
            toVC = self.apply;
        }
            break;
        case 1:
        {
            toVC = self.activity;
        }
            break;
        case 2:
        {
            toVC = self.query;
        }
            break;
        default:
            break;
    }
    
    [self transitionFromViewController:self.currentViewController toViewController:toVC duration:0.15 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            [toVC didMoveToParentViewController:self];
            toVC.view.frame = CGRectMake(0, TOP_Y, self.view.frame.size.width, self.view.frame.size.height - 108);
            self.currentViewController = toVC;
        }
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
