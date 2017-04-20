//
//  QYSMyHistoryViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/13/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSMyHistoryViewController.h"
#import "QYSItemCollectionViewCell.h"
#import "QYSItemDetailsViewController.h"

@interface QYSMyHistoryViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *btnCategory;
@property (nonatomic, strong) UIButton *btnClear;
@property (nonatomic, strong) UIButton *btnEdit;

@property (nonatomic, strong) UICollectionView *itemsCollectionView;

@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray *mySpoorList;

@end

@implementation QYSMyHistoryViewController

-(void)dealloc {
    _btnCategory = nil;
    _btnClear = nil;
    _btnEdit = nil;
    _itemsCollectionView = nil;
    _mySpoorList = nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.offset = 0;
        self.count = 1;
        self.title = @"最近浏览";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack title:@"返回" target:self action:@selector(btnBackClick)];
        self.mySpoorList = [NSMutableArray new];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [[MySpoorService sharedMySpoorService] findAllMySpootWithOffset:_offset count:_count complete:^(NSMutableArray *array) {
        if (nil == _mySpoorList) {
            self.mySpoorList = [NSMutableArray new];
        }
        
        if ([_mySpoorList count] > 0) {
            [_mySpoorList removeAllObjects];
        }
        
        self.mySpoorList = [array mutableCopy];
        [self.itemsCollectionView reloadData];
        
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.itemsCollectionView.emptyState_view = tableViewEmpty(_itemsCollectionView.frame);
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
    
    self.itemsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 46, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:flow_layout];
    _itemsCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _itemsCollectionView.backgroundColor = COLOR_MAIN_BG_GRAY;
    [_itemsCollectionView registerClass:[QYSItemCollectionViewCell class] forCellWithReuseIdentifier:@"items-cell"];
    _itemsCollectionView.delegate = self;
    _itemsCollectionView.dataSource = self;
    [self.view addSubview:_itemsCollectionView];
    
    //
    UIView *top_bar = [[UIView alloc] init];
    top_bar.translatesAutoresizingMaskIntoConstraints = NO;
    top_bar.backgroundColor = COLOR_SPLITE_BG_GRAY;
    top_bar.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
    top_bar.layer.borderWidth = 2.0;
    [self.view addSubview:top_bar];
    
    self.btnCategory = [[UIButton alloc] init];
    _btnCategory.translatesAutoresizingMaskIntoConstraints  = NO;
    _btnCategory.titleLabel.font = FONT_WITH_SIZE(16.0);
    _btnCategory.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btnCategory setTitle:@"全部分类" forState:UIControlStateNormal];
    [_btnCategory setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
    [top_bar addSubview:_btnCategory];
    
    self.btnClear = [[UIButton alloc] init];
    _btnClear.translatesAutoresizingMaskIntoConstraints  = NO;
    _btnClear.titleLabel.font = FONT_WITH_SIZE(16.0);
    [_btnClear setTitle:@"" forState:UIControlStateNormal];
    [_btnClear setTitleColor:COLOR_TEXT_ORANGE forState:UIControlStateNormal];
    [top_bar addSubview:_btnClear];
    
    self.btnEdit = [[UIButton alloc] init];
    _btnEdit.translatesAutoresizingMaskIntoConstraints  = NO;
    _btnEdit.titleLabel.font = FONT_WITH_SIZE(16.0);
    [_btnEdit setTitle:@"清空" forState:UIControlStateNormal];
    [_btnEdit setTitleColor:COLOR_TEXT_ORANGE forState:UIControlStateNormal];
    [self.btnEdit addTarget:self action:@selector(clearBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [top_bar  addSubview:_btnEdit];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(top_bar, _btnCategory, _btnEdit, _btnClear, _itemsCollectionView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-2)-[top_bar]-(-2)-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-2)-[top_bar(60)][_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_btnCategory(300)]" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_btnClear(>=70)]-[_btnEdit(70)]-|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_btnCategory]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_btnClear]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_btnEdit]|" options:0 metrics:nil views:vds]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

-(void)clearBtnClicked:(id)sender {
    
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要清除全部浏览记录吗" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确实", nil];
    [alerView show];
    
    [alerView bk_setWillDismissBlock:^(UIAlertView *alertView, NSInteger index) {
        switch (index) {
            case 1:
            {
                [[MySpoorService sharedMySpoorService] removeAllComplete:^{
                    [[MySpoorService sharedMySpoorService] findAllMySpootWithOffset:_offset count:_count complete:^(NSMutableArray *array) {
                        if (nil == _mySpoorList) {
                            self.mySpoorList = [NSMutableArray new];
                        }
                        
                        if ([_mySpoorList count] > 0) {
                            [_mySpoorList removeAllObjects];
                        }
                        
                        self.mySpoorList = [array mutableCopy];
                        [self.itemsCollectionView reloadData];
                        
                    }];
                }];
            }
                break;
                
            default:
                break;
        }
    }];
    
    
    
}

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnClearClick:(UIButton *)button
{
    
}

- (void)btnEditClick:(UIButton *)button
{
    
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_mySpoorList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYSItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"items-cell" forIndexPath:indexPath];
    cell.infoDict = nil;
    
    MySpoor *mySpoor = [_mySpoorList objectAtIndex:indexPath.row];
    Good *good = [Good new];
    good.thumb = mySpoor.imageUrl;
    good.product_name = mySpoor.goodName;
    good.product_id = mySpoor.goodId;
    good.price = mySpoor.price;
    good.old_price = mySpoor.oldPrice;
    cell.good = good;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *nc = [QYSItemDetailsViewController navController];
    
    QYSItemDetailsViewController *c = (QYSItemDetailsViewController *)(nc.topViewController);
    MySpoor *mySpoor = [_mySpoorList objectAtIndex:indexPath.row];
    c.productId = mySpoor.goodId;
    c.title = @"商品详情";
    c.backgroundImage = nil;
    [self presentViewController:nc animated:NO completion:^{
        [c showBackgroundLayerWithAnimate];
    }];
}

@end
