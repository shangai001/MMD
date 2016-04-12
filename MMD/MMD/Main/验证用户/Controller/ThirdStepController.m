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
#import "DistributeStauff.h"
#import "AppUserInfoHelper.h"
#import <SVProgressHUD.h>


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
    NSString *userId = @"24";
    NSString *phone = [AppUserInfoHelper userInfo][@"phone"];
    
    [DistributeStauff shouldBlindUser:userId mobileId:phone with:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
        NSLog(@"code = %@ message = %@ memberDetail = %@",@(code),message,memberDetail);
        
        if (code == ZXResult_IDCARD_ALREADY_EXIST) {
            [SVProgressHUD showInfoWithStatus:@"身份证已经绑定!"];
        }
        if (code == ZXResult_INVALID_USERID) {
            [SVProgressHUD showInfoWithStatus:@"未识别帐号!"];
        }
        if (code == ZXResult_MOBILENO_ALREADY_EXIST) {
            [SVProgressHUD showInfoWithStatus:@"手机号已经注册!"];
            
            [DistributeStauff getMemberDetailByMobileNo:phone withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
                NSLog(@"获取详情code = %@ message = %@ memberDetail = %@",@(code),message,memberDetail);
            }];
        }
        if (code == ZXResult_USERID_ALREADY_EXIST || code == ZXResult_SUCCESSED) {
            
            [DistributeStauff idcardVerificationForUid:userId withCallback:^(ZXResultCode code, NSString *message, ZXMemberDetail *memberDetail) {
                 NSLog(@"获取详情code = %@ message = %@ memberDetail = %@",@(code),message,memberDetail);
            }];
        }
    }];
    
//    FaceRecongnizeController *face = [[FaceRecongnizeController alloc] initWithNibName:NSStringFromClass([FaceRecongnizeController class]) bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:face animated:YES];
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
