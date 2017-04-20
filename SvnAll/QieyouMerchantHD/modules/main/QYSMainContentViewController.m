//
//  QYSMainContentViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/1/28.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMainContentViewController.h"
#import "QYSItemCollectionViewCell.h"
#import "QYSItemDetailsViewController.h"

#import "QYSLoginViewController.h"
#import "QYSShoppingViewController.h"
#import "QYSMyShopViewController.h"
#import "QYSPostCodeViewController.h"
#import "QYSMyAccountViewController.h"

#import "QYSMainCategoryView.h"
#import "QYSPopMenusViewController.h"
#import "QYSPopLocationMenusViewController.h"
#import "SQImagePlayerView.h"
#import "QYSMyOrderDetailsViewController.h"
#import "SQShopSegmentViewController.h"
#import "QYSMyFavItemsViewController.h"
#import "SQPopover.h"
#import "CityTableViewCell.h"
#import "HotLocalView.h"

@interface QYSMainContentViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,VCTDragGestureDelegate,QYSMainCategoryViewDelegate,QYSPopMenusViewControllerDelegate,QYSPopLocationMenusViewControllerDelegate,SQImagePlayerViewDelegate,SQSegmentedViewControllerDataSource, SQSegmentedViewControllerDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UINavigationController *myAccountNavViewController;
@property (nonatomic, strong) QYSPostCodeViewController *quickCodeViewController;
@property (nonatomic, strong) UICollectionView *itemsCollectionView;

@property (nonatomic, strong) VCTDragGesture *menuDragGesture;
@property (nonatomic, strong) QYSMainCategoryView *categoryMenu;
@property (nonatomic, assign) CGRect categoryMenuFrame;

@property (nonatomic, assign) UIButton *btnMainCategory;
@property (nonatomic, assign) UIButton *btnLocation;
@property (nonatomic, assign) UIButton *btnReorder;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *groupPurcahses;

@property (nonatomic, strong) NSArray *imagePlayerImages;
@property (nonatomic, strong) UINavigationController *myOrderDetailsNavViewController;
@property (nonatomic, strong) NSMutableArray *sortTypes;



@property (nonatomic, strong) UIButton *leftBarButtonItem; //左上角的城市切换按钮
@property (nonatomic, strong) UIButton *btn_cate;     //分类筛选按钮
@property (nonatomic, strong) UIButton *tbtn1;        //全城选择按钮


@property (nonatomic, strong) SQPopover *popover;
@property (nonatomic, strong) SQPopover *localPopover;
@property (nonatomic, strong) UITableView *cityTableView;
@property (nonatomic, strong) NSMutableArray *cities;

@property (nonatomic, assign) kSortType kSortType;
@property (nonatomic, strong) City *currentCity;
@property (nonatomic, strong) CategoryTitle *categoryTitle;
@property (nonatomic, strong) CategoryList *categoryList;
@property (nonatomic, strong) LocalTitle *localTitle;
@property (nonatomic, strong) LocalList *localList;

@property (nonatomic, strong) NSArray *categoryTitles;
@property (nonatomic, strong) NSArray *categoryLists;
@property (nonatomic, strong) NSArray *localTitles;
@property (nonatomic, strong) NSArray *localLists;

@property (nonatomic, strong) HotLocalView *hotLocalView;




@end

