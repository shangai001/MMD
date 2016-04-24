//
//  IDPhotoController.m
//  MMD
//
//  Created by pencho on 16/4/24.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "IDPhotoController.h"
#import "QueryIdModel.h"
#import "ColorHeader.h"
#import "IDPhotoItem.h"
#import <UIImageView+AFNetworking.h>
#import "AppUserInfoHelper.h"
#import "DistributeStauff.h"



@interface IDPhotoController ()

@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic)IDPhotoItem *item;
@property (weak, nonatomic) IBOutlet UIButton *recheckButton;

@end

@implementation IDPhotoController
- (IDPhotoItem *)item{
    if (!_item) {
        _item = [IDPhotoItem new];
    }
    return _item;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self queryUserInfo];
    [self configureButtons];
}
- (void)configureButtons{
    
    self.recheckButton.layer.cornerRadius = 10.0f;
    self.recheckButton.backgroundColor = REDCOLOR;
    self.recheckButton.hidden = YES;
}
- (void)queryUserInfo{
    
    [QueryIdModel queryIDPhoto:nil success:^(NSDictionary *resultDic) {
        if ([resultDic[@"code"] integerValue] == 0) {
            NSDictionary *data = resultDic[@"data"];
            self.item.cardFrontUrl = data[@"cardFrontUrl"];
            self.item.cardBackUrl = data[@"cardBackUrl"];
            self.item.cardHandUrl = data[@"cardHandUrl"];
            self.item.state = data[@"state"];
            [self setIDPhotoInfo];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)setIDPhotoInfo{
    
    NSURL *cardFrontUrl = [NSURL URLWithString:self.item.cardFrontUrl];
    [self.frontImageView setImageWithURL:cardFrontUrl];
    
    NSURL *cardBackUrl = [NSURL URLWithString:self.item.cardBackUrl];
    [self.backImageView setImageWithURL:cardBackUrl];
    
    NSURL *cardHandUrl = [NSURL URLWithString:self.item.cardHandUrl];
    [self.faceImageView setImageWithURL:cardHandUrl];
    
    if ([self.item.state isEqualToString:@"1"]) {
        self.resultLabel.text = @"已通过审核";
        self.recheckButton.hidden = YES;
    }else if([self.item.state isEqualToString:@"2"]){
        self.resultLabel.text = @"未通过审核";
        self.recheckButton.hidden = NO;
    }else{
        self.resultLabel.text = @"未审核";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reCheckoutAction:(id)sender {
    
    if ([self.item.state isEqualToString:@"2"]) {
        NSString *userId = [AppUserInfoHelper userInfo][@"userId"];
        NSString *phone = [AppUserInfoHelper userInfo][@"phone"];
        [DistributeStauff shouldReBlindUser:userId mobileId:phone];
    }
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
