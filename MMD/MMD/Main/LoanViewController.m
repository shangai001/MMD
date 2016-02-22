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


@interface LoanViewController ()

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
        _headerView.backgroundColor = [UIColor orangeColor];
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
    
    NSLog(@"导航  %@",self.);
    
    [self.navigationController.view addSubview:self.headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).with.offset(88);
        make.height.mas_equalTo(44);
    }];
}
- (void)initViewControllers{
    
    [self addChildViewController:self.apply];
    [self addChildViewController:self.activity];
    [self addChildViewController:self.query];
    
    self.apply.view.frame = self.view.bounds;
    [self.view addSubview:self.apply.view];
    [self.apply didMoveToParentViewController:self];
    self.currentViewController = self.apply;
    
}
/*
- (void)didSelectSegment:(MMSegmentControl *)segment{
    NSUInteger index = segment.selectedSegmentIndex;
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
            self.currentViewController = toVC;
        }
    }];
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
