//
//  QYSMyItemsViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/17.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyItemsViewController.h"
#import "QYSMyItemsListViewController.h"
#import "ProductAddViewController.h"

@interface QYSMyItemsViewController ()

@property (nonatomic, strong) UINavigationController *myItemEditNavViewController;

@end

@implementation QYSMyItemsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithMenus:@[@"全部商品"]];
    if (self)
    {
        self.title = @"商品分类列表";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack title:@"返回" target:self action:@selector(btnBackClick)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemAdd title:@"新增商品" target:self action:@selector(addProductClick)];
        
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

-(void)addProductClick {
    self.myItemEditNavViewController = [ProductAddViewController navController];
    _myItemEditNavViewController.view.frame = CGRectMake(0, 0, 400, 770);
    [_myItemEditNavViewController.topViewController setTitle:@"新增商品"];
    [(ProductAddViewController *)(_myItemEditNavViewController.topViewController) setIsNew:YES];
    QYSPopupView *pop_view = [[QYSPopupView alloc] init];
    pop_view.contentView = _myItemEditNavViewController.view;
    [pop_view show];
}

#pragma mark -

- (void)onSelectedMenuAtIndex:(NSInteger)index {

    QYSMyItemsListViewController *c = [[QYSMyItemsListViewController alloc] initWithNibName:nil bundle:nil];
    self.contentViewController = c;
}

@end
