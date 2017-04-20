//
//  QYSMyAccSettingsViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/5.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyAccSettingsViewController.h"
#import "QYSMainViewController.h"
#import "QYSPopMenusViewController.h"
#import <BlocksKit/BlocksKit+UIKit.h>
#import "QYSUpdateNameViewController.h"
#import "AccountAvatarCell.h"

#pragma mark - QYSMyAccSettingCell

@interface QYSMyAccSettingCell : UITableViewCell

@end

@implementation QYSMyAccSettingCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect f = self.textLabel.frame;
    f.origin.x = 21.0;
    self.textLabel.frame = f;
}

@end

#pragma mark - QYSMyAccSettingsCell

@interface QYSMyAccSettingsBankCell : UITableViewCell

@property (nonatomic, assign) NSDictionary *infoDict;
@property (nonatomic, strong) UILabel *lb_content;
@property (nonatomic, strong) AccountInfo *accountBankInfo;

@end

@implementation QYSMyAccSettingsBankCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = COLOR_MAIN_CLEAR;
        self.separatorInset = UIEdgeInsetsZero;
        
        UIImageView *iv = [[UIImageView alloc] init];
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        iv.image = [UIImage imageNamed:@"macc-bg-01"];
        [self.contentView addSubview:iv];
        
        UILabel *lb_title = [[UILabel alloc] init];
        lb_title.translatesAutoresizingMaskIntoConstraints = NO;
        lb_title.font = FONT_WITH_SIZE(18.0);
        lb_title.textColor = COLOR_MAIN_WHITE;
        lb_title.text = @"收款银行账号:";
        [iv addSubview:lb_title];
        
        self.lb_content = [[UILabel alloc] init];
        self.lb_content.translatesAutoresizingMaskIntoConstraints = NO;
        self.lb_content.numberOfLines = 0;
        [iv addSubview:_lb_content];
        
        NSMutableParagraphStyle *p_style = [[NSMutableParagraphStyle alloc] init];
        p_style.minimumLineHeight = 25.0f;
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *shop_str = [[NSAttributedString alloc] initWithString:@"开户行:  招商银行\n开户人:  老李\n账 号:  9555512345678"
                                                                       attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x232736),
                                                                                    NSFontAttributeName:FONT_NORMAL,
                                                                                    NSParagraphStyleAttributeName:p_style}];
        [content_str appendAttributedString:shop_str];
        
        self.lb_content.attributedText = content_str;
        
        UIButton *btn_call = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_call.translatesAutoresizingMaskIntoConstraints = NO;
        [btn_call setImage:[UIImage imageNamed:@"item-icon-call"] forState:UIControlStateNormal];
        [btn_call iconTheme];
        btn_call.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn_call setTitle:@"如需修改账户信息，请联系客服" forState:UIControlStateNormal];
        [btn_call setTitleColor:COLOR_HEX2RGB(0x686868) forState:UIControlStateNormal];
        btn_call.titleLabel.font = FONT_WITH_SIZE(12.0);
        [iv addSubview:btn_call];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(iv, lb_title, _lb_content, btn_call);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[iv]-20-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:vds]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[iv]-12-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:vds]];
        
        [iv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_title]-20-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:vds]];
        
        [iv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_lb_content]-20-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:vds]];
        
        [iv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[btn_call]-20-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:vds]];
        
        [iv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[lb_title(40)]" options:0 metrics:nil views:vds]];
        
        [iv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-32-[_lb_content]-(0@999)-[btn_call(30)]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:vds]];
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    
}

-(void)setAccountBankInfo:(AccountInfo *)accountBankInfo {
    NSMutableParagraphStyle *p_style = [[NSMutableParagraphStyle alloc] init];
    p_style.minimumLineHeight = 30.0f;
    
    NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
    
    NSString *bankName = ([accountBankInfo.BankName isValid] && ![accountBankInfo.BankName isBlank]) ? accountBankInfo.BankName :@"";
    NSString *BankAccountHolder = ([accountBankInfo.BankAccountHolder isValid] && ![accountBankInfo.BankAccountHolder isBlank]) ? accountBankInfo.BankAccountHolder : @"";
    NSString *BankAccount = ([accountBankInfo.BankAccount isValid] && ![accountBankInfo.BankAccount isBlank]) ? accountBankInfo.BankAccount : @"";
    NSString *info = [NSString stringWithFormat:@"开户行: %@\n开户人: %@\n账 号: %@",bankName,BankAccountHolder,BankAccount];
    
    NSAttributedString *shop_str = [[NSAttributedString alloc] initWithString:info
                                                                   attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_BLACK,
                                                                                NSFontAttributeName:FONT_WITH_SIZE(15.0),
                                                                                NSParagraphStyleAttributeName:p_style}];
    [content_str appendAttributedString:shop_str];
    
    self.lb_content.attributedText = content_str;
}

@end

#pragma mark - QYSMyAccSettingsViewController

@interface QYSMyAccSettingsViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,QYSPopMenusViewControllerDelegate>

