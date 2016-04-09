//
//  QueryViewController.m
//  MMD
//
//  Created by pencho on 16/2/17.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "QueryViewController.h"
#import "StageView.h"
#import <YYCGUtilities.h>
#import "ColorHeader.h"
#import <UIView+SDAutoLayout.h>
#import "ConstantHeight.h"


CGFloat const stageWidth = 60;
CGFloat const stageBottomToSuper = 80;


@interface QueryViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)StageView *stageView;
@property (nonatomic, strong)UIView *containerView;

@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self configureScroolView];
    [self initStageView];
}
- (void)configureScroolView{
    
}
- (void)initStageView{
    
    self.scrollView.sd_layout
    .leftSpaceToView(self.view,20)
    .rightSpaceToView(self.view,20)
    .topEqualToView(self.view)
    .bottomSpaceToView(self.view, kTabbarHeight + 20);
//    self.scrollView.contentSize = CGSizeMake(kScreenWidth - 40, kScreenHeight + 200);
    [self.scrollView updateLayout];
//    self.containerView  = [UIView new];
//    self.containerView.backgroundColor = [UIColor whiteColor];
//    self.containerView.layer.cornerRadius = 10.0f;
//    [self.scrollView addSubview:self.containerView];
//    
//    self.containerView.sd_layout
//    .leftSpaceToView(self.view,20)
//    .rightSpaceToView(self.view,20)
//    .topEqualToView(self.view)
//    .bottomSpaceToView(self.view, kTabbarHeight + 20);
//    
//    [self.containerView updateLayout];
    
    CGFloat stageHeight = self.containerView.frame.size.height - stageBottomToSuper;
    self.stageView = [[StageView alloc] initWithStyle:kverticalTypeStyle stage:4 frame:CGRectMake(20, 0, stageWidth, stageHeight)];
    [self.scrollView addSubview:self.stageView];
    
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
