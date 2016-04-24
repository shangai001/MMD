//
//  IDInfoController.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "IDInfoController.h"
#import "QueryIdModel.h"
#import "AppUserInfoHelper.h"
#import "ColorHeader.h"
#import "DistributeStauff.h"



@interface IDInfoController ()
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong,nonatomic)NSDictionary *infoDic;
@property (weak, nonatomic) IBOutlet UIButton *reCheckButotn;

@end

@implementation IDInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self queryStatus];
    [self configureButtons];
}
- (void)configureButtons{
    
    self.reCheckButotn.layer.cornerRadius = 10.0f;
    self.reCheckButotn.backgroundColor = REDCOLOR;
    self.reCheckButotn.hidden = YES;
}
- (void)queryStatus{
    
    [QueryIdModel queryUserCheckSuccess:^(NSDictionary *resultDic) {
        
        if ([resultDic[@"code"] integerValue] == 0) {
            NSDictionary *data = resultDic[@"data"];
            self.infoDic = data;
            [self setLabelText:self.infoDic];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)setLabelText:(NSDictionary *)dic{
    
    NSDictionary *userInfo = [AppUserInfoHelper userInfo];
    NSString *name = userInfo[@"name"];
    NSString *idNumber = userInfo[@"idcard"];
    self.nameLabel.text = name;
    self.idLabel.text = idNumber;
    
    NSString *status = dic[@"checkState"];
    if ([status isEqualToString:@"1"]) {
        self.statusLabel.text = @"未通过审核";
        self.reCheckButotn.hidden = NO;
    }else if ([status isEqualToString:@"2"]){
        self.statusLabel.text = @"已通过审核";
        self.reCheckButotn.hidden = YES;
    }else{
        self.statusLabel.text = @"未审核";
        self.reCheckButotn.hidden = YES;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reCheckAction:(id)sender {
    
    NSString *userId = [AppUserInfoHelper userInfo][@"userId"];
    NSString *phone = [AppUserInfoHelper userInfo][@"phone"];
    //真信认证
    [DistributeStauff shouldBlindUser:userId mobileId:phone];
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
