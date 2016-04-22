//
//  BaseWebViewController.m
//  MMD
//
//  Created by pencho on 16/4/2.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "BaseWebViewController.h"
#import <SVProgressHUD.h>
#import "ConstantNotiName.h"



@interface BaseWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler>

@end

@implementation BaseWebViewController

- (WKWebView *)webView{
    if (!_webView) {
        
        _webView = [self scriptWkWebView];
        if (_webView) return _webView;
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.navigationDelegate = self;
    }
    return _webView;
}
- (WKWebView *)scriptWkWebView{
    if (self.identifier) {
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        NSString *name = @"";
        if ([self.identifier isEqualToString:@"Bank"]) {
            name = UserDidRepayByBank;
        }else if ([self.identifier isEqualToString:@"AliPay"]){
            name = UserDidRepayByAliPay;
        }else if ([self.identifier isEqualToString:@"LoanDetailId"]){
            name = UserMoveToApplyProtrol;
        }
        [config.userContentController addScriptMessageHandler:self name:name];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _webView.navigationDelegate = self;
        return _webView;
    }
    return nil;
}
- (void)setWebViewColor:(UIColor *)webViewColor{
    _webViewColor = webViewColor;
    self.webView.backgroundColor = _webViewColor;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestUrl:self.URLString];
    [self.view addSubview:self.webView];
}
- (void)requestUrl:(NSString *)URL{
    if (URL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        [self.webView loadRequest:request];
    }
}
#pragma mark WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD show];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD popActivity];
    [SVProgressHUD showErrorWithStatus:@"网络错误"];
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark WKUIdeleagte
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return nil;
}
#pragma mark WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"m  name=%@--body= %@",message.name,message.body);
    [[NSNotificationCenter defaultCenter] postNotificationName:message.name object:nil];
}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
