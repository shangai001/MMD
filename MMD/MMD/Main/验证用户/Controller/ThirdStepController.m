//
//  ThirdStepController.m
//  MMD
//
//  Created by pencho on 16/3/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "ThirdStepController.h"
#import <UIView+SDAutoLayout.h>
#import "ColorHeader.h"
#import "FaceRecongnizeController.h"
#import "ReadFiler.h"
#import "BaseNextButton.h"


@interface ThirdStepController ()

@end

@implementation ThirdStepController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDefaultContentText];
    [self addAutolayout];
}
- (void)setDefaultContentText{
    NSString *defaultText = [ReadFiler readTextFile:@"IDVerify" fileType:@"txt"];
    self.contentLabel.text = defaultText;
}
- (void)addAutolayout{
    
    {
        self.titleLabel.sd_layout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .topSpaceToView(self.view, 10)
        .autoHeightRatio(0);
    }
    {
        self.contentLabel.sd_layout
        .leftSpaceToView(self.view, 30)
        .rightSpaceToView(self.view,30)
        .topSpaceToView(self.titleLabel, 10)
        .autoHeightRatio(0);
    }
    {
        self.nextButton.sd_layout
        .leftSpaceToView(self.view,30)
        .rightSpaceToView(self.view,30)
        .heightIs(30)
        .topSpaceToView(self.contentLabel, 20);
        
        
        self.nextButton.backgroundColor = REDCOLOR;
    }
}
- (IBAction)nextAction:(UIButton *)sender {
    //人脸识别
    FaceRecongnizeController *face = [[FaceRecongnizeController alloc] initWithNibName:NSStringFromClass([FaceRecongnizeController class]) bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:face animated:YES];
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
