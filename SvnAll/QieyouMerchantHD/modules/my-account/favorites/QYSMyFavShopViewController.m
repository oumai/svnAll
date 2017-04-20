//
//  QYSMyFavShopViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/12/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSMyFavShopViewController.h"

#pragma mark - QYSMyFavShopCell

@interface QYSMyFavShopCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *shopAddressLabel;
@property (nonatomic, strong) UIButton *distanceButton;

@property (nonatomic, strong) NSDictionary *infoDict;

@property (nonatomic, strong) FavoriteStore *store;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@implementation QYSMyFavShopCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if ([self respondsToSelector:@selector(preservesSuperviewLayoutMargins)])
        {
            self.preservesSuperviewLayoutMargins = NO;
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)])
        {
            self.layoutMargins = UIEdgeInsetsZero;
        }
        
        self.separatorInset = UIEdgeInsetsMake(0, 5, 0, 0);
        self.backgroundColor = COLOR_SPLITE_BG_GRAY;
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myfav-phone-accessory"]];
        
        self.avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.avatarImageView.layer.cornerRadius = 69.0f / 2;
        self.avatarImageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_avatarImageView];
        
        self.shopNameLabel = [[UILabel alloc] init];
        _shopNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _shopNameLabel.textColor = COLOR_TEXT_ORANGE;
        _shopNameLabel.font = FONT_WITH_SIZE(18);
        [self.contentView addSubview:_shopNameLabel];
        
        self.shopAddressLabel = [[UILabel alloc] init];
        _shopAddressLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _shopAddressLabel.textColor = COLOR_TEXT_GRAY;
        _shopAddressLabel.font = FONT_NORMAL;
        [self.contentView addSubview:_shopAddressLabel];
        
        self.distanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _distanceButton.translatesAutoresizingMaskIntoConstraints = NO;
        _distanceButton.userInteractionEnabled = NO;
        [_distanceButton setImage:[UIImage imageNamed:@"myfav-icon-location"] forState:UIControlStateNormal];
        [_distanceButton iconTheme];
        _distanceButton.titleLabel.font = FONT_WITH_SIZE(13);
        _distanceButton.titleEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 0);
        [_distanceButton setTitleColor:COLOR_TEXT_LIGHT_GRAY forState:UIControlStateNormal];
        _distanceButton.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_distanceButton];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_avatarImageView, _shopNameLabel, _shopAddressLabel, _distanceButton);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_avatarImageView(68)]-21-[_shopNameLabel(>=200)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_avatarImageView]-21-[_shopAddressLabel(>=200)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_avatarImageView]-21-[_distanceButton(>=200)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatarImageView(68)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_shopNameLabel(20)]-[_shopAddressLabel(20)]-[_distanceButton(20)]" options:0 metrics:nil views:vds]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_avatarImageView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:0.0]];
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    _avatarImageView.image = [UIImage imageNamed:@"tst-user-avatar"];
    _shopNameLabel.text = @"第二十八号铺子";
    _shopAddressLabel.text = @"丽江古城区科研大楼99层";
    [_distanceButton setTitle:@"2.8km" forState:UIControlStateNormal];
}

-(void) setStore:(FavoriteStore *)store {
    kSetIntenetImageWith(_avatarImageView, store.inn_head);
    self.shopNameLabel.text = store.inn_name;
    self.shopAddressLabel.text = store.inn_address;
    self.distanceButton.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect f = self.accessoryView.frame;
    f.origin.x = 711.0;
    self.accessoryView.frame = f;
}

@end

#pragma mark - QYSMyFavShopViewController

@interface QYSMyFavShopViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *btnCategory;
@property (nonatomic, strong) UIButton *btnEdit;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *favorities;

@end

@implementation QYSMyFavShopViewController

