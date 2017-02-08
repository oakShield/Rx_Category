//
//  GYNewsDetailViewController.m
//  GYNews
//
//  Created by tarena on 16/3/1.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYNewsDetailViewController.h"
#import "GYNewsCellModel.h"
@interface GYNewsDetailViewController ()<UIWebViewDelegate>

@end

@implementation GYNewsDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView* webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    NSURL* url = [NSURL URLWithString:self.newsmodel.url];
    NSLog(@"%@",url);//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
NSMutableString *js = [NSMutableString string];
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML;"];
    NSLog(@"%@", html);
    [js appendString:@"var top = document.getElementsByClassName('topbar)"];
    [js appendString:@"top.parentNode.removeChild(top);"];
        [webView stringByEvaluatingJavaScriptFromString:js];

}

@end
