//
//  MMTabbarController.m
//  MMD
//
//  Created by pencho on 16/2/16.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMTabbarController.h"
#import "TabbarTitleHeader.h"



@interface MMTabbarController ()

@end

@implementation MMTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureItems];
}
- (void)configureItems{
    UITabBar *tabbar = self.tabBar;
    UITabBarItem *loanItem = tabbar.items[0];
    loanItem.title = LOAN_TITLE;
    
    UITabBarItem *refundItem = tabbar.items[1];
    refundItem.title = REFUND_TITLE;
    
    UITabBarItem *mineItem = tabbar.items[2];
    mineItem.title = MINE_TITLE;
    
    UITabBarItem *moreItem = tabbar.items[3];
    moreItem.title = MORE_TITLE;
    
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