@implementation QYSMainContentViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        {
            self.leftBarButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftBarButtonItem.frame = CGRectMake(0, 0, 200, 30);
            [self.leftBarButtonItem setImage:[UIImage imageNamed:@"btn-icon04"] forState:UIControlStateNormal];
            [self.leftBarButtonItem iconTheme];
            [self.leftBarButtonItem setTitle:@"丽江" forState:UIControlStateNormal];
            [self.leftBarButtonItem setTitleColor:COLOR_MAIN_WHITE forState:UIControlStateNormal];
            self.leftBarButtonItem.titleLabel.font = FONT_WITH_SIZE(14.0);
            [self.leftBarButtonItem addTarget:self action:@selector(leftBarButtonItemCliked:) forControlEvents:UIControlEventTouchUpInside];
            
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButtonItem];
            self.imagePlayerImages = @[@"grouppurchase_top_1",@"grouppurchase_top_2",@"grouppurchase_top_3"];
        }
        self.kSortType = kSortTypeTime;
        UIBarButtonItem *bar_btn;
        NSMutableArray *btns = [NSMutableArray array];
        UIBarButtonItem *flexible;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 39, 32);
        [btn setImage:[UIImage imageNamed:@"topbar-icon04"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"topbar-icon04-h"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnMyAccountClick:) forControlEvents:UIControlEventTouchUpInside];
        
        bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btns addObject:bar_btn];
        
        flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        flexible.width = 20;
        [btns addObject:flexible];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 39, 32);
        [btn setImage:[UIImage imageNamed:@"topbar-icon05"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"topbar-icon05-h"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnQuickCodeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btns addObject:bar_btn];
        
        flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        flexible.width = 20;
        [btns addObject:flexible];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 39, 32);
        [btn setImage:[UIImage imageNamed:@"topbar-icon07"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"topbar-icon07-h"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnMyShopClick:) forControlEvents:UIControlEventTouchUpInside];
        bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btns addObject:bar_btn];
        
        flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        flexible.width = 20;
        [btns addObject:flexible];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 39, 32);
        [btn setImage:[UIImage imageNamed:@"topbar-icon06-h"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"topbar-icon06-h"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnShoppingClick:) forControlEvents:UIControlEventTouchUpInside];
        bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btns addObject:bar_btn];
        
        self.navigationItem.rightBarButtonItems = btns;
        
        self.groupPurcahses = [NSMutableArray new];
        self.page = 1;
        self.pageSize = 20;
        
        //默认显示丽江
        City *lijiang = [[City alloc] init];
        lijiang.name = @"丽江";
        lijiang.city = @"530700";
        self.currentCity = lijiang;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"且游团购";
    [self setupTheme];
    
    UILabel *lb = (UILabel *)self.navigationItem.titleView;
    lb.font = FONT_WITH_SIZE(21);
    
    UIView *tool_bar = [[UIView alloc] init];
    tool_bar.translatesAutoresizingMaskIntoConstraints = NO;
    tool_bar.backgroundColor = COLOR_MAIN_BG_GRAY;
    [self.view addSubview:tool_bar];
    
    {
            //
        UIView *cate_v = [[UIView alloc] init];
        cate_v.translatesAutoresizingMaskIntoConstraints = NO;
        cate_v.backgroundColor = COLOR_MAIN_CLEAR;
        [tool_bar addSubview:cate_v];
        
        UIButton *btn_cate = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_cate.translatesAutoresizingMaskIntoConstraints = NO;
//        [btn_cate setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn_cate setImage:[UIImage imageNamed:@"main-icon04"] forState:UIControlStateNormal];
        [btn_cate iconTheme];
        [btn_cate setTitle:@"全部分类" forState:UIControlStateNormal];
        [btn_cate setTitleColor:COLOR_RGBA(0.45,0.45,0.45,1.0) forState:UIControlStateNormal];
        [btn_cate addTarget:self action:@selector(btnMainCategoryClick) forControlEvents:UIControlEventTouchUpInside];
        btn_cate.titleLabel.font = FONT_WITH_SIZE(18.0);
        btn_cate.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [cate_v addSubview:btn_cate];
        self.btnMainCategory = btn_cate;
        
            //
        UIView *btns_v = [[UIView alloc] init];
        btns_v.translatesAutoresizingMaskIntoConstraints = NO;
        [tool_bar addSubview:btns_v];
        
        self.tbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tbtn1.translatesAutoresizingMaskIntoConstraints = NO;
        [self.tbtn1 setImage:[UIImage imageNamed:@"btn-icon01"] forState:UIControlStateNormal];
        [self.tbtn1 iconTheme];
        [self.tbtn1 setTitle:@"全城" forState:UIControlStateNormal];
        [self.tbtn1 setTitleColor:COLOR_RGBA(0.45,0.45,0.45,1.0) forState:UIControlStateNormal];
        [self.tbtn1 addTarget:self action:@selector(btnLocationClick:) forControlEvents:UIControlEventTouchUpInside];
        self.tbtn1.titleLabel.font = FONT_WITH_SIZE(13.0);
        [btns_v addSubview:_tbtn1];
        self.btnLocation = _tbtn1;
        
        UIButton *tbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        tbtn2.translatesAutoresizingMaskIntoConstraints = NO;
        [tbtn2 setImage:[UIImage imageNamed:@"btn-icon02"] forState:UIControlStateNormal];
        [tbtn2 iconTheme];
        [tbtn2 setTitle:@"默认排序" forState:UIControlStateNormal];
        [tbtn2 setTitleColor:COLOR_RGBA(0.45,0.45,0.45,1.0) forState:UIControlStateNormal];
        [tbtn2 addTarget:self action:@selector(btnReorderClick:) forControlEvents:UIControlEventTouchUpInside];
        tbtn2.titleLabel.font = FONT_WITH_SIZE(13.0);
        [btns_v addSubview:tbtn2];
        self.btnReorder = tbtn2;
        
            //
        NSDictionary *dv = NSDictionaryOfVariableBindings(cate_v, btn_cate, btns_v, _tbtn1, tbtn2);
        [tool_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cate_v]|" options:0 metrics:nil views:dv]];
        [cate_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[btn_cate(>=150)]" options:0 metrics:nil views:dv]];
        [cate_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn_cate]|" options:0 metrics:nil views:dv]];
        
        
        [tool_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btns_v]|" options:0 metrics:nil views:dv]];
        
        [tool_bar addConstraint:[NSLayoutConstraint constraintWithItem:cate_v
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:tool_bar
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.0
                                                              constant:0.0]];
        
        [tool_bar addConstraint:[NSLayoutConstraint constraintWithItem:cate_v
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:tool_bar
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:0.5
                                                              constant:0.0]];
        
        [tool_bar addConstraint:[NSLayoutConstraint constraintWithItem:btns_v
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:tool_bar
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1.0
                                                              constant:0.0]];
        
        [tool_bar addConstraint:[NSLayoutConstraint constraintWithItem:btns_v
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:tool_bar
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:0.5
                                                              constant:0.0]];
        
        [btns_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tbtn1]|" options:0 metrics:nil views:dv]];
        [btns_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tbtn2]|" options:0 metrics:nil views:dv]];
        [btns_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_tbtn1(>=70)]-10-[tbtn2(>=100)]|" options:0 metrics:nil views:dv]];
    }
    
    SQImagePlayerView *adv_bar = [[SQImagePlayerView alloc] init];
    adv_bar.pageControlPosition = SQPageControlPosition_BottomRight;
//    adv_bar.hidePageControl = YES;
    adv_bar.translatesAutoresizingMaskIntoConstraints = NO;
    [adv_bar initWithCount:3 delegate:self];
    [self.view addSubview:adv_bar];
    
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
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(tool_bar,adv_bar,_itemsCollectionView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[tool_bar]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[adv_bar]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tool_bar(46)][adv_bar(111)][_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    
        //
    [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_POPUP_SHOW
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      self.menuDragGesture.enabled = NO;
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_POPUP_HIDE
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      self.menuDragGesture.enabled = YES;
                                                  }];
    
    
    [self setupRefresh];
    [self setupFootRefresh];
    
    {
        self.popover = [SQPopover popover];
        self.popover.alpha = 0.6f;
        self.popover.maskType = SQPopoverMaskTypeNone;
        self.localPopover = [SQPopover popover];
        self.localPopover.alpha = 1.0f;
        self.localPopover.maskType = SQPopoverMaskTypeNone;
    }
    
    [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:_page pageSize:_pageSize cityCode:_currentCity.city cid:@"" ccid:@"" dest:@"" local:@"" sortType:kSortTypeTime firstResponse:^{
        
    } complete:^(GoodResponse *goodResponse) {
       [self reloadWithResponse:goodResponse];
    } error:^(NSString *error) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.itemsCollectionView.emptyState_view = tableViewEmpty(_itemsCollectionView.frame);
    if (!_menuDragGesture)
    {
        self.menuDragGesture = [[VCTDragGesture alloc] init];
        _menuDragGesture.actDelegate = self;
        _menuDragGesture.useableArea = CGRectMake(0, 20, 254, 750);
        [self.view.superview.superview.superview addGestureRecognizer:_menuDragGesture];
        
        for (UIGestureRecognizer *ig in _itemsCollectionView.gestureRecognizers)
        {
            [ig requireGestureRecognizerToFail:_menuDragGesture];
        }
    }
    
    _menuDragGesture.enabled = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _menuDragGesture.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(void)reloadWithResponse:(GoodResponse *)response {
    if (nil == _groupPurcahses) {
        self.groupPurcahses = [NSMutableArray new];
    }
    
    if ([_groupPurcahses count] > 0) {
        [_groupPurcahses removeAllObjects];
    }
    
    self.groupPurcahses = [response.data mutableCopy];
    [self.itemsCollectionView reloadData];
}

-(void)reloadDataWithFootRefresh:(GoodResponse *)response {
    [self.groupPurcahses addObjectsFromArray:response.data];
    [_itemsCollectionView reloadData];
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
        
        if (weakSelf.kSortType == kSortTypeLocal) {
            
            Location *location = [Location sharedLocationManager];
            
            [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:weakSelf.page pageSize:weakSelf.pageSize cityCode:weakSelf.currentCity.city cid:weakSelf.categoryTitle.id ccid:weakSelf.categoryList.category_id dest:weakSelf.localTitle.dest_id local:weakSelf.localList.local_id sortType:weakSelf.kSortType lat:location.latitude lon:location.longitude firstResponse:^{
                
            } complete:^(GoodResponse *goodResponse) {
                [weakSelf reloadWithResponse:goodResponse];
                [weakSelf.itemsCollectionView.pullToRefreshView stopAnimating];
            } error:^(NSString *error) {
                [weakSelf.itemsCollectionView.pullToRefreshView stopAnimating];
            }];
            
        }else {
            [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:weakSelf.page pageSize:weakSelf.pageSize cityCode:weakSelf.currentCity.city cid:weakSelf.categoryTitle.id ccid:weakSelf.categoryList.category_id dest:weakSelf.localTitle.dest_id local:weakSelf.localList.local_id sortType:weakSelf.kSortType firstResponse:^{
                
            } complete:^(GoodResponse *goodResponse) {
                [weakSelf reloadWithResponse:goodResponse];
                [weakSelf.itemsCollectionView.pullToRefreshView stopAnimating];
            } error:^(NSString *error) {
                [weakSelf.itemsCollectionView.pullToRefreshView stopAnimating];
            }];
        }
        
    }];
    
    [self.itemsCollectionView.pullToRefreshView setProgressView:progressView1];
}


