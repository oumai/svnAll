//
//  QYSMyFavItemsViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/12.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyFavItemsViewController.h"
#import "QYSItemCollectionViewCell.h"
#import "QYSItemDetailsViewController.h"

@interface QYSMyFavItemsViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *btnCategory;
@property (nonatomic, strong) UIButton *btnEdit;

@property (nonatomic, strong) UICollectionView *itemsCollectionView;

@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) NSMutableDictionary *selectedArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *favoritiesList;

@end

@implementation QYSMyFavItemsViewController

-(void)dealloc {
    _btnCategory = nil;
    _btnEdit = nil;
    _itemsCollectionView = nil;
    _selectedArray = nil;
    _favoritiesList = nil;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.page = 1;
        self.pageSize = 18;
        self.favoritiesList = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.selectedArray = [NSMutableDictionary dictionary];
    
    UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc] init];
    [flow_layout setItemSize:CGSizeMake(243, 248)];
    [flow_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flow_layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.itemsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 46, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:flow_layout];
    _itemsCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _itemsCollectionView.backgroundColor = COLOR_HEX2RGB(0xe4e4e4);
    [_itemsCollectionView registerClass:[QYSItemCollectionViewCell class] forCellWithReuseIdentifier:@"items-cell"];
    _itemsCollectionView.delegate = self;
    _itemsCollectionView.dataSource = self;
    [self.view addSubview:_itemsCollectionView];
    
    UIView *top_bar = [[UIView alloc] init];
    top_bar.translatesAutoresizingMaskIntoConstraints = NO;
    top_bar.backgroundColor = COLOR_HEX2RGB(0xf4f4f4);
