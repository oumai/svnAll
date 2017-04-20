//
//  StoreIntroductionViewController.m
//  QieyouMerchant
//
//  Created by 李赛强 on 14-11-26.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import "StoreIntroductionViewController.h"
#import "StoreIntroductionCell.h"
#import "UIButton+StoreIntore.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import <SDWebImage/UIImageView+WebCache.h>
#import <JDStatusBarNotification/JDStatusBarNotification.h>
#import "UIHelper.h"
#import "QYSLoginViewController.h"

#define kLeftMarginWidth 12
#define kTopMarginImageViewHeight 19
#define kTopMarginLabelHeight 25
#define kLeftMarginLabelWidth 110
#define kImageViewWidth 86
#define kHeadViewHeight 122


@interface StoreIntroductionViewController ()<UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *storeNameLabel;
@property (nonatomic, strong) UILabel *characteristicLabel;
@property (nonatomic, strong) SQenburnsView *headView;
@property (nonatomic, strong) NSMutableArray *contexts;
@property (nonatomic, assign) BOOL isFavor;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *favoriteButton;
@property (nonatomic, strong) NSMutableArray *tels;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) StoreIntroduction *storeIntroduction;

@property (nonatomic, strong) NSString *storeTelString;

@end

@implementation StoreIntroductionViewController

-(void)dealloc {
    _iconImageView = nil;
    _storeNameLabel = nil;
    _characteristicLabel = nil;
    _headView = nil;
    _contexts = nil;
    
    _storeId = nil;
    _shareButton = nil;
    _favoriteButton = nil;
    _tels = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.storeTelString = @"暂无";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    [self setupTitleView];
    [self setupTableView];
    [self setupHeadView];
    
    [[MyStoreService sharedMyStoreService] getMyStoreInfoWithStoreId:_storeId Complete:^(StoreIntroductionResponse *response) {
        [self reloadDataWithResponse:response];
    } error:^(NSString *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Helper

-(void)setupFavButtonState:(BOOL)isFavor {
    if (isFavor) {
        self.favoriteButton.imgView.image = [UIImage imageNamed:@"common_icon_nav_Alreadyfavorite"];
    }else {
        self.favoriteButton.imgView.image = [UIImage imageNamed:@"common_icon_nav_favorite"];
    }
}

-(void) reloadDataWithResponse:(StoreIntroductionResponse *)response {
    
    self.storeIntroduction = response.data;
    //headView
    self.storeNameLabel.text = response.data.inn_name;
    self.characteristicLabel.text = response.data.features;
    NSString *imageUrlString = [NSString stringWithFormat:@"%@%@",kImageAPIBaseUrlString,response.data.inn_head];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"common_placehoder_image"]];
    
    //处理收藏按钮
    self.isFav = [response.data.inn_fav boolValue];
    [self setupFavButtonState:_isFav];
    
    //处理电话号码
    NSMutableArray *tels = [NSMutableArray new];
    
    NSString *inner_telephone = _storeIntroduction.inner_telephone;
    if ([inner_telephone isValid]) {
        [tels addObject:inner_telephone];
    }
    
    NSString *inner_moblie_number = _storeIntroduction.inner_moblie_number;
    if ([inner_moblie_number isValid]) {
        [tels addObject:inner_moblie_number];
    }
    
    if ([tels count] > 0) {
        self.storeTelString = [tels componentsJoinedByString:@" / "];
    }else {
        self.storeTelString = @"暂无";
    }
    
    //[self.tableView reloadData];
}


#pragma mark - UIView Init

-(void)setupTitleView {
    UILabel *titleLabel = [UILabel LabelWithFrame:CGRectMake(0, 0, 80, 40) text:@"店铺介绍" textColor:kColor(255, 255, 255, 1) font:16.0f textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = titleLabel;
}


-(void) setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor colorForHexString:@"#e5e5e5"];
    setExtraCellLineHidden(_tableView);

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)setupHeadView {
    self.headView = [[SQenburnsView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeadViewHeight)];
    self.headView.enableMotion = YES;
    self.headView.image = [UIImage imageNamed:@"StoreIntroduction_HeadView_BG.jpg"];
    
    self.tableView.tableHeaderView = _headView;
    
    [self setupHeadImageView:_headView];
    [self setupMyStoreNameLabel:_headView];
    [self setupfavoriteAndShareButton:_headView];
}

-(void)setupHeadImageView:(UIView *)headView {
    CGFloat imageViewWidth = headView.frame.size.height - kTopMarginImageViewHeight * 2;
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftMarginWidth, kTopMarginImageViewHeight, imageViewWidth, imageViewWidth)];
    self.iconImageView.image = [UIImage imageNamed:@"common_placehoder_image"];
    self.iconImageView.layer.cornerRadius = imageViewWidth/2;
    self.iconImageView.layer.masksToBounds = YES;
    [headView addSubview:self.iconImageView];
}

-(void)setupMyStoreNameLabel:(UIView *)headView {
    self.storeNameLabel = [UILabel LabelWithFrame:CGRectMake(kLeftMarginLabelWidth, kTopMarginLabelHeight, 191, 12) text:@"" textColor:/*[UIColor colorForHexString:@"#ff5a00"]*/[UIColor whiteColor] font:13.0f textAlignment:NSTextAlignmentLeft];
    [headView addSubview:self.storeNameLabel];
    
    self.characteristicLabel = [UILabel LabelWithFrame:CGRectMake(kLeftMarginLabelWidth, 43, 196, 29)
                                                      text:@""
                                             textColor:[UIColor whiteColor]
                                                      font:12.0f
                                             textAlignment:NSTextAlignmentLeft];
    self.characteristicLabel.numberOfLines = 0;
    self.characteristicLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [headView addSubview:self.characteristicLabel];
}

