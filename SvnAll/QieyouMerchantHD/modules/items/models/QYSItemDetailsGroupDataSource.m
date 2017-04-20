//
//  QYSItemDetailsGroupDataSource.m
//  QieYouShop
//
//  Created by Vincent on 1/31/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSItemDetailsGroupDataSource.h"

#pragma mark -

@interface QYSGradientImageView : UIImageView

@end

@implementation QYSGradientImageView

- (void)setImage:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef color_ref = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[2] = {1.0, 0.0};
    CFMutableArrayRef colors_ref = CFArrayCreateMutable(NULL, 2, NULL);
    CFArrayInsertValueAtIndex(colors_ref, 0, COLOR_RGBA(0, 0, 0, 1.0).CGColor);
    CFArrayInsertValueAtIndex(colors_ref, 0, COLOR_RGBA(0, 0, 0, 0.0).CGColor);
    CGGradientRef gradient_ref = CGGradientCreateWithColors(color_ref, colors_ref, locations);
    
    [image drawAtPoint:CGPointMake(0, 0)];
    CGContextDrawLinearGradient(ctx, gradient_ref, CGPointMake(0, image.size.height), CGPointMake(0, image.size.height/2), kCGGradientDrawsBeforeStartLocation);
    
    CGGradientRelease(gradient_ref);
    CFRelease(colors_ref);
    CGColorSpaceRelease(color_ref);
    
    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [super setImage:im];
}

@end

#pragma mark - QYSItemDetailsGroupCell

@interface QYSItemDetailsGroupCell : UITableViewCell

@property (nonatomic, readonly) UIImageView *itemImageView;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *subTitleLabel;
@property (nonatomic, readonly) UILabel *oldPriceLabel;
@property (nonatomic, readonly) UILabel *priceLabel;
@property (nonatomic, readonly) CALayer *selectedHighLightMask;

@property (nonatomic, assign) NSDictionary *infoDict;
@property (nonatomic, strong) Good *good;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@implementation QYSItemDetailsGroupCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImage *im = [UIImage imageNamed:@"tst-item-grp-item"];
        
        _itemImageView = [[QYSGradientImageView alloc] init];
        _itemImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _itemImageView.layer.cornerRadius = 3.0;
        _itemImageView.layer.masksToBounds = YES;
        _itemImageView.image = im;
        [self.contentView addSubview:_itemImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.text = @"丽江玉龙雪山门票";
        _titleLabel.textColor = COLOR_MAIN_WHITE;
        _titleLabel.font = FONT_WITH_SIZE(19.0);
        [self.contentView addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subTitleLabel.text = @"门票1张＋索道车票1张";
        _subTitleLabel.textColor = COLOR_MAIN_WHITE;
        _subTitleLabel.font = FONT_WITH_SIZE(14.0);
        [self.contentView addSubview:_subTitleLabel];
        
        _oldPriceLabel = [[UILabel alloc] init];
        self.oldPriceLabel.font = FONT_WITH_SIZE(13.0f);
        _oldPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _oldPriceLabel.textAlignment = NSTextAlignmentRight;
        _oldPriceLabel.text = @"689元";
        _oldPriceLabel.textColor = COLOR_MAIN_WHITE;
        [self.contentView addSubview:_oldPriceLabel];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.text = @"230元";
        _priceLabel.textColor = COLOR_MAIN_WHITE;
        self.priceLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_priceLabel];
        
        NSDictionary *dvs = NSDictionaryOfVariableBindings(_itemImageView, _titleLabel, _subTitleLabel, _oldPriceLabel, _priceLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_itemImageView]-10-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_itemImageView]-5-|" options:0 metrics:nil views:dvs]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_titleLabel]-10-[_oldPriceLabel(90)]-23-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_subTitleLabel]-5-[_priceLabel(180)]-20-|" options:0 metrics:nil views:dvs]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel(<=60)]-[_subTitleLabel(20)]-15-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_oldPriceLabel(18)]-3-[_priceLabel(28)]-15-|" options:0 metrics:nil views:dvs]];
        
        _selectedHighLightMask = [CALayer layer];
        _selectedHighLightMask.backgroundColor = COLOR_RGBA(0, 0, 0, 0.6).CGColor;
        _selectedHighLightMask.cornerRadius = 3.0;
        _selectedHighLightMask.masksToBounds = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected)
    {
        _selectedHighLightMask.frame = _itemImageView.frame;
        [self.contentView.layer addSublayer:_selectedHighLightMask];
    }
    else
    {
        [_selectedHighLightMask removeFromSuperlayer];
    }
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    UIColor *price_color = COLOR_MAIN_WHITE;
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"688元" attributes:@{NSForegroundColorAttributeName:price_color,
                                                                                            NSFontAttributeName:FONT_WITH_SIZE(15.0),
                                                                                            NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                                            NSStrikethroughColorAttributeName:price_color}];
    
    _oldPriceLabel.attributedText = p;
    
    
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
    p = [[NSAttributedString alloc] initWithString:@"230" attributes:@{NSForegroundColorAttributeName:price_color,
                                                                       NSFontAttributeName:[UIFont systemFontOfSize:32.0]}];
    [price appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:price_color,
                                                                     NSFontAttributeName:FONT_WITH_SIZE(21.0),
                                                                     NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
    [price appendAttributedString:p];
    _priceLabel.attributedText = price;
}

