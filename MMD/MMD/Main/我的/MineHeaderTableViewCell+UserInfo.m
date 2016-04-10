//
//  MineHeaderTableViewCell+UserInfo.m
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "MineHeaderTableViewCell+UserInfo.h"
#import "AppUserInfoHelper.h"


@implementation MineHeaderTableViewCell (UserInfo)

- (void)setCurrentUserInfo{
    
    NSDictionary *userInfo = [AppUserInfoHelper getChildUserInfo:mmdUserInfo];
    NSDictionary *creditRating = [AppUserInfoHelper getChildUserInfo:mmdCreditRating];
    
    NSString *anotherName = userInfo[@"name"];
    NSString *anotherCreditLine = [creditRating[@"creditLine"] stringValue];
    NSString *anotherLevel = creditRating[@"name"];
    
    self.userNameLabel.text = anotherName;
    self.creditLineLabel.text = anotherCreditLine;
    self.creditLevelLabel.text = anotherLevel;    
    
}
@end