-(void)setupfavoriteAndShareButton:(UIView *)headView {
    
    
    self.favoriteButton = [UIButton ButtonWithFrame:CGRectMake(kLeftMarginLabelWidth, 80, 90, 23) title:@"收藏" normalImage:@"common_icon_nav_favorite" target:self action:@selector(favoriteBtnClicked:)];
    [headView addSubview:_favoriteButton];
    
    
    self.shareButton = [UIButton ButtonWithFrame:CGRectMake(209, 80, 90, 23) title:@"分享" normalImage:@"common_icon_nav_share" target:self action:@selector(shareBtnClicked:)];
    [headView addSubview:_shareButton];
}


-(UIView *)sectionViewWithTiele:(NSString *)sectionTitle {
    UIView *view_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 27)];
    view_.backgroundColor = [UIColor colorForHexString:@"#f0efed"];
    UILabel *label = [UILabel LabelWithFrame:CGRectMake(kLeftMarginWidth, (40 - 14)/2, 70, 14) text:sectionTitle textColor:[UIColor colorForHexString:@"#333333"] font:13.0f textAlignment:NSTextAlignmentLeft];
    [view_ addSubview:label];
    return view_;
}

- (void)iconImageViewAnimation {
    [self.iconImageView rotate360WithDuration:2.0 repeatCount:1 timingMode:i7Rotate360TimingModeLinear];
    self.iconImageView.animationDuration = 2.0;
    self.iconImageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"common_placehoder_image"],
                                          [UIImage imageNamed:@"common_placehoder_image"],
                                          [UIImage imageNamed:@"common_placehoder_image"],
                                          [UIImage imageNamed:@"common_placehoder_image"],
                                          [UIImage imageNamed:@"common_placehoder_image"],
                                          [UIImage imageNamed:@"common_placehoder_image"], nil];
    self.iconImageView.animationRepeatCount = 1;
    [self.iconImageView startAnimating];
}


#pragma mark - UItableView Delegate DataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (0 == indexPath.row) {
            return [StoreIntroductionCell heightForCell:_storeTelString];
        }
        return [StoreIntroductionCell heightForCell:_storeIntroduction.inn_address];
    }
    return [StoreIntroductionNoteCell heightForCell:_storeIntroduction.inn_summary];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0f;
    }else {
        return 40.0f;
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            
            CGFloat height = [StoreIntroductionCell heightForCell:_storeTelString];
            StoreIntroductionCell *cell = [[StoreIntroductionCell alloc] initWithFrame:CGRectMake(0, 0, 400, height)];
            cell.content = _storeTelString;
            return cell;
        }else if (1 == indexPath.row) {
            CGFloat height = [StoreIntroductionCell heightForCell:_storeIntroduction.inn_address];
            StoreIntroductionCell *cell = [[StoreIntroductionCell alloc] initWithFrame:CGRectMake(0, 0, 400, height)];
            cell.content = _storeIntroduction.inn_address;
            return cell;
        }
    }else if (1 == indexPath.section) {
        CGFloat height = [StoreIntroductionNoteCell heightForCell:_storeIntroduction.inn_summary];
        StoreIntroductionNoteCell *cell = [[StoreIntroductionNoteCell alloc] initWithFrame:CGRectMake(0, 0, 400, height)];
        cell.content = _storeIntroduction.inn_summary;
        return cell;
    }
    return nil;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
    }else if (section == 1) {
        return [self sectionViewWithTiele:@"店铺介绍"];
    }
    return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Action

-(void)favoriteBtnClicked:(UIButton *)buttton {
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
                
                FavoriteState state = self.isFav ? FavoriteStateDel : FavoriteStateAdd;
                
                [NSObject animate:^{
                    self.favoriteButton.imageView.spring.scaleXY = CGPointMake(1.5, 1.5);
                } completion:^(BOOL finished) {
                    
                    
                    [[FavoriteService sharedFavoriteService] favoriteStoreWithStoreId:_storeId operate:state complete:^(NSString *completeString) {
                        self.favoriteButton.imageView.spring.scaleXY = CGPointMake(1.0, 1.0);
                        self.isFav = !_isFav;
                        [self setupFavButtonState:_isFav];
                    } error:^(NSString *error) {
                        
                    }];
                    
                }];
                
                
                
            }];
        }];
        
        [c setFindPasswordBlock:^(QYSLoginViewController *controller) {
            [pop_view hide:YES complete:nil];
        }];
        
        return;
    }
    
    FavoriteState state = self.isFav ? FavoriteStateDel : FavoriteStateAdd;
    
    [NSObject animate:^{
        self.favoriteButton.imageView.spring.scaleXY = CGPointMake(1.5, 1.5);
    } completion:^(BOOL finished) {
        [[FavoriteService sharedFavoriteService] favoriteStoreWithStoreId:_storeId operate:state complete:^(NSString *completeString) {
            self.favoriteButton.imageView.spring.scaleXY = CGPointMake(1.0, 1.0);
            self.isFav = !_isFav;
            [self setupFavButtonState:_isFav];
        } error:^(NSString *error) {
            
        }];
        
    }];
}

-(void)shareBtnClicked:(UIButton *)buttton {
  
}

#pragma mark - Actions

-(void)leftBarButtonItemClicked:(UIBarButtonItem *)buttonItem {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
