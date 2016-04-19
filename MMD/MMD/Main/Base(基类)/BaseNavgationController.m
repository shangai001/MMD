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
#import "VerifyViewController.h"
#import "MMLogViewController.h"


@interface BaseNavgationController ()

@end

@implementation BaseNavgationController

+ (void)initialize{
    
    //1.设置状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //2.设置bar北京
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    UIColor *barBackColor = REDCOLOR;
    [navBar setBarTintColor:barBackColor];
    // 3.设置标题文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] =[UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:attrs];
    //4.设置后退文字颜色
    [navBar setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.extendedLayoutIncludesOpaqueBars = YES;
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    //如果是在登录或者完善资料页面,后退事件改为[self popToRootViewControllerAnimated:YES]emi
    //| [self.visibleViewController isKindOfClass:[MMLogViewController class]]
    if ([self.visibleViewController isKindOfClass:[VerifyViewController class]]) {
        [self popToRootViewControllerAnimated:YES];
        return nil;
    }
    return [super popViewControllerAnimated:animated];
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
