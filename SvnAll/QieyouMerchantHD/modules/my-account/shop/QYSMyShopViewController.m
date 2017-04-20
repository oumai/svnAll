//
//  QYSMyShopViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/9/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSMyShopViewController.h"
#import "QYSItemCollectionViewCell.h"
#import "QYSSegments.h"
#import "QYSSegmentedControl.h"
#import "QYSItemDetailsViewController.h"
#import "QYSMyAccountViewController.h"
#import "QYSPostCodeViewController.h"
#import "QYSMyOrderDetailsViewController.h"
#import "HMSegmentedControl.h"

@interface QYSMyShopViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *itemsCollectionView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *goodList;
@property (nonatomic, strong) UINavigationController *myAccountNavViewController;
@property (nonatomic, strong) QYSPostCodeViewController *quickCodeViewController;
@property (nonatomic, strong) UINavigationController *myOrderDetailsNavViewController;
@property (nonatomic, strong) HMSegmentedControl *segments;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) CategoryTitle *categoryTitle;


@end

@implementation QYSMyShopViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.page = 1;
        self.pageSize = 20;
        self.categories = [NSMutableArray new];
        CategoryTitle *categoryTitle = [[CategoryTitle alloc] init];
        categoryTitle.id = @"";
        categoryTitle.name = @"全部分类";
        self.categoryTitle = categoryTitle;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack title:@"返回" target:self action:@selector(btnBackClick)];
        
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
        [btn setImage:[UIImage imageNamed:@"topbar-icon07"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"topbar-icon07-h"] forState:UIControlStateHighlighted];
        btn.highlighted = YES;
//        [btn addTarget:self action:@selector(btnQuickCodeClick:) forControlEvents:UIControlEventTouchUpInside];
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
    return self;
}

-(void)groupPurchase:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gotoMyAccount:(UIButton *)button {
    self.myAccountNavViewController = [QYSMyAccountViewController navController:self];
    _myAccountNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
    
    QYSPopupView *pop_view = [[QYSPopupView alloc] init];
    pop_view.contentView = _myAccountNavViewController.view;
    [pop_view show];
}

-(void)quickVerfifyCode:(UIButton *)button {
    self.quickCodeViewController = [[QYSPostCodeViewController alloc] init];
    
    QYSPopupView *pop_view = [[QYSPopupView alloc] init];
    pop_view.contentView = _quickCodeViewController.view;
    pop_view.contentAlign = QYSPopupViewContentAlignCenter;
    [pop_view show];
    
    [_quickCodeViewController setCloseBlock:^(QYSPostCodeViewController *controller) {
        [pop_view hide:YES complete:nil];
    }];
    
    __weak QYSMyShopViewController *weakSelf = self;
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

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.itemsCollectionView.emptyState_view = tableViewEmpty(_itemsCollectionView.frame);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    UIView *sg_bg = [[UIView alloc] init];
    sg_bg.translatesAutoresizingMaskIntoConstraints = NO;
    sg_bg.backgroundColor = COLOR_MAIN_WHITE;
    sg_bg.layer.borderColor = COLOR_HEX2RGB(0xbfbfbf).CGColor;
    sg_bg.layer.borderWidth = 0.5;
    [self.view addSubview:sg_bg];
    
    self.segments = [[HMSegmentedControl alloc] init];
    self.segments.translatesAutoresizingMaskIntoConstraints = NO;
    self.segments.backgroundColor = COLOR_MAIN_WHITE;
    self.segments.font = [UIFont systemFontOfSize:14.0f];
    self.segments.textColor = [UIColor colorForHexString:@"#686868"];
    self.segments.selectedTextColor  = [UIColor colorForHexString:@"#31b65d"];
    self.segments.selectionIndicatorColor = [UIColor colorForHexString:@"#31b65d"];
    self.segments.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    [sg_bg addSubview:_segments];
    
    
    __weak QYSMyShopViewController *weakSelf = self;
    
    [self.segments setIndexChangeBlock:^(NSInteger index) {
        weakSelf.page = 1;
        
        CategoryTitle *categoryTitle = weakSelf.categories[index];
        weakSelf.categoryTitle = categoryTitle;
        [[StoreGoodsService sharedStoreGoodsService] getStoreProductsWithId:weakSelf.storeId cid:categoryTitle.id ccid:@"" page:weakSelf.page pageSize:weakSelf.pageSize complete:^(GoodResponse *response) {
            [weakSelf reloadDataWithResponse:response];
        } error:^(NSString *error) {
            
        }];
    }];
    
    
    UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc] init];
    [flow_layout setItemSize:CGSizeMake(243, 248)];
    [flow_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flow_layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.itemsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow_layout];
    _itemsCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _itemsCollectionView.backgroundColor = COLOR_MAIN_BG_GRAY;
    [_itemsCollectionView registerClass:[QYSItemCollectionViewCell class] forCellWithReuseIdentifier:@"items-cell"];
    _itemsCollectionView.delegate = self;
    _itemsCollectionView.dataSource = self;
    [self.view addSubview:_itemsCollectionView];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(sg_bg, _segments, _itemsCollectionView);
    [sg_bg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_segments]-20-|" options:0 metrics:nil views:vds]];
    [sg_bg addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_segments]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[sg_bg]-(-1)-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[sg_bg(50)][_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    //获取商品类别列表
    CityService *cityService = [CityService sharedCityService];
    NSString *cityCode = cityService.currentCity.city;
     [[OptionsService sharedOptionsService] getOPtionsWithCityCode:cityCode complete:^(NSArray *categoryTitles, NSArray *categoryList, NSArray *localTitles, NSArray *localList) {
         self.categories = [categoryTitles mutableCopy];
         CategoryTitle *categoryTitle = [[CategoryTitle alloc] init];
         categoryTitle.id = @"";
         categoryTitle.name = @"全部分类";
         [self.categories insertObject:categoryTitle atIndex:0];
         
         NSMutableArray *sectionTitles = [NSMutableArray new];
         for (CategoryTitle *categoryTitle in _categories) {
             [sectionTitles addObject:categoryTitle.name];
         }
         
         self.segments.sectionTitles = sectionTitles;
         [self.segments setNeedsDisplay];
         
         
     } error:^(NSString *error) {
         
     }];
    
    //获取商品列表
    [[StoreGoodsService sharedStoreGoodsService] getStoreProductsWithId:_storeId cid:nil ccid:nil page:_page pageSize:_pageSize complete:^(GoodResponse *response) {
        [self reloadDataWithResponse:response];
    } error:^(NSString *error) {
        
    }];
    
    [self setupRefresh];
    [self setupFootRefresh];
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
        //获取商品列表
        [[StoreGoodsService sharedStoreGoodsService] getStoreProductsWithId:weakSelf.storeId cid:weakSelf.categoryTitle.id ccid:nil page:weakSelf.page pageSize:weakSelf.pageSize complete:^(GoodResponse *response) {
            [weakSelf reloadDataWithResponse:response];
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
        
        [[StoreGoodsService sharedStoreGoodsService] getStoreProductsWithId:vc.storeId cid:vc.categoryTitle.id ccid:nil page:vc.page pageSize:vc.pageSize complete:^(GoodResponse *response) {
            [vc reloadDataWithFootRefresh:response];
             [vc.itemsCollectionView footerEndRefreshing];
        } error:^(NSString *error) {
             [vc.itemsCollectionView footerEndRefreshing];
        }];
        
    }];
}

