//
//  QYSMyTradeViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/16.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyTradeViewController.h"
#import "QYSMyTradeLogsViewController.h"

@interface QYSMyTradeViewController ()

@end

@implementation QYSMyTradeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithMenus:@[@"全部交易流水"]];
    if (self)
    {
        self.title = @"我的交易流水";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack title:@"返回" target:self action:@selector(btnBackClick)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.selectedMenuIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

- (void)onSelectedMenuAtIndex:(NSInteger)index
{
    QYSMyTradeLogsViewController *c = [[QYSMyTradeLogsViewController alloc] initWithNibName:nil bundle:nil];
    self.contentViewController = c;
}

@end