-(void)setGood:(Good *)good {
    UIColor *price_color = COLOR_MAIN_WHITE;
    
    NSString *priceValue = [ValidateParam(good.old_price) addString:@"元"];
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:priceValue attributes:@{NSForegroundColorAttributeName:price_color,
                                                                                               NSFontAttributeName:FONT_WITH_SIZE(15.0),
                                                                                               NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                                               NSStrikethroughColorAttributeName:price_color}];
    
    _oldPriceLabel.attributedText = p;
    
    
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
    p = [[NSAttributedString alloc] initWithString:ValidateParam(good.price) attributes:@{NSForegroundColorAttributeName:price_color,
                                                                                              NSFontAttributeName:[UIFont systemFontOfSize:32.0]}];
    [price appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:price_color,
                                                                     NSFontAttributeName:FONT_WITH_SIZE(21.0),
                                                                     NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
    [price appendAttributedString:p];
    _priceLabel.attributedText = price;
    
    kSetIntenetImageWith(_itemImageView, good.thumb);
    self.titleLabel.text = good.product_name;
    self.subTitleLabel.text = good.content;
}

@end

@interface QYSItemDetailsGroupDataSource ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSise;
@property (nonatomic, strong) NSMutableArray *groupPurchases;

@end

@implementation QYSItemDetailsGroupDataSource

-(void)dealloc {
    _groupPurchases = nil;
}

-(void) setProductId:(NSString *)productId {
    self.page = 1;
    self.pageSise = 20;
    
    [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseGoodsWithPage:_page pageSize:_pageSise cate:nil cateDetail:nil cityStreet:nil hotTravl:nil sortType:kSortTypeTime firstResponse:^{
        
    } complete:^(GoodResponse *goodResponse) {
        [self reloadWithResponse:goodResponse];
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
}

-(void)reloadWithResponse:(GoodResponse *)response {
    if (nil == _groupPurchases) {
        self.groupPurchases = [NSMutableArray new];
    }
    
    if ([_groupPurchases count] > 0) {
        [_groupPurchases removeAllObjects];
    }
    
    self.groupPurchases = [response.data mutableCopy];
    [self.tableView reloadData];
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = COLOR_MAIN_CLEAR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = COLOR_MAIN_CLEAR;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.layer.cornerRadius = 3.0;
    _tableView.layer.masksToBounds = YES;
    
    //增加下拉刷新
    [self setupRefresh];
    [self setupFootRefresh];
}

-(void)setupRefresh {
    UIImage *logoImage = [UIImage imageNamed:@"bicon.png"];
    UIImage *backCircleImage = [UIImage imageNamed:@"light_circle.png"];
    UIImage *frontCircleImage = [UIImage imageNamed:@"dark_circle.png"];
    
    BMYCircularProgressView *progressView1 = [[BMYCircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                                                       logo:logoImage
                                                                            backCircleImage:backCircleImage
                                                                           frontCircleImage:frontCircleImage];
    __weak typeof(self) weakSelf = self;
    
    [self.tableView setPullToRefreshWithHeight:60.0f actionHandler:^(BMYPullToRefreshView *pullToRefreshView) {
        weakSelf.page = 1;
        [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseGoodsWithPage:weakSelf.page pageSize:weakSelf.pageSise cate:nil cateDetail:nil cityStreet:nil hotTravl:nil sortType:kSortTypeTime firstResponse:^{
            
        } complete:^(GoodResponse *goodResponse) {
            [weakSelf reloadWithResponse:goodResponse];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        } error:^(NSString *error) {
            JDStatusBarNotificationError(error);
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
    [self.tableView.pullToRefreshView setProgressView:progressView1];
}

-(void)setupFootRefresh {
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在玩命加载中...";
}

- (void)footerRereshing {
    self.page += 1;
    [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseGoodsWithPage:_page pageSize:_pageSise cate:nil cateDetail:nil cityStreet:nil hotTravl:nil sortType:kSortTypeTime firstResponse:^{
        
    } complete:^(GoodResponse *goodResponse) {
        [self reloadDataWithFootRefresh:goodResponse];
        [self.tableView footerEndRefreshing];
    } error:^(NSString *error) {
        //        JDStatusBarNotificationError(error);
        [self.tableView footerEndRefreshing];
    }];
}

-(void)reloadDataWithFootRefresh:(GoodResponse *)goodResponse {
    [self.groupPurchases addObjectsFromArray:goodResponse.data];
    [_tableView reloadData];
}

- (void)unsetupTableView
{
    _tableView = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_groupPurchases count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    v.backgroundColor = COLOR_MAIN_WHITE;
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    v.backgroundColor = COLOR_MAIN_WHITE;
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 156.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSItemDetailsGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item-grp-details-cell"];
    if (!cell)
    {
        cell = [[QYSItemDetailsGroupCell alloc] initWithReuseIdentifier:@"item-grp-details-cell"];
    }
    
    Good *good = [_groupPurchases objectAtIndex:indexPath.row];
    cell.good = good;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Good *good = [_groupPurchases objectAtIndex:indexPath.row];
    if (self.LeftListClickedBlock) {
        self.LeftListClickedBlock(good);
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

@end
