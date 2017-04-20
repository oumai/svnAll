//
//  QYSMyFavoritesViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/12/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSMyFavoritesViewController.h"
#import "QYSMyFavShopViewController.h"
#import "QYSMyFavItemsViewController.h"

@interface QYSMyFavoritesViewController ()

@end

@implementation QYSMyFavoritesViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithMenus:@[@"收藏的店铺", @"收藏的商品"]];
    if (self)
    {
        self.title = @"我的收藏";
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
        QYSMyFavShopViewController *c = [[QYSMyFavShopViewController alloc] initWithNibName:nil bundle:nil];
        self.contentViewController = c;
    }
    else if (1 == index)
    {
        QYSMyFavItemsViewController *c = [[QYSMyFavItemsViewController alloc] initWithNibName:nil bundle:nil];
        self.contentViewController = c;
    }
}

@end
