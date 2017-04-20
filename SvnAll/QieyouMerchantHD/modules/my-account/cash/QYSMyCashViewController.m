//
//  QYSMyCashViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/13/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSMyCashViewController.h"
#import "QYSMyCashWithdrawViewController.h"
#import "QYSMyCashLogsViewController.h"

@interface QYSMyCashViewController ()

@end

@implementation QYSMyCashViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithMenus:@[@"提现申请", @"提现记录"]];
    if (self)
    {
        self.title = @"提现申请";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack title:@"返回" target:self action:@selector(btnBackClick)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedMenuIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)didReceiveMemoryWarning
{
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
    if (0 == index)
    {
        QYSMyCashWithdrawViewController *c = [[QYSMyCashWithdrawViewController alloc] initWithNibName:nil bundle:nil];
        self.contentViewController = c;
    }
    else if (1 == index)
    {
        QYSMyCashLogsViewController *c = [[QYSMyCashLogsViewController alloc] initWithNibName:nil bundle:nil];
        self.contentViewController = c;
    }
}

@end
