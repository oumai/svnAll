//
//  QYSShopInfoViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/10.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSShopInfoViewController.h"

#pragma mark -

@interface QYSShopInfoCell : UITableViewCell

@property (nonatomic, strong) UIButton *btnFav;
@property (nonatomic, strong) UIButton *btnShare;

@end

@implementation QYSShopInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLOR_MAIN_WHITE;
        
        if ([self respondsToSelector:@selector(preservesSuperviewLayoutMargins)])
        {
            self.preservesSuperviewLayoutMargins = NO;
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)])
        {
            self.layoutMargins = UIEdgeInsetsZero;
        }
        
        self.separatorInset = UIEdgeInsetsZero;
        
        self.btnFav = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnFav.translatesAutoresizingMaskIntoConstraints = NO;
        [_btnFav setTitle:@"收藏" forState:UIControlStateNormal];
        [_btnFav setImage:[UIImage imageNamed:@"main-icon-fav02"] forState:UIControlStateNormal];
        [_btnFav setImage:[UIImage imageNamed:@"main-icon-fav02-h"] forState:UIControlStateHighlighted];
        [_btnFav iconTheme];
        [_btnFav setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
        _btnFav.titleLabel.font = FONT_NORMAL_13;
        [self.contentView addSubview:_btnFav];
        
        self.btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnShare.translatesAutoresizingMaskIntoConstraints = NO;
        [_btnShare setTitle:@"分享" forState:UIControlStateNormal];
        [_btnShare setImage:[UIImage imageNamed:@"main-icon-share02"] forState:UIControlStateNormal];
        [_btnShare iconTheme];
        [_btnShare setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
        _btnShare.titleLabel.font = FONT_NORMAL_13;
        [self.contentView addSubview:_btnShare];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_btnFav,_btnShare);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-118-[_btnFav(>=80)]-10-[_btnShare(>=80)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btnFav(21)]-10-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btnShare(21)]-10-|" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, 85, 85);
    self.imageView.center = CGPointMake(62.0, 61.0);
    
    CGRect f = self.textLabel.frame;
    f.origin.x = 118;
    f.size.height -= 35;
    self.textLabel.frame = f;
}

@end

#pragma mark -

@interface QYSShopInfoViewController ()

@end

@implementation QYSShopInfoViewController

+ (UINavigationController *)navController
{
    QYSShopInfoViewController *c = [[QYSShopInfoViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.title = @"铺子简介";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    if (IS_UP_THAN_IOS8) self.tableView.preservesSuperviewLayoutMargins = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = 0.0;
    
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            h = 122;
        }
        else
        {
            h = 60;
        }
    }
    else
    {
        NSString *txt = @"先关闭psx，用ps+的自动更新功能，选好当前时间段，关机。p3会自动启动开始更新，有些游戏的更新档可以出现在后台下载里，一般是5个左右(自己是这样)，出现在后台的就可以使用psx来本地加速跟离线加速了。当然我也碰到过怎么都不出现在后台更新的补丁，比如对我这里声与形就是这样，这个就感觉无解了。";
        
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.firstLineHeadIndent = 30.0;
        paragraph_style.lineSpacing = 7.0;
        
        CGRect f = [txt boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSParagraphStyleAttributeName:paragraph_style,NSFontAttributeName:FONT_NORMAL} context:nil];
        
        if (f.size.height < 60)
        {
            return 60;
        }
        
        return f.size.height + 10.0;
    }
    
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (1 == section)
    {
        return 60.0;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (1 == section)
    {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
        v.backgroundColor = COLOR_HEX2RGB(0xf0efed);
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableView.bounds.size.width-40, 60)];
        lb.text = @"店铺介绍";
        
        [v addSubview:lb];
        
        return v;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            QYSShopInfoCell *ce;
            
            ce = [tableView dequeueReusableCellWithIdentifier:@"shop-info-cell"];
            if (!ce)
            {
                ce = [[QYSShopInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shop-info-cell"];
            }
            
            ce.imageView.image = [UIImage imageNamed:@"tst-user-avatar"];
            ce.textLabel.numberOfLines = 0;
            
            NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
            paragraph_style.minimumLineHeight = 20.0f;
            paragraph_style.maximumLineHeight = 20.0f;
            
            NSMutableAttributedString *attr_title = [[NSMutableAttributedString alloc] initWithString:@"二十八号果子铺子\n"
                                                                                           attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_ORANGE,
                                                                                                        NSParagraphStyleAttributeName:paragraph_style}];
            
            NSAttributedString *phone_no = [[NSAttributedString alloc] initWithString:@"特色：没特色 完全没特色 真真正正的没特色"
                                                                           attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                                                                        NSParagraphStyleAttributeName:paragraph_style}];
            
            [attr_title appendAttributedString:phone_no];
            ce.textLabel.attributedText = attr_title;
            
            cell = ce;
            
            return cell;
        }
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"shop-info-text-cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shop-info-text-cell"];
            cell.textLabel.font = FONT_NORMAL;
            cell.textLabel.textColor = COLOR_TEXT_BLACK;
            cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (IS_UP_THAN_IOS8) cell.preservesSuperviewLayoutMargins = NO,cell.layoutMargins=UIEdgeInsetsZero;
        }
        
        if (1 == indexPath.row)
        {
            cell.imageView.image = [UIImage imageNamed:@"item-icon-call02"];
            cell.textLabel.text = @"18025367969/075512345678";
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"item-icon-location02"];
            cell.textLabel.text = @"丽江研发中心大楼99层";
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"shop-info-desc-cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shop-info-desc-cell"];
            cell.textLabel.font = FONT_NORMAL;
            cell.textLabel.textColor = COLOR_TEXT_GRAY;
            cell.textLabel.numberOfLines = 0;
            cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (IS_UP_THAN_IOS8) cell.preservesSuperviewLayoutMargins = NO,cell.layoutMargins=UIEdgeInsetsZero;
        }
        
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.firstLineHeadIndent = 30.0;
        paragraph_style.lineSpacing = 7.0;
        
        NSString *txt = @"先关闭psx，用ps+的自动更新功能，选好当前时间段，关机。p3会自动启动开始更新，有些游戏的更新档可以出现在后台下载里，一般是5个左右(自己是这样)，出现在后台的就可以使用psx来本地加速跟离线加速了。当然我也碰到过怎么都不出现在后台更新的补丁，比如对我这里声与形就是这样，这个就感觉无解了。";
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:txt
                                                                  attributes:@{NSFontAttributeName:FONT_NORMAL,
                                                                      NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                      NSParagraphStyleAttributeName:paragraph_style}];

        cell.textLabel.attributedText = str;
    }
    
    return cell;
}

@end
