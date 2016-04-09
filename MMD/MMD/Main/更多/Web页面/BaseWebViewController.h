//
//  BaseWebViewController.h
//  MMD
//
//  Created by pencho on 16/4/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController

@property (copy, nonatomic)NSString *URLString;

- (void)requestUrl:(NSString *)URL;

@end
