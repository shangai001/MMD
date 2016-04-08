//
//  BaseNavgationController.m
//  MMD
//
//  Created by pencho on 16/2/19.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseNavgationController.h"
#import "UIImage+Color.h"
#import "ColorHeader.h"
#import "ConstantHeight.h"
#import <YYCGUtilities.h>


@interface BaseNavgationController ()

@end

@implementation BaseNavgationController

+ (void)initialize{
    
    
    //1.设置状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //2.设置bar北京
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIColor *barBackColor = REDCOLOR;
    UIImage *barBackImage = [UIImage imageWithColor:barBackColor size:CGSizeMake(kScreenWidth, 44)];
    [navBar setBackgroundImage:barBackImage forBarMetrics:UIBarMetricsDefault];
    
    
    // 3.设置文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] =[UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:attrs];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
