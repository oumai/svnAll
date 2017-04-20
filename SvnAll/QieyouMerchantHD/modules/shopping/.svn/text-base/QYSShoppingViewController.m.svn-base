//
//  QYSShoppingViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/23.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSShoppingViewController.h"
#import "QYSItemCollectionViewCell.h"
#import "QYSItemDetailsViewController.h"
#import "QYSSegments.h"

#import "QYSShopInfoViewController.h"
#import "QYSMyAccountViewController.h"

@interface QYSShoppingViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UINavigationController *shopInfoNavViewController;
@property (nonatomic, strong) UICollectionView *itemsCollectionView;

@end

@implementation QYSShoppingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"第二十八号铺子";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack title:@"返回" target:self action:@selector(btnBackClick)];
        
        UIBarButtonItem *bar_btn;
        NSMutableArray *btns = [NSMutableArray array];
        UIBarButtonItem *flexible;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 39, 32);
        [btn setImage:[UIImage imageNamed:@"topbar-icon04"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"topbar-icon04-h"] forState:UIControlStateHighlighted];
        bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btn addTarget:self action:@selector(btnMyAccountClick:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:bar_btn];
        
        flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        flexible.width = 20;
        [btns addObject:flexible];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 39, 32);
        [btn setImage:[UIImage imageNamed:@"topbar-icon05"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"topbar-icon05-h"] forState:UIControlStateHighlighted];
        bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btns addObject:bar_btn];
        
        flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        flexible.width = 20;
        [btns addObject:flexible];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 39, 32);
        [btn setImage:[UIImage imageNamed:@"topbar-icon07"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"topbar-icon07-h"] forState:UIControlStateHighlighted];
        bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btns addObject:bar_btn];
        
        flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        flexible.width = 20;
        [btns addObject:flexible];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 39, 32);
        [btn setImage:[UIImage imageNamed:@"topbar-icon06"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"topbar-icon06-h"] forState:UIControlStateHighlighted];
        btn.highlighted = YES;
        bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btns addObject:bar_btn];
        
        self.navigationItem.rightBarButtonItems = btns;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    UILabel *lb = (UILabel *)self.navigationItem.titleView;
    lb.font = FONT_WITH_SIZE(21);
    
    UIView *line = [[UIView alloc] init];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.backgroundColor = COLOR_MAIN_WHITE;
    line.layer.borderColor = COLOR_HEX2RGB(0xbfbfbf).CGColor;
    line.layer.borderWidth = 0.5;
    [self.view addSubview:line];
    
    QYSSegments *segments = [[QYSSegments alloc] init];
    segments.translatesAutoresizingMaskIntoConstraints = NO;
    segments.backgroundColor = COLOR_MAIN_WHITE;
    segments.tineColor = COLOR_MAIN_GREEN;
    segments.segments = @[@"全部分类",@"餐饮小吃",@"酒店名宿",@"租车交通",@"休闲娱乐",@"周边路线",@"景点门票",@"户外保险",@"本地特色"];
    [line addSubview:segments];
    
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
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(line,segments, _itemsCollectionView);
    [line addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[segments]-20-|" options:0 metrics:nil views:vds]];
    [line addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[segments]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[line]-(-1)-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_itemsCollectionView]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[line(50)][_itemsCollectionView]|" options:0 metrics:nil views:vds]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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

- (void)btnMyAccountClick:(id)sender
{
    self.shopInfoNavViewController = [QYSShopInfoViewController navController];
    _shopInfoNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
    
    QYSPopupView *pop_view = [[QYSPopupView alloc] init];
    pop_view.contentView = _shopInfoNavViewController.view;
    [pop_view show];
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYSItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"items-cell" forIndexPath:indexPath];
    cell.infoDict = nil;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIGraphicsBeginImageContextWithOptions([QYSConfigs screenSize], YES, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.navigationController.view.layer renderInContext:ctx];
    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UINavigationController *nc = [QYSItemDetailsViewController navController];
    QYSItemDetailsViewController *c = (QYSItemDetailsViewController *)(nc.topViewController);
    c.title = @"玉龙雪山套票";
    c.backgroundImage = im;
    [self.navigationController presentViewController:nc animated:NO completion:^{
        [c showBackgroundLayerWithAnimate];
    }];
}

@end
