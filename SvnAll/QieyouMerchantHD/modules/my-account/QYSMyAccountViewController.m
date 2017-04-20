//
//  QYSMyAccountViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/3/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSMyAccountViewController.h"
#import "QYSMyAccOrdersCell.h"
#import "QYSMyAccToolsCell.h"

#import "QYSMyShopSettingsViewController.h"
#import "QYSMyOrdersViewController.h"
#import "QYSMyItemsViewController.h"
#import "QYSMyCashViewController.h"
#import "QYSMyTradeViewController.h"
#import "QYSMyHistoryViewController.h"
#import "QYSMyCustomersViewController.h"
#import "QYSMyAccSettingsViewController.h"
#import "QYSMyFavoritesViewController.h"

#import "QYSMainViewController.h"

#pragma mark -

@interface QYSMyAccUserInfoCell : UITableViewCell

@end

@implementation QYSMyAccUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, 60, 60);
    self.imageView.center = CGPointMake(52.0, 43.0);
    
    CGRect f = self.textLabel.frame;
    f.origin.x = 90.0;
    f.origin.y = -3.0;
    self.textLabel.frame = f;
    
    for (UIView *v in self.subviews)
    {
        if ([v isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")])
        {
            v.backgroundColor = COLOR_MAIN_CLEAR;
        }
    }
}

@end

#pragma mark - QYSMyAccountViewController

@interface QYSMyAccountViewController () <QYSMyAccToolsCellDelegate, QYSMyAccOrdersCellDelegate>

@property (nonatomic, strong) MyAccount *account;

@end

@implementation QYSMyAccountViewController

+ (UINavigationController *)navController:(id)delegate
{
    QYSMyAccountViewController *c = [[QYSMyAccountViewController alloc] initWithStyle:UITableViewStyleGrouped];
    c.actDelegate = delegate;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = @"我的账号";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorColor = COLOR_CELL_SEPARTATOR;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[MyAccountService sharedMyAccountService] getAccountInfoComplete:^(MyAccount *account) {
        self.account = account;
        NSArray *indexPaths = @[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:0 inSection:1]];
        [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (3 == section)
    {
        return 4;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section || 1 == section)
    {
        return 0.01;
    }
    
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        return 87.0;
    }
    else if (1 == indexPath.section)
    {
        return 150.0;
    }
    else if (2 == indexPath.section)
    {
        return 95.0;
    }
    
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (0 == indexPath.section)
    {
        QYSMyAccUserInfoCell *ce;
        
        ce = [tableView dequeueReusableCellWithIdentifier:@"my-user-cell"];
        if (!ce)
        {
            ce = [[QYSMyAccUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"my-user-cell"];
        }
        
        ce.backgroundColor = COLOR_MAIN_CLEAR;
        ce.imageView.layer.cornerRadius = 30.0f;
        ce.imageView.layer.masksToBounds = YES;
//        ce.imageView.image = [UIImage imageNamed:@"tst-user-avatar"];
        kSetIntenetImageWith(ce.imageView, _account.avatarUrl);
        ce.textLabel.numberOfLines = 0;
        
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.lineSpacing = 3.0f;
        
        NSString *accountName = ([_account.accountName isValid] && ![_account.accountName isBlank]) ? _account.accountName : @"";
        NSMutableAttributedString *attr_title = [[NSMutableAttributedString alloc] initWithString:[accountName addString:@"\n"]
                                                                                       attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_BLACK,
                                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                                                                                    NSParagraphStyleAttributeName:paragraph_style}];
        NSString *tel = ([_account.accountTel isValid] && ![_account.accountTel isBlank]) ? _account.accountTel : @"";
        NSAttributedString *phone_no = [[NSAttributedString alloc] initWithString:tel
                                                                       attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_BLACK,
                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:12.0f],
                                                                                    NSParagraphStyleAttributeName:paragraph_style}];
        
        [attr_title appendAttributedString:phone_no];
        ce.textLabel.attributedText = attr_title;
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-accssory01"]];
        ce.accessoryView = iv;
        
        cell = ce;
        
        return cell;
    }
    
    if (1 == indexPath.section)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"my-account-orders-cell"];
        if (!cell)
        {
            cell = [[QYSMyAccOrdersCell alloc] initWithReuseIdentifier:@"my-account-orders-cell"];
            ((QYSMyAccOrdersCell *)cell).actDelegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        QYSMyAccOrdersCell *aCell = (QYSMyAccOrdersCell *)cell;
        aCell.count01 = _account.allOrderNumber;
        aCell.count02 = _account.watingPayNumber;
        aCell.count03 = _account.watingConsumeNumber;
        aCell.count04 = _account.refundingNumber;
        
        return cell;
    }
    
    if (2 == indexPath.section)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"my-account-tools-cell"];
        if (!cell)
        {
            cell = [[QYSMyAccToolsCell alloc] initWithReuseIdentifier:@"my-account-tools-cell"];
            ((QYSMyAccToolsCell *)cell).actDelegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"my-account-cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"my-account-cell"];
        cell.textLabel.font = FONT_NORMAL;
        cell.textLabel.textColor = COLOR_TEXT_BLACK;
    }
    
    cell.imageView.image = nil;
    cell.accessoryView = nil;
    
    if (3 == indexPath.section)
    {
        cell.imageView.contentMode = UIViewContentModeCenter;
        
        switch (indexPath.row)
        {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"macc-cell-icon05"];
                cell.textLabel.text = @"我的收藏";
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"macc-cell-icon06"];
                cell.textLabel.text = @"最近浏览";
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"macc-cell-icon07"];
                cell.textLabel.text = @"客人资料";
                break;
            case 3:
                cell.imageView.image = [UIImage imageNamed:@"macc-cell-icon08"];
                cell.textLabel.text = @"账号设置";
                break;
        }
    }
    else if (4 == indexPath.section)
    {
        cell.imageView.image = [UIImage imageNamed:@"macc-cell-icon09"];
        cell.textLabel.text = @"呼叫客服";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        QYSMyAccSettingsViewController *c = [[QYSMyAccSettingsViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:c animated:YES];
    }
    else if (3 == indexPath.section)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                [QYSPopupView hideAll:^{
                    QYSMyFavoritesViewController *c = [[QYSMyFavoritesViewController alloc] initWithNibName:nil bundle:nil];
                    [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
                }];
            }
                break;
            case 1:
            {
                [QYSPopupView hideAll:^{
                    QYSMyHistoryViewController *c = [[QYSMyHistoryViewController alloc] initWithNibName:nil bundle:nil];
                    [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
                }];
            }
                break;
            case 2:
            {
                QYSMyCustomersViewController *c = [[QYSMyCustomersViewController alloc] init];
                [self.navigationController pushViewController:c animated:YES];
            }
                break;
            case 3:
            {
                QYSMyAccSettingsViewController *c = [[QYSMyAccSettingsViewController alloc] initWithStyle:UITableViewStylePlain];
                [self.navigationController pushViewController:c animated:YES];
            }
                break;
            
        }
    }else if (indexPath.section == 4) {
        NSString *info = [@"欢迎联系且游 \n 客服电话：" addString:kQieyouServiceTEL];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:info  delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alertView show];
        [alertView bk_setDidDismissBlock:^(UIAlertView *alertV, NSInteger index) {
            
        }];
    }
}

