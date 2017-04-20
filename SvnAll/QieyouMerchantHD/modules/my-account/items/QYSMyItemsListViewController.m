//
//  QYSMyItemsListViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/17.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyItemsListViewController.h"
#import "QYSItemCollectionViewCell.h"
#import "QYSMyItemCollectionViewCell.h"
#import "QYSSegments.h"
#import "QYSMyItemEditViewController.h"
#import "QYSPopMenusViewController.h"
#import "QYSItemDetailsViewController.h"
#import "ProductAddViewController.h"

@interface QYSMyItemsListViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,QYSMyItemCollectionViewCellDelegate,QYSPopMenusViewControllerDelegate>

@property (nonatomic, strong) UIButton *btnCategory;
@property (nonatomic, strong) UIButton *btnEdit;

@property (nonatomic, strong) UICollectionView *itemsCollectionView;
@property (nonatomic, strong) UINavigationController *myItemEditNavViewController;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *productList;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, assign) BOOL addFlag;
@property (nonatomic, assign) kMyProductManagerQueryType kProductManagerQueryType;


@end

@implementation QYSMyItemsListViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.page = 1;
        self.pageSize = 15;
        self.productList = [NSMutableArray new];
        self.addFlag = YES;
        self.kProductManagerQueryType = kMyProductManagerQueryTypeSelling;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
        //
    UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc] init];
    [flow_layout setItemSize:CGSizeMake(243, 248)];
    [flow_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flow_layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.itemsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow_layout];
    _itemsCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _itemsCollectionView.backgroundColor = COLOR_MAIN_BG_GRAY;
    [_itemsCollectionView registerClass:[QYSMyItemCollectionViewCell class] forCellWithReuseIdentifier:@"items-cell"];
    [_itemsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"items-add-cell"];
    _itemsCollectionView.delegate = self;
    _itemsCollectionView.dataSource = self;
    [self.view addSubview:_itemsCollectionView];
    
        //
    QYSSegments *segments = [[QYSSegments alloc] init];
    segments.translatesAutoresizingMaskIntoConstraints = NO;
    segments.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
    segments.layer.borderWidth = 1.0;
    segments.tineColor = COLOR_TEXT_ORANGE;
    segments.backgroundColor = COLOR_HEX2RGB(0xf4f4f4);
    segments.segments = @[@"在售中", @"团购中", @"已下架"];
    
    [segments setSegmentClicked:^(NSInteger index) {
        self.page = 1;
        switch (index) {
            case 0:
            {
                self.addFlag = YES;
                self.kProductManagerQueryType = kMyProductManagerQueryTypeSelling;
            }
                break;
            case 1:
            {
                self.addFlag = NO;
                self.kProductManagerQueryType = kMyProductManagerQueryTypeGroupPurchasing;
            }
                break;
            case 2:
            {
                self.addFlag = NO;
                self.kProductManagerQueryType = kMyProductManagerQueryTypeSaleStop;
            }
                break;
        }
        
        
        [[ProductService sharedProductService] getMyManagerProductsWithPage:_page pageSize:_pageSize queryType:_kProductManagerQueryType complete:^(NSDictionary *dictResponse, MyManagerProductsResponse *response) {
            [self reloadDataWithRespose:response];
        } error:^(NSString *error) {
            
        }];
    }];
    
    [self.view addSubview:segments];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(segments, _itemsCollectionView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[segments]-(-1)-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[segments(60)][_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    
    [self setupRefresh];
    [self setupFootRefresh];
    
    [[ProductService sharedProductService] getMyManagerProductsWithPage:_page pageSize:_pageSize queryType:_kProductManagerQueryType complete:^(NSDictionary *dictResponse, MyManagerProductsResponse *response) {
        [self reloadDataWithRespose:response];
    } error:^(NSString *error) {
        
    }];
   
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
    
    
    [self.itemsCollectionView setPullToRefreshWithHeight:60.0f actionHandler:^(BMYPullToRefreshView *pullToRefreshView) {
        weakSelf.page = 1;

        [[ProductService sharedProductService] getMyManagerProductsWithPage:weakSelf.page pageSize:weakSelf.pageSize queryType:weakSelf.kProductManagerQueryType complete:^(NSDictionary *dictResponse, MyManagerProductsResponse *response) {
            [weakSelf reloadDataWithRespose:response];
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

        [[ProductService sharedProductService] getMyManagerProductsWithPage:vc.page pageSize:vc.pageSize queryType:vc.kProductManagerQueryType complete:^(NSDictionary *dictResponse, MyManagerProductsResponse *response) {
            [vc reloadDataWithFootRefresh:response];
            [vc.itemsCollectionView footerEndRefreshing];
        } error:^(NSString *error) {
            [vc.itemsCollectionView footerEndRefreshing];
        }];
        
    }];
}

-(void)reloadDataWithRespose:(MyManagerProductsResponse *)response {
    
//    self.itemsCollectionView.emptyState_view = tableViewEmpty(_itemsCollectionView.frame);
    if (nil == _productList) {
        self.productList = [NSMutableArray new];
    }
    
    if ([_productList count] > 0) {
        [_productList removeAllObjects];
    }
    
    self.productList = [response.data mutableCopy];
    
    [_itemsCollectionView reloadData];
}

-(void)reloadDataWithFootRefresh:(MyManagerProductsResponse *)response {
    [self.productList addObjectsFromArray:response.data];
    [_itemsCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_productList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    QYSMyItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"items-cell" forIndexPath:indexPath];
    cell.actDelegate = self;
    MyManagerProductItem *product = [_productList objectAtIndex:indexPath.row];
    cell.productItem = product;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (self.addFlag && 0 == indexPath.row) {
        self.myItemEditNavViewController = [ProductAddViewController navController];
        _myItemEditNavViewController.view.frame = CGRectMake(0, 0, 400, 770);
        [_myItemEditNavViewController.topViewController setTitle:@"新增商品"];
        [(ProductAddViewController *)(_myItemEditNavViewController.topViewController) setIsNew:YES];
        QYSPopupView *pop_view = [[QYSPopupView alloc] init];
        pop_view.contentView = _myItemEditNavViewController.view;
        [pop_view show];
        return;
    }
     */
   
     MyManagerProductItem *product = [_productList objectAtIndex:indexPath.row];
    UINavigationController *nc = [QYSItemDetailsViewController navController];
    
    QYSItemDetailsViewController *c = (QYSItemDetailsViewController *)(nc.topViewController);
    c.productId = product.product_id;
    c.title = @"商品详情";
    c.backgroundImage = nil;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nc animated:NO completion:^{
        [c showBackgroundLayerWithAnimate];
    }];   
}

#pragma mark -

- (void)myItemCollectionViewCellClickEditButton:(QYSMyItemCollectionViewCell *)cell button:(UIButton *)button
{
    _selectedIndex = [[_itemsCollectionView indexPathForCell:cell] row];
    
    CGRect f = [button convertRect:button.bounds toView:self.view.superview];
    
    UIPopoverController *pc = [QYSPopMenusViewController popverController:self menus:@[@"设置为团购",@"下架",@"删除"]];
    [pc presentPopoverFromRect:f inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

#pragma mark -

- (void)popMenusViewController:(QYSPopMenusViewController *)controller didSelectRowAtIndex:(NSNumber *)index
{
    switch ([index intValue])
    {
        case 0:
            //
            break;
            
        case 1:
            //
            break;
            
        case 2:
            //
            break;
    }
    
    [controller.popverController dismissPopoverAnimated:NO];
    _selectedIndex = -1;
}

@end