-(void)setupFootRefresh {
    __unsafe_unretained typeof(self) weakSelf = self;
    // 添加上拉刷新尾部控件
    [self.itemsCollectionView addFooterWithCallback:^{
        
        weakSelf.page += 1;
        if (weakSelf.kSortType == kSortTypeLocal) {
            
            Location *location = [Location sharedLocationManager];
            
            [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:weakSelf.page pageSize:weakSelf.pageSize cityCode:weakSelf.currentCity.city cid:weakSelf.categoryTitle.id ccid:weakSelf.categoryList.category_id dest:weakSelf.localTitle.dest_id local:weakSelf.localList.local_id sortType:weakSelf.kSortType lat:location.latitude lon:location.longitude firstResponse:^{
                
            } complete:^(GoodResponse *goodResponse) {
                [weakSelf reloadDataWithFootRefresh:goodResponse];
                [weakSelf.itemsCollectionView footerEndRefreshing];
            } error:^(NSString *error) {
                [weakSelf.itemsCollectionView footerEndRefreshing];
            }];
            
        }else {
            [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:weakSelf.page pageSize:weakSelf.pageSize cityCode:weakSelf.currentCity.city cid:weakSelf.categoryTitle.id ccid:weakSelf.categoryList.category_id dest:weakSelf.localTitle.dest_id local:weakSelf.localList.local_id sortType:weakSelf.kSortType firstResponse:^{
                
            } complete:^(GoodResponse *goodResponse) {
                [weakSelf reloadDataWithFootRefresh:goodResponse];
               [weakSelf.itemsCollectionView footerEndRefreshing];
            } error:^(NSString *error) {
               [weakSelf.itemsCollectionView footerEndRefreshing];
            }];
        }
        
    }];
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_groupPurcahses count];;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYSItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"items-cell" forIndexPath:indexPath];

    Good *good = [_groupPurcahses objectAtIndex:indexPath.row];
    cell.good = good;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *nc = [QYSItemDetailsViewController navController];
    
    QYSItemDetailsViewController *c = (QYSItemDetailsViewController *)(nc.topViewController);
    Good *good = [_groupPurcahses objectAtIndex:indexPath.row];
    c.good = good;
    c.productId = good.product_id;
    c.title = @"商品详情";
    c.backgroundImage = nil;
    [self.actViewController presentViewController:nc animated:NO completion:^{
        [c showBackgroundLayerWithAnimate];
    }];
}

