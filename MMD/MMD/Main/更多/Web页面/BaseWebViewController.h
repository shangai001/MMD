//
//  BaseWebViewController.h
//  MMD
//
//  Created by pencho on 16/4/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController

//webView背景颜色
@property (strong, nonatomic)UIColor *webViewColor;
@property (copy, nonatomic)NSString *URLString;

/**
 *  用于更新URL地址
 *
 *  @param URL 
 */
- (void)requestUrl:(NSString *)URL;

@end
