//
//  SQShopSegmentViewController.m
//  QieYouShop
//
//  Created by 李赛强 on 15/3/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "SQShopSegmentViewController.h"
#import "QYSMyAccountViewController.h"
#import "QYSPostCodeViewController.h"
#import "QYSMyOrderDetailsViewController.h"

@interface SQShopSegmentViewController ()
@property (nonatomic, strong) UINavigationController *myAccountNavViewController;
@property (nonatomic, strong) QYSPostCodeViewController *quickCodeViewController;
@property (nonatomic, strong) UINavigationController *myOrderDetailsNavViewController;
@end

@implementation SQShopSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack target:self action:@selector(btnBackClick)];
    
    
    UIBarButtonItem *bar_btn;
    NSMutableArray *btns = [NSMutableArray array];
    UIBarButtonItem *flexible;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 39, 32);
    [btn setImage:[UIImage imageNamed:@"topbar-icon04"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"topbar-icon04-h"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(gotoMyAccount:) forControlEvents:UIControlEventTouchUpInside];
    
    bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btns addObject:bar_btn];
    
    flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexible.width = 20;
    [btns addObject:flexible];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 39, 32);
    [btn setImage:[UIImage imageNamed:@"topbar-icon05"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"topbar-icon05-h"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(quickVerfifyCode:) forControlEvents:UIControlEventTouchUpInside];
    
    bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btns addObject:bar_btn];
    
    flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexible.width = 20;
    [btns addObject:flexible];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 39, 32);
    [btn setImage:[UIImage imageNamed:@"topbar-icon07-h"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"topbar-icon07"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(myShop:) forControlEvents:UIControlEventTouchUpInside];
    bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btns addObject:bar_btn];
    
    flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexible.width = 20;
    [btns addObject:flexible];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 39, 32);
    [btn setImage:[UIImage imageNamed:@"topbar-icon06"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"topbar-icon06-h"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(groupPurchase:) forControlEvents:UIControlEventTouchUpInside];
    bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btns addObject:bar_btn];
    
    self.navigationItem.rightBarButtonItems = btns;
    
}

-(void)groupPurchase:(id )sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoMyAccount:(id)sender {
    self.myAccountNavViewController = [QYSMyAccountViewController navController:self];
    _myAccountNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
    
    QYSPopupView *pop_view = [[QYSPopupView alloc] init];
    pop_view.contentView = _myAccountNavViewController.view;
    [pop_view show];
}

-(void)quickVerfifyCode:(id )sender {
    self.quickCodeViewController = [[QYSPostCodeViewController alloc] init];
    
    QYSPopupView *pop_view = [[QYSPopupView alloc] init];
    pop_view.contentView = _quickCodeViewController.view;
    pop_view.contentAlign = QYSPopupViewContentAlignCenter;
    [pop_view show];
    
    [_quickCodeViewController setCloseBlock:^(QYSPostCodeViewController *controller) {
        [pop_view hide:YES complete:nil];
    }];
    
    __weak SQShopSegmentViewController *weakSelf = self;
    [_quickCodeViewController setSubmitBlock:^(QYSPostCodeViewController *controller, NSString *orderId) {
        [pop_view hide:YES complete:^{
            weakSelf.myOrderDetailsNavViewController = [QYSMyOrderDetailsViewController navControllerWithOrderId:orderId];
            weakSelf.myOrderDetailsNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
            
            QYSPopupView *pop_view = [[QYSPopupView alloc] init];
            pop_view.contentView = weakSelf.myOrderDetailsNavViewController.view;
            [pop_view show];
        }];
    }];
}

-(void)myShop:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