#pragma mark - buttons event

- (void)bounceTargetView:(UIView *)targetView
{
    [UIView animateWithDuration:0.1 animations:^{
        targetView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            targetView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                targetView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}

-(void)leftBarButtonItemCliked:(UIButton *)sender {
     [[CityService sharedCityService] getCitys:^(CityResponse *cityResponse) {
         
         self.cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 40 * [cityResponse.data count])];
         self.cityTableView.backgroundColor = [UIColor blackColor];
         self.cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
         self.cityTableView.delegate = self;
         self.cityTableView.dataSource = self;
         [self.cityTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
         
         CGPoint startPoint = CGPointMake(CGRectGetMidX(sender.frame) - 68, CGRectGetMaxY(sender.frame) + 20);
         self.cities = [cityResponse.data mutableCopy];
         [self.popover showAtPoint:startPoint popoverPostion:SQPopoverPositionDown withContentView:_cityTableView inView:self.navigationController.view];
         __weak typeof(self)weakSelf = self;
         self.popover.didDismissHandler = ^{
             [weakSelf bounceTargetView:sender];
         };
     } error:^(NSString *error) {
         
     }];
}

-(void) validateLoginComplete:(void(^)())completeBlock errror:(void(^)(NSString *error))errorBlock{
    if (![LoginService isLogin]) {
        QYSLoginViewController *c = [[QYSLoginViewController alloc] initWithNibName:nil bundle:nil];
        c.view.frame = CGRectMake(0, 0, 434, 344);
        
        QYSPopupView *pop_view = [[QYSPopupView alloc] init];
        pop_view.contentViewController = c;
        pop_view.contentView = c.view;
        pop_view.contentAlign = QYSPopupViewContentAlignCenter;
        [pop_view show];
        
        [c setCloseBlock:^(QYSLoginViewController *controller) {
            [pop_view hide:YES complete:nil];
        }];
        
        [c setLoginCompleteBlock:^(QYSLoginViewController *controller, NSString *error) {
            [pop_view hide:YES complete:^{
                
                if ([error isValid] && ![error isBlank]) {
                    //说明此时登陆失败了
                    errorBlock(error);
                    return ;
                }
                completeBlock();
                
            }];
        }];
        
        [c setFindPasswordBlock:^(QYSLoginViewController *controller) {
            [pop_view hide:YES complete:nil];
        }];
        
        return;
    }
    
    completeBlock();
}

- (void)btnShoppingClick:(id)sender
{
    /*
    QYSShoppingViewController *c = [[QYSShoppingViewController alloc] initWithNibName:nil bundle:nil];
    [self.actViewController.navigationController pushViewController:c animated:YES];
     */
}

- (void)btnMyShopClick:(id)sender
{
    [self validateLoginComplete:^{
 
        SQShopSegmentViewController *myStoreViewController = [[SQShopSegmentViewController alloc] initWithControlPlacement:SQSegmentedViewControllerControlPlacementNavigationBar controlType:SQSegmentedViewControllerControlTypeSegmentedControl];
        myStoreViewController.swipeGestureEnabled = YES;
        myStoreViewController.dataSource = self;
        [self.actViewController.navigationController pushViewController:myStoreViewController animated:YES];
    } errror:^(NSString *error) {
        
    }];
   
}

#pragma mark - UITableViewDelegate DataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_cities count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier_city_cell = @"identifier_city_cell";
    CityTableViewCell *cityCell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier_city_cell];
    if (nil == cityCell) {
        cityCell = [[CityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_city_cell];
    }
    
    City *city = _cities[indexPath.row];
    cityCell.cityName = city.name;
    return cityCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    City *city = _cities[indexPath.row];
    
    self.currentCity = city;
    CityService *cityService = [CityService sharedCityService];
    cityService.currentCity = city;
    
    [self.popover dismiss];
    __weak typeof(self)weakSelf = self;
    self.popover.didDismissHandler = ^{
        [weakSelf bounceTargetView:weakSelf.leftBarButtonItem];
        [weakSelf.leftBarButtonItem setTitle:city.name forState:UIControlStateNormal];
        weakSelf.page = 1;
        [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:weakSelf.page pageSize:weakSelf.pageSize cityCode:city.city cid:@"" ccid:@"" dest:@"" local:@"" sortType:kSortTypeTime firstResponse:^{
            
        } complete:^(GoodResponse *goodResponse) {
            
            [weakSelf.btnMainCategory setTitle:@"全部分类" forState:UIControlStateNormal];
            [weakSelf.tbtn1 setTitle:@"全城" forState:UIControlStateNormal];
            [weakSelf.btnReorder setTitle:@"默认排序" forState:UIControlStateNormal];
            weakSelf.categoryTitle = nil;
            weakSelf.categoryList = nil;
            weakSelf.localTitle = nil;
            weakSelf.localList = nil;
            weakSelf.kSortType = kSortTypeTime;
            
            [weakSelf reloadWithResponse:goodResponse];
        } error:^(NSString *error) {
            
        }];
    };
}

