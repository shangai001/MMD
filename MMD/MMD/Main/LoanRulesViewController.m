//
//  LoanRulesViewController.m
//  MMD
//
//  Created by pencho on 16/4/1.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "LoanRulesViewController.h"
#import <WebKit/WebKit.h>

@interface LoanRulesViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (strong, nonnull)WKWebView *webView;
@end

@implementation LoanRulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    NSString *url = [NSString stringWithFormat:@"%@/webview/applyNotice",kHostURL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:self.webView];
}
#pragma mark WKNavigationDelegate

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}


// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    if ([navigationResponse.response.URL.host.lowercaseString isEqualToString:kHostURL]) {
        decisionHandler(WKNavigationResponsePolicyAllow);
        return;
    }
    NSLog(@"跳转不成功");
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