@property (nonatomic, strong) UIView *tableFooterView;
@property (nonatomic, strong) AccountInfo *accountInfo;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation QYSMyAccSettingsViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.title = @"账号设置";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack target:self action:@selector(btnBackClick)];
        /*
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemMore target:nil action:nil];
         */
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = COLOR_CELL_SEPARTATOR;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400, 44.0)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 0, v.bounds.size.width-40, v.bounds.size.height);
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[[UIImage imageNamed:@"btn-bg-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [v addSubview:btn];

    self.tableView.tableFooterView = v;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[AccountSettingService sharedAccountSettingService] getAccountInfo:^(AccountInfoResponse *response) {
        [self reloadDataWithResponse:response];
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
}


-(void)reloadDataWithResponse:(AccountInfoResponse *)response {
    self.accountInfo = response.data;
    [self.tableView reloadData];
    /*
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0]];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
     */
}

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (2 == indexPath.row)
    {
        return 196.0;
    }
    else if (0 == indexPath.row)
    {
        return 83.0;
    }
    
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (2 == indexPath.row)
    {
        QYSMyAccSettingsBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-acc-bank-cell"];
        if (!cell)
        {
            cell = [[QYSMyAccSettingsBankCell alloc] initWithReuseIdentifier:@"my-acc-bank-cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.accountBankInfo = _accountInfo;
        
        return cell;
    }
    
    QYSMyAccSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-acc-setting-cell"];
    if (!cell)
    {
        cell = [[QYSMyAccSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"my-acc-setting-cell"];
        cell.textLabel.textColor = COLOR_TEXT_BLACK;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-accssory01"]];
        cell.textLabel.font = FONT_NORMAL;
        cell.separatorInset = UIEdgeInsetsZero;
        if (IS_UP_THAN_IOS8) {cell.layoutMargins = UIEdgeInsetsZero;cell.preservesSuperviewLayoutMargins = NO;}
    }
    
    switch (indexPath.row)
    {
        case 0:
        {
            AccountAvatarCell *avatarCell = [[AccountAvatarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"avatar_cell"];
            avatarCell.avatarImageUrl = _accountInfo.HeadImg;
            return avatarCell;
        }
            break;
            
        case 1:
            cell.textLabel.text = @"昵称";

            break;
            
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGRect f = [cell convertRect:cell.bounds toView:self.view.superview.superview];
        
        UIPopoverController *pc = [QYSPopMenusViewController popverController:self menus:@[@"拍照",@"相册"]];
        [pc presentPopoverFromRect:f inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }else if (1 == indexPath.row) {
        QYSUpdateNameViewController *updateNameViewController = [[QYSUpdateNameViewController alloc] init];
        updateNameViewController.name = _accountInfo.NickName;
        [self.navigationController pushViewController:updateNameViewController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - QYSPopMenusViewControllerDelegate

- (void)popMenusViewController:(QYSPopMenusViewController *)controller didSelectRowAtIndex:(NSNumber *)index
{
    [controller.popverController dismissPopoverAnimated:NO];
    
    UIImagePickerController *c = [[UIImagePickerController alloc] init];
    c.allowsEditing = YES;
    c.delegate = self;
    
    if (0 == [index intValue])
    {
        c.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:c animated:YES completion:nil];
    }
    else
    {
        c.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CGRect f = [cell convertRect:cell.bounds toView:self.view.superview.superview];
        
        UIPopoverController *pc = [[UIPopoverController alloc] initWithContentViewController:c];
        pc.popoverContentSize = CGSizeMake(350, self.view.bounds.size.height);
        [pc presentPopoverFromRect:f inView:self.view.superview.superview permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
}

#pragma mark -

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //显示的文字
        self.HUD.labelText = @"";
        //细节文字
        self.HUD.detailsLabelText = @"正在修改头像...";
        //是否有庶罩
        self.HUD.dimBackground = NO;
        [self.HUD show:YES];
        UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage *aImage = [image compressedImage];
        
        [[AccountSettingService sharedAccountSettingService] updateAvatar:aImage complete:^{
            [self.HUD hide:YES];
            AccountAvatarCell *cell = (AccountAvatarCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.avatarImage = aImage;
        } error:^(NSString *error) {
            [self.HUD hide:YES];
            JDStatusBarNotificationError(error);
        }];
    }];
}

-(void)logout:(UIButton *)button {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要退出登录吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    [alertView bk_setDidDismissBlock:^(UIAlertView *alert , NSInteger index) {
        NSLog(@"%zd",index);
        switch (index) {
            case 0:
            {
                //取消
            }
                break;
            case 1:
            {
                self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                //显示的文字
                self.HUD.labelText = @"";
                //细节文字
                self.HUD.detailsLabelText = @"正在退出登录...";
                //是否有庶罩
                self.HUD.dimBackground = YES;
                [self.HUD show:YES];
                //确定退出
                [[LogoutService sharedLogoutService] logout:^{
                    [self.HUD hide:YES];
                    //退出登录成功
                    [QYSPopupView hideAll:^{
                        
                    }];
                    
                } error:^(NSString *error) {
                    [self.HUD hide:YES];
                    JDStatusBarNotificationError(error);
                }];
            }
                break;
                
            default:
                break;
        }
        
    }];
    
}

@end