#pragma mark - SQSegmentedViewControllerDataSource, Delegate

- (NSInteger)numberOfViewControllers
{
    return 2;
}

- (UIViewController *)SQSegmentedViewController:(SQSegmentedViewController *)segmentedViewController viewControllerAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            QYSMyShopViewController *storeGoodsViewController = [[QYSMyShopViewController alloc] init];
            return storeGoodsViewController;
        }
            break;
        case 1:
        {
            QYSMyFavItemsViewController *favoriteViewController = [[QYSMyFavItemsViewController alloc] init];
            return favoriteViewController;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (NSString *)SQSegmentedViewController:(SQSegmentedViewController *)segmentedViewController segmentedControlTitleForIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return @"铺子商品";
            break;
        case 1:
            return @"我的收藏";//@"铺子简介";
            break;
        default:
            return @"";
            break;
    }
}

- (void)btnQuickCodeClick:(id)sender
{
    
    [self validateLoginComplete:^{
        self.quickCodeViewController = [[QYSPostCodeViewController alloc] init];
        
        QYSPopupView *pop_view = [[QYSPopupView alloc] init];
        pop_view.contentView = _quickCodeViewController.view;
        pop_view.contentAlign = QYSPopupViewContentAlignCenter;
        [pop_view show];
        
        [_quickCodeViewController setCloseBlock:^(QYSPostCodeViewController *controller) {
            [pop_view hide:YES complete:nil];
        }];
        
        __weak QYSMainContentViewController *weakSelf = self;
        [_quickCodeViewController setSubmitBlock:^(QYSPostCodeViewController *controller, NSString *orderId) {
            [pop_view hide:YES complete:^{
                weakSelf.myOrderDetailsNavViewController = [QYSMyOrderDetailsViewController navControllerWithOrderId:orderId];
                weakSelf.myOrderDetailsNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
                
                QYSPopupView *pop_view = [[QYSPopupView alloc] init];
                pop_view.contentView = weakSelf.myOrderDetailsNavViewController.view;
                [pop_view show];
            }];
        }];
    } errror:^(NSString *error) {
        
    }];
}

