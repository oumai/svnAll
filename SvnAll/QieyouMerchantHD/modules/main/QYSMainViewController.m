//
//  QYSMainViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/1/28.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMainViewController.h"
#import "QYSMainCategoryView.h"
#import "QYSMainContentViewController.h"

static QYSMainViewController *__instance;

@interface QYSMainViewController ()

@property (nonatomic, strong) QYSMainContentViewController *contentViewController;

@end

@implementation QYSMainViewController

+ (QYSMainViewController *)shareInstance
{
    return __instance;
}

+ (UINavigationController *)navController
{
    QYSMainViewController *c = [[QYSMainViewController alloc] initWithNibName:nil bundle:nil];
    __instance = c;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    
    return nc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    
    self.contentViewController = [[QYSMainContentViewController alloc] initWithNibName:nil bundle:nil];
    _contentViewController.actViewController = self;
    [self.navigationController pushViewController:_contentViewController animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
