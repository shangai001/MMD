//
//  MMTabbarController.m
//  MMD
//
//  Created by pencho on 16/2/16.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMTabbarController.h"
#import "ConstantTitle.h"
#import "MMTabbar.h"
#import "ColorHeader.h"
#import "MMDLoggin.h"
#import "MineModel.h"


@interface MMTabbarController ()
@property (nonatomic, strong)MMTabbar *imageHelper;
@end

@implementation MMTabbarController
- (MMTabbar *)imageHelper{
    if (!_imageHelper) {
        _imageHelper = [MMTabbar new];
    }
    return _imageHelper;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureItems];
}
- (void)configureItems{
    UITabBar *tabbar = self.tabBar;
    tabbar.tintColor = REDCOLOR;
    tabbar.barTintColor = [UIColor whiteColor];
    
    
    UITabBarItem *loanItem = tabbar.items[0];
    loanItem.title = LOAN_TABBARITEMTITLE;
    loanItem.image = self.imageHelper.loanOffImage;
    loanItem.selectedImage = self.imageHelper.loanOnImage;
    
    UITabBarItem *refundItem = tabbar.items[1];
    refundItem.title = REFUND_TABBARITEMTITLE;
    refundItem.image = self.imageHelper.reOffImage;
    refundItem.selectedImage = self.imageHelper.reOnImage;
    
    UITabBarItem *mineItem = tabbar.items[2];
    mineItem.title = MINE_TABBARITEMTITLE;
    mineItem.image = self.imageHelper.mineOffImage;
    mineItem.selectedImage = self.imageHelper.mineOnImage;
//    mineItem.badgeValue = @"9";
    
    UITabBarItem *moreItem = tabbar.items[3];
    moreItem.title = MORE_TABBARITEMTITLE;
    moreItem.image = self.imageHelper.moreOffImage;
    moreItem.selectedImage = self.imageHelper.mineOnImage;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSInteger index = [tabBar.items indexOfObject:item];
    if (index == 3) {
        [self queryAllNotifications:item];
    }
}
- (void)queryAllNotifications:(UITabBarItem *)mineItem{
    
    [MineModel queryAllNotifications:nil success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            NSInteger count = [resultDic[@"data"] integerValue];
            if (count != 0) {
                mineItem.badgeValue = [NSString stringWithFormat:@"%@",resultDic[@"data"]];
            }
        }
    } failure:^(NSError *error) {
        
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