- (void)btnMyAccountClick:(id)sender
{
    
    [self validateLoginComplete:^{
        self.myAccountNavViewController = [QYSMyAccountViewController navController:self];
        _myAccountNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
        
        QYSPopupView *pop_view = [[QYSPopupView alloc] init];
        pop_view.contentView = _myAccountNavViewController.view;
        [pop_view show];
        
    } errror:^(NSString *error) {
        
    }];
    
}

- (void)btnMainCategoryClick
{
    if (_categoryMenu != nil) {
        [_categoryMenu removeFromSuperview];
    }
    if (nil == _categoryMenu) {
         self.categoryMenu = [[QYSMainCategoryView alloc] initWithFrame:CGRectMake(-254, 0, 254, 770)];
    }
    
    _categoryMenuFrame = _categoryMenu.frame;
    _categoryMenu.actDelegate = self;
    _menuDragGesture.isOpened = NO;
    
    [self.view.superview.superview.superview addSubview:_categoryMenu];
    
    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _categoryMenu.frame = CGRectMake(0, 0, 254, 770);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             _menuDragGesture.isOpened = YES;
                         }
                     }];
    //获取网络请求列表
     [[OptionsService sharedOptionsService] getOPtionsWithCityCode:self.currentCity.city complete:^(NSArray *categoryTitles, NSArray *categoryList, NSArray *localTitles, NSArray *localList) {
         self.categoryTitles = categoryTitles;
        
         self.categoryMenu.menusArray =_categoryTitles;
         self.categoryLists = categoryList;
         
         NSMutableArray *cateList = [NSMutableArray new];
        
         for (CategoryTitle *categoryTitle in _categoryTitles) {
             NSPredicate* predicate = [NSPredicate predicateWithFormat:@"category==%@",categoryTitle.id];
             NSArray *subList = [_categoryLists filteredArrayUsingPredicate:predicate];
             [cateList addObject:subList];
         }
         
         self.categoryMenu.subMenusArray = cateList;
         

     } error:^(NSString *error) {
         
     }];
    
    return;
    
    
}

- (void)btnLocationClick:(UIButton *)sender
{
    
    [[OptionsService sharedOptionsService] getOPtionsWithCityCode:self.currentCity.city complete:^(NSArray *categoryTitles, NSArray *categoryList, NSArray *localTitles, NSArray *localList) {
        
        if (nil == localTitles || [localTitles count] == 0 || nil == localTitles || [localList count] == 0) {
            return ;
        }
        self.hotLocalView = [[HotLocalView alloc] initWithFrame:CGRectMake(0, 0, 400, 420)];
        self.hotLocalView.infoDict = @{kTitleKey:localTitles, kListKey:localList};
        CGPoint startPoint = CGPointMake(CGRectGetMidX(sender.frame) + 500, CGRectGetMaxY(sender.frame) + 50);
        [self.localPopover showAtPoint:startPoint popoverPostion:SQPopoverPositionDown withContentView:_hotLocalView inView:self.navigationController.view];
        __weak typeof(self)weakSelf = self;
        self.localPopover.didDismissHandler = ^{
            [weakSelf bounceTargetView:sender];
        };
        
        [self.hotLocalView setLocalSelectedBlock:^(LocalTitle *localTitle, LocalList *localList) {
            weakSelf.localTitle = localTitle;
            weakSelf.localList = localList;
            
            [weakSelf.localPopover dismiss];
            [weakSelf.tbtn1 setTitle:localList.local_name forState:UIControlStateNormal];
            weakSelf.page = 1;
            if (weakSelf.kSortType == kSortTypeLocal) {
                
              Location *location = [Location sharedLocationManager];
                
                [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:weakSelf.page pageSize:weakSelf.pageSize cityCode:weakSelf.currentCity.city cid:weakSelf.categoryTitle.id ccid:weakSelf.categoryList.category_id dest:localTitle.dest_id local:localList.local_id sortType:weakSelf.kSortType lat:location.latitude lon:location.longitude firstResponse:^{
                    
                } complete:^(GoodResponse *goodResponse) {
                    [weakSelf reloadWithResponse:goodResponse];
                } error:^(NSString *error) {
                    
                }];
            }else {
                [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:weakSelf.page pageSize:weakSelf.pageSize cityCode:weakSelf.currentCity.city cid:weakSelf.categoryTitle.id ccid:weakSelf.categoryList.category_id dest:localTitle.dest_id local:localList.local_id sortType:weakSelf.kSortType firstResponse:^{
                    
                } complete:^(GoodResponse *goodResponse) {
                    [weakSelf reloadWithResponse:goodResponse];
                } error:^(NSString *error) {
                    
                }];
            }
            
            weakSelf.localPopover.didDismissHandler = ^{
                [weakSelf bounceTargetView:sender];
            };
           
        }];
        
        
    } error:^(NSString *error) {
        
    }];
    
    
    
    /*
    CGRect f = [sender convertRect:sender.bounds toView:self.view];
    f.origin.y += 64.0;
    
    NSArray *data = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"main-locations-menu" ofType:@"plist"]];
    
    UIPopoverController *pc = [QYSPopLocationMenusViewController popverController:self data:data];
    [pc presentPopoverFromRect:f inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
     */
}

