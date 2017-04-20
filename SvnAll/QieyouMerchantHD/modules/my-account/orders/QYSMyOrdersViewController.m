//
//  QYSMyOrdersViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/13.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyOrdersViewController.h"
#import "QYSMyOrderListTableViewController.h"

@interface QYSMyOrdersViewController ()

@end

@implementation QYSMyOrdersViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithMenus:@[@"全部订单", @"未支付",@"已支付",@"待消费",@"已完成",@"待退款",@"已退款",@"已取消"]];
    if (self)
    {
        self.title = @"我的订单";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack title:@"返回" target:self action:@selector(btnBackClick)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.selectedMenuIndex = _selectedIndex;
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
    /*
      = 1,          //'O' => '全部订单'
     ,        //'A' => '未支付'
     ,    //'U' => '待消费'
     ,        //'R' => '待退款'
     ,         //'C' => '已退款'
     ,           //'P' => '已支付'
     ,         //'S' => '已完成'
     ,         //'N' => '已取消'
     kOrderStateOther
     */
    kOrderState state = kOrderStateOther;
    switch (index) {
        case 0:
        {
            state = kOrderStateAll;
        }
            break;
        case 1:
        {
            state = kOrderStateWatingPay;
        }
            break;
        case 2:
        {
            state = kOrderStateSettle;
        }
            break;
        case 3:
        {
            state = kOrderStateWatingConsume;
        }
            break;
        case 4:
        {
            state = kOrderStateConsumed;
        }
            break;
        case 5:
        {
            state = kOrderStateRefunding;
        }
            break;
        case 6:
        {
            state = kOrderStateRefunded;
        }
            break;
        case 7:
        {
            state = kOrderStateCanceled;
        }
            break;
            
        default:
            break;
    }
    QYSMyOrderListTableViewController *c = [[QYSMyOrderListTableViewController alloc] initWithNibName:nil bundle:nil];
    c.orderState = state;
    self.contentViewController = c;
}

@end