#pragma mark - QYSMyAccToolsCellDelegate

- (void)myAccountToolsCellDidSelect:(QYSMyAccToolsCell *)cell index:(NSNumber *)index
{
    switch ([index intValue])
    {
        case 0:
        {
            [QYSPopupView hideAll:^{
                QYSMyItemsViewController *c = [[QYSMyItemsViewController alloc] initWithNibName:nil bundle:nil];
                [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
            }];
        }
            break;
        case 1:
        {
            [QYSPopupView hideAll:^{
                QYSMyCashViewController *c = [[QYSMyCashViewController alloc] initWithNibName:nil bundle:nil];
                [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
            }];
        }
            break;
        case 2:
        {
            [QYSPopupView hideAll:^{
                QYSMyTradeViewController *c = [[QYSMyTradeViewController alloc] initWithNibName:nil bundle:nil];
                [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
            }];
        }
            break;
        case 3:
        {
            QYSMyShopSettingsViewController *c = [[QYSMyShopSettingsViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
    }
}

#pragma mark - QYSMyAccOrdersCellDelegate

- (void)myAccountOrdersCellDidSelectType:(QYSMyAccOrdersCell *)cell index:(NSNumber *)type
{
    switch ([type intValue])
    {
        case 0:
        {
            [QYSPopupView hideAll:^{
                QYSMyOrdersViewController *c = [[QYSMyOrdersViewController alloc] initWithNibName:nil bundle:nil];
                [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
                c.selectedIndex = 0;
            }];
        }
            break;
        case 1:
        {
            [QYSPopupView hideAll:^{
                QYSMyOrdersViewController *c = [[QYSMyOrdersViewController alloc] initWithNibName:nil bundle:nil];
                [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
                c.selectedIndex = 1;
            }];
        }
            break;
        case 2:
        {
            [QYSPopupView hideAll:^{
                QYSMyOrdersViewController *c = [[QYSMyOrdersViewController alloc] initWithNibName:nil bundle:nil];
                [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
                c.selectedIndex = 3;
            }];
        }
            break;
        case 3:
        {
            [QYSPopupView hideAll:^{
                QYSMyOrdersViewController *c = [[QYSMyOrdersViewController alloc] initWithNibName:nil bundle:nil];
                [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
                c.selectedIndex = 5;
            }];
        }
            break;
    }
}

@end