- (void)btnReorderClick:(UIButton *)sender
{
    CGRect f = [sender convertRect:sender.bounds toView:self.view];
    f.origin.y += 64.0;
    
    if (nil == _sortTypes) {
        self.sortTypes = [NSMutableArray new];
    }
    
    if ([_sortTypes count] > 0) {
        [_sortTypes removeAllObjects];
    }
    
    [_sortTypes addObject:@"默认排序"];
    if ([[Location sharedLocationManager] isFinished]) {
        [_sortTypes addObject:@"离我最近"];
    }
    [_sortTypes addObject:@"人气最旺"];
    [_sortTypes addObject:@"人均最低"];
    
    UIPopoverController *pc = [QYSPopMenusViewController popverController:self menus:_sortTypes];
    [(QYSPopMenusViewController *)(pc.contentViewController) setTag:102];
    [pc presentPopoverFromRect:f inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark - QYSMainCategoryViewDelegate

- (void)mainCategoryView:(QYSMainCategoryView *)mainCategoryView didSelectRowAtIndex:(NSNumber *)index
{
    [_btnMainCategory setTitle:mainCategoryView.menus[[index intValue]] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _categoryMenu.frame = CGRectMake(-254, 0, 254, 770);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             _menuDragGesture.isOpened = NO;
                             [_categoryMenu removeFromSuperview];
                             self.categoryMenu = nil;
                         }
                     }];
}

-(void)mainCategoryView:(QYSMainCategoryView *)mainCategoryView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CategoryList *categoryList = mainCategoryView.menus[indexPath.row];
    self.categoryList = categoryList;
    [_btnMainCategory setTitle:categoryList.name forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.page = 1;
                         _categoryMenu.frame = CGRectMake(-254, 0, 254, 770);
                         self.categoryTitles  = [_categoryTitles objectAtIndex:indexPath.section];
                         
                         if (_kSortType == kSortTypeLocal) {
                             Location *location = [Location sharedLocationManager];
                             [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:self.page pageSize:self.pageSize cityCode:self.currentCity.city cid:_categoryTitle.id ccid:categoryList.category_id dest:self.localTitle.dest_id local:self.localList.local_id sortType:_kSortType lat:location.latitude lon:location.longitude firstResponse:^{
                                 
                             } complete:^(GoodResponse *goodResponse) {
                                 [self reloadWithResponse:goodResponse];
                             } error:^(NSString *error) {
                                 
                             }];
                             
                         }else {
                             [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:_page pageSize:_pageSize cityCode:self.currentCity.city cid:_categoryTitle.id ccid:categoryList.category_id dest:self.localTitle.dest_id local:self.localList.local_id sortType:self.kSortType firstResponse:^{
                                 
                             } complete:^(GoodResponse *goodResponse) {
                                 [self reloadWithResponse:goodResponse];
                             } error:^(NSString *error) {
                                 
                             }];
                         }
                         
                        
                         
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             _menuDragGesture.isOpened = NO;
                             [_categoryMenu removeFromSuperview];
                             self.categoryMenu = nil;
                         }
                     }];
}

- (void)mainCategoryViewDidClose:(QYSMainCategoryView *)mainCategoryView
{
    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _categoryMenu.frame = CGRectMake(-254, 0, 254, 770);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             _menuDragGesture.isOpened = NO;
                             [_categoryMenu removeFromSuperview];
                             self.categoryMenu = nil;
                         }
                     }];
}

#pragma mark - QYSPopMenusViewControllerDelegate

