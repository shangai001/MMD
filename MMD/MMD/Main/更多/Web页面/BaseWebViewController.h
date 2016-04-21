//
//  BaseWebViewController.h
//  MMD
//
//  Created by pencho on 16/4/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>



@interface BaseWebViewController : BaseViewController

//webView背景颜色
@property (copy, nonatomic) NSString * _Nullable  identifier;
@property (strong, nonatomic,nullable)UIColor *webViewColor;
@property (copy, nonatomic,nullable)NSString *URLString;
@property (nonatomic, strong, nullable)WKWebView *webView;
/**
 *  用于更新URL地址
 *
 *  @param URL 
 */
- (void)requestUrl:( NSString * _Nullable )URL;

@end