//    top_bar.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
//    top_bar.layer.borderWidth = 0.5;
    [self.view addSubview:top_bar];
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.translatesAutoresizingMaskIntoConstraints = NO;
    title_label.text = @"收藏的商品";
    title_label.font = FONT_WITH_SIZE(16.0);
    title_label.textColor = COLOR_HEX2RGB(0x686868);
    [top_bar addSubview:title_label];
    
    self.btnCategory = [[UIButton alloc] init];
    _btnCategory.translatesAutoresizingMaskIntoConstraints  = NO;
    _btnCategory.titleLabel.font = FONT_WITH_SIZE(16.0);
    [_btnCategory setTitle:@"" forState:UIControlStateNormal];
    [_btnCategory setTitleColor:COLOR_TEXT_ORANGE forState:UIControlStateNormal];
    [top_bar addSubview:_btnCategory];
    
    self.btnEdit = [[UIButton alloc] init];
    _btnEdit.translatesAutoresizingMaskIntoConstraints  = NO;
    _btnEdit.titleLabel.font = FONT_WITH_SIZE(16.0);
    [_btnEdit setTitle:@"" forState:UIControlStateNormal];
    [_btnEdit setTitleColor:COLOR_TEXT_ORANGE forState:UIControlStateNormal];
    //[_btnEdit addTarget:self action:@selector(btnEditClick:) forControlEvents:UIControlEventTouchUpInside];
    [top_bar  addSubview:_btnEdit];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(top_bar, title_label, _btnEdit, _btnCategory, _itemsCollectionView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[top_bar]-(-1)-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[top_bar(59)][_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[title_label(300)]" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_btnCategory(>=70)]-[_btnEdit(70)]-|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title_label]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_btnCategory]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_btnEdit]|" options:0 metrics:nil views:vds]];
    [self setupRefresh];
    [self setupFootRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupRefresh {
    UIImage *logoImage = [UIImage imageNamed:@"bicon"];
    UIImage *backCircleImage = [UIImage imageNamed:@"light_circle"];
    UIImage *frontCircleImage = [UIImage imageNamed:@"dark_circle"];
    
    BMYCircularProgressView *progressView1 = [[BMYCircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                                                       logo:logoImage
                                                                            backCircleImage:backCircleImage
                                                                           frontCircleImage:frontCircleImage];
    __weak typeof(self) weakSelf = self;
    
    [self.itemsCollectionView setPullToRefreshWithHeight:60.0f actionHandler:^(BMYPullToRefreshView *pullToRefreshView) {
        weakSelf.page = 1;
        [[FavoriteService sharedFavoriteService] getFavoritesGoodWithPage:[NSString stringWithFormat:@"%zd",weakSelf.page]
                                                                 pageSize:[NSString stringWithFormat:@"%zd",weakSelf.pageSize]
                                                                     cate:nil
                                                               cateDetail:nil
                                                                 complete:^(FavoriteGoodResponse *response) {
                                                                     [weakSelf reloadDataByResponse:response];
                                                                     [weakSelf.itemsCollectionView.pullToRefreshView stopAnimating];
                                                                 } error:^(NSString *error) {
                                                                     [weakSelf.itemsCollectionView.pullToRefreshView stopAnimating];
                                                                 }];
    }];
    
    [self.itemsCollectionView.pullToRefreshView setProgressView:progressView1];
}

-(void)setupFootRefresh {
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.itemsCollectionView addFooterWithCallback:^{
        
        vc.page += 1;
        
        [[FavoriteService sharedFavoriteService] getFavoritesGoodWithPage:[NSString stringWithFormat:@"%zd",vc.page]
                                                                 pageSize:[NSString stringWithFormat:@"%zd",vc.pageSize]
                                                                     cate:nil
                                                               cateDetail:nil
                                                                 complete:^(FavoriteGoodResponse *response) {
                                                                     [vc reloadDataWithFootRefresh:response];
                                                                     [vc.itemsCollectionView footerEndRefreshing];
                                                                 } error:^(NSString *error) {
                                                                     [vc.itemsCollectionView footerEndRefreshing];
                                                                     //JDStatusBarNotificationError(error);
                                                                 }];
        
        
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[FavoriteService sharedFavoriteService] getFavoritesGoodWithPage:[NSString stringWithFormat:@"%zd",_page]
                                                             pageSize:[NSString stringWithFormat:@"%zd",_pageSize]
                                                                 cate:nil
                                                           cateDetail:nil
                                                             complete:^(FavoriteGoodResponse *response) {
                                                                 [self reloadDataByResponse:response];
                                                             } error:^(NSString *error) {
                                                                 JDStatusBarNotificationError(error);
                                                             }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.itemsCollectionView.emptyState_view = tableViewEmpty(_itemsCollectionView.frame);
}

-(void) reloadDataByResponse:(FavoriteGoodResponse *)response {
    if (nil == _favoritiesList) {
        self.favoritiesList = [@[] mutableCopy];
    }
    
    if ([_favoritiesList count] > 0) {
        [_favoritiesList removeAllObjects];
    }
    
    self.favoritiesList = [response.data mutableCopy];
    [self.itemsCollectionView reloadData];
}

-(void)reloadDataWithFootRefresh:(FavoriteGoodResponse *)response {
    [self.favoritiesList addObjectsFromArray:response.data];
    [_itemsCollectionView reloadData];
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_favoritiesList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYSItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"items-cell" forIndexPath:indexPath];
    cell.infoDict = nil;
    
    if (_isEditing)
    {
        cell.isEditing = _isEditing;
        
        if ([_selectedArray objectForKey:[NSString stringWithFormat:@"%zd", indexPath.row]])
        {
            cell.isEditingSelected = YES;
        }
        else
        {
            cell.isEditingSelected = NO;
        }
        [cell setNeedsLayout];
    }
    else
    {
        cell.isEditingSelected = NO;
        cell.isEditing = NO;
        [cell setNeedsLayout];
    }
    
    FavoriteGood *fGood = [_favoritiesList objectAtIndex:indexPath.row];
    
    Good *good = [Good new];
    good.product_id = fGood.product_id;
    good.product_name = fGood.product_name;
    good.thumb = fGood.thumb;
    good.price = fGood.price;
    good.old_price = fGood.agent;
    
    cell.good = good;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEditing)
    {
        if ([_selectedArray objectForKey:[NSString stringWithFormat:@"%zd", indexPath.row]])
        {
            [_selectedArray removeObjectForKey:[NSString stringWithFormat:@"%zd", indexPath.row]];
        }
        else
        {
            [_selectedArray setObject:@"1" forKey:[NSString stringWithFormat:@"%zd", indexPath.row]];
        }
        
        [_itemsCollectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
    
    UINavigationController *nc = [QYSItemDetailsViewController navController];
    
    QYSItemDetailsViewController *c = (QYSItemDetailsViewController *)(nc.topViewController);
    Good *good = [_favoritiesList objectAtIndex:indexPath.row];
    c.good = good;
    c.productId = good.product_id;
    c.title = @"商品详情";
    c.backgroundImage = nil;
    [self presentViewController:nc animated:NO completion:^{
        [c showBackgroundLayerWithAnimate];
    }];
}

#pragma mark -

- (void)btnCategoryClick:(UIButton *)button
{
    
}

- (void)btnEditClick:(UIButton *)button
{
    [_selectedArray removeAllObjects];
    
    _isEditing = !_isEditing;
    [_itemsCollectionView reloadData];
}

@end