-(void)reloadDataWithFootRefresh:(GoodResponse *)response {
    [self.goodList addObjectsFromArray:response.data];
    [_itemsCollectionView reloadData];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(NSMutableArray *)groupPurchaseGoodsInit {
    
    if (nil != _goodList && [_goodList count] > 0) {
        [_goodList removeAllObjects];
        return _goodList;
    }
    
    return nil;
}

-(void) reloadDataWithResponse:(GoodResponse *)goodResponse {
    self.goodList = [self groupPurchaseGoodsInit];
    self.goodList = [NSMutableArray arrayWithArray:goodResponse.data];
    [_itemsCollectionView reloadData];
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

- (void)sgtShopClick:(QYSSegmentedControl *)segment
{
    self.page = 1;
    switch (segment.selectedSegmentIndex) {
        case 0:
        {
            self.segments.hidden = NO;
            [[StoreGoodsService sharedStoreGoodsService] getStoreGoodsWith:_storeId cate:nil cateDetail:nil page:_page pageSize:20 complete:^(GoodResponse *response) {
                [self reloadDataWithResponse:response];
            } error:^(NSString *error) {
                //JDStatusBarNotificationError(error);
            }];
        }
            break;
        case 1:
        {
            self.segments.hidden = YES;
            [[FavoriteService sharedFavoriteService] getFavoritesGoodWithPage:[NSString stringWithFormat:@"%zd",_page]
                                                                     pageSize:[NSString stringWithFormat:@"%zd",_pageSize]
                                                                         cate:nil
                                                                   cateDetail:nil
                                                                     complete:^(FavoriteGoodResponse *response) {
                                                                         [self reloadDataByResponse:response];
                                                                     } error:^(NSString *error) {
                                                                         //JDStatusBarNotificationError(error);
                                                                     }];
        }
            break;
            
        default:
            break;
    }
    NSLog(@"xxxxx %zd", segment.selectedSegmentIndex);
}

-(void) reloadDataByResponse:(FavoriteGoodResponse *)response {
    if (nil == _goodList) {
        self.goodList = [NSMutableArray new];
    }
    
    if ([_goodList count] > 0) {
        [_goodList removeAllObjects];
    }
    
    for (FavoriteGood *fGood in response.data) {
        Good *good = [Good new];
        good.product_id = fGood.product_id;
        good.product_name = fGood.product_name;
        good.thumb = fGood.thumb;
        good.price = fGood.price;
        good.old_price = fGood.agent;
        [self.goodList addObject:good];
    }
    
    
    [self.itemsCollectionView reloadData];
}


#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_goodList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYSItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"items-cell" forIndexPath:indexPath];
    cell.infoDict = nil;
    Good *good = [_goodList objectAtIndex:indexPath.row];
    cell.good = good;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *nc = [QYSItemDetailsViewController navController];
    
    QYSItemDetailsViewController *c = (QYSItemDetailsViewController *)(nc.topViewController);
    Good *good = [_goodList objectAtIndex:indexPath.row];
    c.good = good;
    c.productId = good.product_id;
    c.title = @"商品详情";
    c.backgroundImage = nil;
    [self presentViewController:nc animated:NO completion:^{
        [c showBackgroundLayerWithAnimate];
    }];
}

@end