- (void)popMenusViewController:(QYSPopMenusViewController *)controller didSelectRowAtIndex:(NSNumber *)index
{
    if (101 == controller.tag)
    {
        NSArray *m = @[@"画府",@"一线天",@"第五区",@"搏击世界",@"城下町",@"王之城"];
        
        [_btnLocation setTitle:m[[index intValue]] forState:UIControlStateNormal];
    }
    else if (102 == controller.tag)
    {
        
        NSString *sortType = _sortTypes[[index intValue] ];
        [_btnReorder setTitle:sortType forState:UIControlStateNormal];
        
        kSortType type = kSortTypeNone;
        if ([sortType isEqualToString:@"默认排序"]) {
            type = kSortTypeTime;
            self.kSortType = kSortTypeTime;
        }else if ([sortType isEqualToString:@"离我最近"]) {
            type = kSortTypeLocal;
            self.kSortType = kSortTypeLocal;
            Location *location = [Location sharedLocationManager];
            double lat = location.latitude;
            double lon = location.longitude;
            self.page = 1;
            [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:self.page pageSize:self.pageSize cityCode:self.currentCity.city cid:self.categoryTitle.id ccid:self.categoryList.category_id dest:@"" local:@"" sortType:kSortTypeLocal lat:lat lon:lon firstResponse:^{
                
            } complete:^(GoodResponse *goodResponse) {
                [self reloadWithResponse:goodResponse];
            } error:^(NSString *error) {
                
            }];
            [controller.popverController dismissPopoverAnimated:YES];
            return ;
            
        }else if ([sortType isEqualToString:@"人气最旺"]) {
            type = kSortTypeHighp;
            self.kSortType = kSortTypeHighp;
        }else if ([sortType isEqualToString:@"人均最低"]) {
            type = kSortTypeLowp;
            self.kSortType = kSortTypeLowp;
        }
        self.page = 1;
        [[GroupPurcahseService sharedGroupPurcahseService] getGroupPurchaseProductWithPage:self.page pageSize:self.pageSize cityCode:self.currentCity.city cid:self.categoryTitle.id  ccid:self.categoryList.category_id dest:@"" local:@"" sortType:type firstResponse:^{
            
        } complete:^(GoodResponse *goodResponse) {
            [self reloadWithResponse:goodResponse];
        } error:^(NSString *error) {
            
        }];
        
    }
    
    [controller.popverController dismissPopoverAnimated:YES];
}

#pragma mark - VCTDragGestureDelegate

- (void)dragGestureOpenBegan:(VCTDragGesture *)gesture
{
    self.categoryMenu = [[QYSMainCategoryView alloc] initWithFrame:CGRectMake(-254, 0, 254, 770)];
    _categoryMenuFrame = _categoryMenu.frame;
    _categoryMenu.actDelegate = self;
    [gesture.view addSubview:_categoryMenu];
}

- (void)dragGestureOpenMove:(VCTDragGesture *)gesture
{
    static CGRect cf;
    
    cf = _categoryMenuFrame;
    cf.origin.x = cf.origin.x + gesture.currPoint.x - gesture.startPoint.x;
    
    if (cf.origin.x >= 0)
    {
        cf.origin.x = 0;
        cf.size.width = gesture.currPoint.x - gesture.startPoint.x;
        
        if (cf.size.width >= 350.0)
        {
            return;
        }
    }
    
    _categoryMenu.frame = cf;
}

- (void)dragGestureOpenEnd:(VCTDragGesture *)gesture
{
    [UIView animateKeyframesWithDuration:0.6
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.2
                                                                animations:^{
                                                                    _categoryMenu.frame = CGRectMake(0, 0, 224, 770);
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.2
                                                          relativeDuration:0.2
                                                                animations:^{
                                                                    _categoryMenu.frame = CGRectMake(0, 0, 274, 770);
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.4
                                                          relativeDuration:0.2
                                                                animations:^{
                                                                    _categoryMenu.frame = CGRectMake(0, 0, 234, 770);
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.6
                                                          relativeDuration:0.2
                                                                animations:^{
                                                                    _categoryMenu.frame = CGRectMake(0, 0, 254, 770);
                                                                }];

                              }
                              completion:^(BOOL finished) {
                                  
                              }];
}

- (void)dragGestureCloseBegan:(VCTDragGesture *)gesture
{
    _categoryMenuFrame = _categoryMenu.frame;
    CGRect f = _categoryMenuFrame;
    
    CGFloat offset_w = gesture.startPoint.x - _categoryMenuFrame.origin.x;
    if (offset_w > 350.0)
    {
        offset_w = 350.0;
    }
    
    f.size.width = offset_w;
    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _categoryMenu.frame = f;
                     }
                     completion:nil];
    
    _categoryMenuFrame = f;
}

- (void)dragGestureCloseMove:(VCTDragGesture *)gesture
{
    static CGRect cf;
    
    cf = _categoryMenu.frame;
    cf.size.width = _categoryMenuFrame.size.width - (gesture.startPoint.x - gesture.currPoint.x);
    if (cf.size.width > 350.0)
    {
        cf.size.width = 350.0;
    }
    else if (cf.size.width <= 254.0)
    {
        cf.size.width = 254.0;
    }
    
    if (gesture.currPoint.x <= 280.0)
    {
        cf.origin.x = gesture.currPoint.x - 280;
    }
    
    _categoryMenu.frame = cf;
}

- (void)dragGestureCloseEnd:(VCTDragGesture *)gesture
{
    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _categoryMenu.frame = CGRectMake(-254, 0, 254, 770);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             [_categoryMenu removeFromSuperview];
                             self.categoryMenu = nil;
                         }
                     }];
}

#pragma mark - SQImagePlayerViewDelegate

- (NSInteger)numberOfItems {
    return [_imagePlayerImages count];
}

- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index {
    
    NSString *imageName = [_imagePlayerImages objectAtIndex:index];
    imageView.image = [UIImage imageNamed:imageName];
}

- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index {
    
    
}

@end
