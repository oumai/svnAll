//
//  QYSPayViewController.m
//  QieYouShop
//
//  Created by 李赛强 on 15/3/23.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSPayViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

static NSString *const kOperateUrl = @"objc://goto_orderDetail";

@interface QYSPayViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation QYSPayViewController

-(void) dealloc {
    _webView = nil;
    _webUrl = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack target:self action:@selector(btnBackClick)];

    [self.navigationController.navigationBar setTintColor:[UIColor colorForHexString:@"#33bc60"]];
    UILabel *titleLabel = [UILabel LabelWithFrame:CGRectMake(0, 0, 80, 40) text:@"支付" textColor:kColor(255, 255, 255, 1) font:16.0f textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = titleLabel;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 540, 576+44)];
    
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    self.webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSURL *url=[NSURL URLWithString:_webUrl];
    
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnBackClick {
    if (self.dismissBlock) {
        self.dismissBlock(self);
    }
}

-(void)finish {
    if (self.finishBlock) {
        self.finishBlock(self);
    }
}

#pragma mark - UIwebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.labelText = @"加载中...";
    [_HUD showAnimated:YES whileExecutingBlock:^{
        
    } completionBlock:^{
        
    }];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.HUD hide:YES];
    [_HUD removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.HUD hide:YES];
    [_HUD removeFromSuperview];
    //[JDStatusBarNotification showWithStatus:@"加载失败！" dismissAfter:1.5f styleName:JDStatusBarStyleError];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSString *urlString = [url absoluteString];
    NSLog(@"%@",urlString);
    if ([urlString isEqualToString:kOperateUrl]) {
        if (self.finishBlock) {
            self.finishBlock(self);
        }
        return NO;
    }
    return YES;
}

@end
