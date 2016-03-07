//
//  RegisterViewController.h
//  MMD
//
//  Created by pencho on 16/2/29.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterItem;
@class RegisterContentView;


@interface RegisterViewController : UIViewController

@property (strong, nonatomic)RegisterContentView *contentView;
@property (strong, nonatomic)RegisterItem *registerItem;

@end
