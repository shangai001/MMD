//
//  LoggoutTableViewCell.h
//  MMD
//
//  Created by pencho on 16/4/11.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseNextButton;

typedef void(^LogoutAction)();


@interface LoggoutTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet BaseNextButton *logoutButton;
@property (copy, nonatomic) LogoutAction logouHandler;

@end
