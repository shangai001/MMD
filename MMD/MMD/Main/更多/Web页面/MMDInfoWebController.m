//
//  MMDInfoWebController.m
//  MMD
//
//  Created by pencho on 16/4/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MMDInfoWebController.h"
#import "ConstantTitle.h"


@interface MMDInfoWebController ()

@end

@implementation MMDInfoWebController

- (void)viewDidLoad {
    
    self.URLString = [NSString stringWithFormat:@"%@/webview/about",kHostURL];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = ABOUTMMD_TITLE;
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