-(void) dealloc {
    _btnCategory = nil;
    _btnEdit = nil;
    
    _tableView = nil;
    _favorities = nil;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.page = 1;
        self.pageSize = 20;
        self.favorities = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *top_bar = [[UIView alloc] init];
    top_bar.translatesAutoresizingMaskIntoConstraints = NO;
    top_bar.backgroundColor = COLOR_HEX2RGB(0xf4f4f4);
    top_bar.layer.borderColor = COLOR_HEX2RGB(0xe2e2e2).CGColor;
    top_bar.layer.borderWidth = 0.5;
    [self.view addSubview:top_bar];
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.translatesAutoresizingMaskIntoConstraints = NO;
    title_label.text = @"收藏的店铺";
    title_label.font = FONT_WITH_SIZE(16.0);
    title_label.textColor = COLOR_HEX2RGB(0x686868);
    [top_bar addSubview:title_label];
    
    self.btnCategory = [[UIButton alloc] init];
    _btnCategory.translatesAutoresizingMaskIntoConstraints  = NO;
    _btnCategory.titleLabel.font = FONT_WITH_SIZE(16.0);
    [_btnCategory setTitle:@"" forState:UIControlStateNormal];
    [_btnCategory setTitleColor:COLOR_TEXT_ORANGE forState:UIControlStateNormal];
    //[_btnCategory addTarget:self action:@selector(btnCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
    [top_bar addSubview:_btnCategory];
    
    self.btnEdit = [[UIButton alloc] init];
    _btnEdit.translatesAutoresizingMaskIntoConstraints  = NO;
    _btnEdit.titleLabel.font = FONT_WITH_SIZE(16.0);
    [_btnEdit setTitle:@"" forState:UIControlStateNormal];
    [_btnEdit setTitleColor:COLOR_TEXT_ORANGE forState:UIControlStateNormal];
   // [_btnEdit addTarget:self action:@selector(btnEditClick:) forControlEvents:UIControlEventTouchUpInside];
    [top_bar  addSubview:_btnEdit];
    
    self.tableView = [[UITableView alloc] init];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.separatorColor = COLOR_HEX2RGB(0xe2e2e2);
    _tableView.backgroundColor = COLOR_SPLITE_BG_GRAY;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    NSDictionary *vds = NSDictionaryOfVariableBindings(top_bar, title_label, _btnEdit, _btnCategory, _tableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[top_bar]-(-1)-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_tableView]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[top_bar(61)][_tableView]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[title_label(300)]" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_btnCategory(>=70)]-[_btnEdit(70)]-|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title_label]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_btnCategory]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_btnEdit]|" options:0 metrics:nil views:vds]];
    
    self.tableView.sqEV_emptyView = tableViewEmpty(CGRectMake(520, 0, _tableView.bounds.size.width - 120, _tableView.bounds.size.height));
    
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
        [[FavoriteService sharedFavoriteService] getFavoritesStoresWithPage:[NSString stringWithFormat:@"%zd",weakSelf.page] pageSize:[NSString stringWithFormat:@"%zd",weakSelf.pageSize] cate:nil cateDetail:nil complete:^(FavoriteStoreResponse *response) {
            [weakSelf reloadDataByResponse:response];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        } error:^(NSString *error) {
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
    [self.tableView.pullToRefreshView setProgressView:progressView1];
}

-(void)setupFootRefresh {
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        
        vc.page += 1;
        
        [[FavoriteService sharedFavoriteService] getFavoritesStoresWithPage:[NSString stringWithFormat:@"%zd",vc.page] pageSize:[NSString stringWithFormat:@"%zd",vc.pageSize] cate:nil cateDetail:nil complete:^(FavoriteStoreResponse *response) {
            [vc reloadDataWithFootRefresh:response];
            [vc.tableView footerEndRefreshing];
        } error:^(NSString *error) {
            //        JDStatusBarNotificationError(error);
            [vc.tableView footerEndRefreshing];
        }];
        
        
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    setExtraCellLineHidden(_tableView);
    
    [[FavoriteService sharedFavoriteService] getFavoritesStoresWithPage:[NSString stringWithFormat:@"%zd",_page] pageSize:[NSString stringWithFormat:@"%zd",_pageSize] cate:nil cateDetail:nil complete:^(FavoriteStoreResponse *response) {
        [self reloadDataByResponse:response];
    } error:^(NSString *error) {
//        JDStatusBarNotificationError(error);
    }];
}

-(void)reloadDataByResponse:(FavoriteStoreResponse *)response {
    if (nil == _favorities) {
        self.favorities = [@[] mutableCopy];
    }
    if ([_favorities count] > 0) {
        [_favorities removeAllObjects];
    }
    
    self.favorities = [response.data mutableCopy];
    [self.tableView reloadData];
}

-(void)reloadDataWithFootRefresh:(FavoriteStoreResponse *)response {
    [self.favorities addObjectsFromArray:response.data];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_favorities count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSMyFavShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-fav-shop-cell"];
    
    if (!cell)
    {
        cell = [[QYSMyFavShopCell alloc] initWithReuseIdentifier:@"my-fav-shop-cell"];
    }
    
    FavoriteStore *store = [_favorities objectAtIndex:indexPath.row];
    cell.store = store;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


#pragma mark -

- (void)btnCategoryClick:(UIButton *)button
{
    
}

- (void)btnEditClick:(UIButton *)button
{
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

@end
