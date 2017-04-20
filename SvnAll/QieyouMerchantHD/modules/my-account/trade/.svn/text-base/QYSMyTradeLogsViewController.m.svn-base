//
//  QYSMyTradeLogsViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/16.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyTradeLogsViewController.h"
#import "QYSMyOrderDetailsViewController.h"
#import "QYSMyCashViewController.h"
#import "QYSMainViewController.h"

typedef enum {
    QYSMyTradeLogsCellTypeIncome = 0,
    QYSMyTradeLogsCellTypeOut
} QYSMyTradeLogsCellType;

#pragma mark -

@interface QYSMyTradeLogsHeaderCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, assign) NSDictionary *infoDict;
@property (nonatomic, strong) BargainingRecordTitle *recordTitle;

@end

@implementation QYSMyTradeLogsHeaderCell

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
        
        self.backgroundColor = COLOR_HEX2RGB(0xe8e8e8);
        
        UIView *v = [[UIView alloc] init];
        v.translatesAutoresizingMaskIntoConstraints = NO;
        v.layer.borderColor = COLOR_HEX2RGB(0xc8c7cc).CGColor;
        v.layer.borderWidth = 0.5;
        [self.contentView addSubview:v];
        
        UILabel *lb = [[UILabel alloc] init];
        lb.translatesAutoresizingMaskIntoConstraints = NO;
        self.leftLabel = lb;
        [self.contentView addSubview:lb];
        
        lb = [[UILabel alloc] init];
        lb.translatesAutoresizingMaskIntoConstraints = NO;
        self.rightLabel = lb;
        [self.contentView addSubview:lb];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_leftLabel,_rightLabel,v);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[v]-(-1)-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_leftLabel(200)][_rightLabel]-40-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_rightLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[v]|" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    UIColor *text_color = COLOR_HEX2RGB(0x797b7e);
    
        //
    NSMutableAttributedString *date = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"02" attributes:@{NSForegroundColorAttributeName:text_color,
                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:24.0]}];
    [date appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"月  02.01 - 02.28" attributes:@{NSForegroundColorAttributeName:text_color,
                                                                                 NSFontAttributeName:FONT_WITH_SIZE(12)}];
    [date appendAttributedString:p];
    
    _leftLabel.attributedText = date;
    
        //
    NSMutableAttributedString *tra = [[NSMutableAttributedString alloc] init];
    
    p = [[NSAttributedString alloc] initWithString:@"收入  " attributes:@{NSForegroundColorAttributeName:text_color,
                                                                    NSFontAttributeName:FONT_WITH_SIZE(12)}];
    [tra appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"1024.00" attributes:@{NSForegroundColorAttributeName:text_color,
                                                                      NSFontAttributeName:FONT_WITH_SIZE(15)}];
    [tra appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"    支出  " attributes:@{NSForegroundColorAttributeName:text_color,
                                                                      NSFontAttributeName:FONT_WITH_SIZE(12)}];
    [tra appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"176.00" attributes:@{NSForegroundColorAttributeName:text_color,
                                                                           NSFontAttributeName:FONT_WITH_SIZE(15)}];
    [tra appendAttributedString:p];
    
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.attributedText = tra;
}

-(void)setRecordTitle:(BargainingRecordTitle *)recordTitle {
    UIColor *text_color = COLOR_HEX2RGB(0x797b7e);
    
    /*
     @property (retain,nonatomic) NSNumber *cashin;
     @property (retain,nonatomic) NSNumber *month_end;
     @property (retain,nonatomic) NSNumber *cashout;
     @property (retain,nonatomic) NSString *lastid;
     @property (retain,nonatomic) NSNumber *month_start;
     */
    //
    
    NSString *month = [NSString stringFromDateFormatterWithMM:[recordTitle.month_start longLongValue]];
    
    NSMutableAttributedString *date = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:month attributes:@{NSForegroundColorAttributeName:text_color,
                                                                                          NSFontAttributeName:[UIFont systemFontOfSize:24.0]}];
    [date appendAttributedString:p];
    
    NSString *month_start = [NSString stringFromDateFormatterWithMMdd:[recordTitle.month_start longLongValue]];
    NSString *month_end = [NSString stringFromDateFormatterWithMMdd:[recordTitle.month_end longLongValue]];
    
    NSString *timeString = [NSString stringWithFormat:@"月  %@ - %@",month_start, month_end];
    
    p = [[NSAttributedString alloc] initWithString:timeString attributes:@{NSForegroundColorAttributeName:text_color,
                                                                                    NSFontAttributeName:FONT_WITH_SIZE(12)}];
    [date appendAttributedString:p];
    
    _leftLabel.attributedText = date;
    
    //
    NSMutableAttributedString *tra = [[NSMutableAttributedString alloc] init];
    
    NSString *cashin = [NSString stringWithFormat:@"%zd",[recordTitle.cashin integerValue]];
    
    p = [[NSAttributedString alloc] initWithString:@"收入  " attributes:@{NSForegroundColorAttributeName:text_color,
                                                                        NSFontAttributeName:FONT_WITH_SIZE(12)}];
    [tra appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:cashin attributes:@{NSForegroundColorAttributeName:text_color,
                                                                           NSFontAttributeName:FONT_WITH_SIZE(15)}];
    [tra appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"    支出  " attributes:@{NSForegroundColorAttributeName:text_color,
                                                                            NSFontAttributeName:FONT_WITH_SIZE(12)}];
    [tra appendAttributedString:p];
    
    NSString *cashout = [NSString stringWithFormat:@"%zd",[recordTitle.cashout integerValue]];
    p = [[NSAttributedString alloc] initWithString:cashout attributes:@{NSForegroundColorAttributeName:text_color,
                                                                          NSFontAttributeName:FONT_WITH_SIZE(15)}];
    [tra appendAttributedString:p];
    
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.attributedText = tra;
}

@end

#pragma mark - QYSMyTradeLogsCell

@interface QYSMyTradeLogsCell : UITableViewCell

@property (nonatomic, assign) QYSMyTradeLogsCellType type;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) NSDictionary *infoDict;
@property (nonatomic, strong) BargainingRecordDetail *recordDetail;

@end

@implementation QYSMyTradeLogsCell

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
        
        self.backgroundColor = COLOR_HEX2RGB(0xf5f5f5);
        
        UIView *line = [[UIView alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = COLOR_MAIN_BORDER_GRAY;
        [self.contentView addSubview:line];
        
        self.dateLabel = [[UILabel alloc] init];
        _dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dateLabel.textColor = COLOR_TEXT_BLACK;
        _dateLabel.numberOfLines = 2;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_dateLabel];
        
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.textColor = COLOR_TEXT_BLACK;
        _nameLabel.font = FONT_WITH_SIZE(15.0);
        [self.contentView addSubview:_nameLabel];
        
        self.orderNumberLabel = [[UILabel alloc] init];
        _orderNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _orderNumberLabel.textColor = COLOR_HEX2RGB(0x686868);
        _orderNumberLabel.font = FONT_WITH_SIZE(14);
        [self.contentView addSubview:_orderNumberLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceLabel.font = FONT_WITH_SIZE(15.0);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_priceLabel];
        
        self.iconImageView = [[UIImageView alloc] init];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _iconImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_iconImageView];
        
        UIImageView *acc_iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@" "]]; //cell-accssory01
        acc_iv.translatesAutoresizingMaskIntoConstraints = NO;
        acc_iv.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:acc_iv];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_dateLabel,_nameLabel,_orderNumberLabel,_priceLabel,_iconImageView,line,acc_iv);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-72-[line(1)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[line]-(-1)-|" options:0 metrics:nil views:vds]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_dateLabel(48)][_iconImageView(33)]-43-[_nameLabel(132)]-[_orderNumberLabel(270)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_priceLabel(100)]-45-[acc_iv(10)]-40-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dateLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_iconImageView]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nameLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_orderNumberLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_priceLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[acc_iv(15)]" options:0 metrics:nil views:vds]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:acc_iv
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
    {
        NSMutableAttributedString *date = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"25\n" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x999999),
                                                                                                   NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
        [date appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"周二" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x999999),
                                                                            NSFontAttributeName:FONT_WITH_SIZE(10.0)}];
        [date appendAttributedString:p];
        
        _dateLabel.attributedText = date;
    }
    
    _nameLabel.text = @"高山玫瑰花茶";
    _orderNumberLabel.text = @"2005020109887";
    
    if (QYSMyTradeLogsCellTypeIncome == _type)
    {
        _iconImageView.image = [UIImage imageNamed:@"macc-trade-in"];
        _priceLabel.textColor = COLOR_HEX2RGB(0xe40000);
    }
    else
    {
        _iconImageView.image = [UIImage imageNamed:@"macc-trade-out"];
        _priceLabel.textColor = COLOR_HEX2RGB(0x33bc60);
    }
    
    _priceLabel.text = @"¥79.99";
}

-(void)setRecordDetail:(BargainingRecordDetail *)recordDetail {
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.alignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *date = [[NSMutableAttributedString alloc] init];
        
        NSString *dayValue = [NSString stringFromDateFormatterWithdd:[recordDetail.create_time longLongValue]];
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:dayValue.length > 0 ? [dayValue addString:@"\n"] : @"\n" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                                                                                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]}];
        [date appendAttributedString:p];
        
        NSString *weekValue = [NSString stringFromDateWithWeekSp:[recordDetail.create_time longLongValue]];
        
        p = [[NSAttributedString alloc] initWithString:weekValue attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                              NSFontAttributeName:FONT_WITH_SIZE(10.0)}];
        [date appendAttributedString:p];
        
        _dateLabel.attributedText = date;
    }
    
    _nameLabel.text = recordDetail.comments.length > 0 ? recordDetail.comments : @"";
    _orderNumberLabel.text = [NSString stringWithFormat:@"订单编号%@",recordDetail.order_num];
    
    
    if ([recordDetail.record_type isEqualToString:@"cashout"]) {
        _iconImageView.image = [UIImage imageNamed:@"macc-trade-out"];
    }else {
        _iconImageView.image = [UIImage imageNamed:@"macc-trade-in"];
    }
    
    _priceLabel.text = recordDetail.amount.description.length > 0 ? [NSString stringWithFormat:@"￥%@",recordDetail.amount] : @"";
}

@end

#pragma mark - QYSMyTradeLogsViewController

@interface QYSMyTradeLogsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel *totalAssetsLabel;
@property (nonatomic, strong) UILabel *availiableLabel;
@property (nonatomic, strong) UIButton *btnWithdraw;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UINavigationController *myOrderDetailsNavViewController;

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *balance;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;

@end

@implementation QYSMyTradeLogsViewController

-(void)dealloc {
    _totalAssetsLabel = nil;
    _availiableLabel = nil;
    _btnWithdraw = nil;
    _tableView = nil;
    _account = nil;
    _balance = nil;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.page = 0;
        self.pageSize = 9999;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //获取总资产和可提取金额信息
    [[DrawMoneyService sharedDrawMoneyService] bankrollComplete:^(NSString *account, NSString *balance) {
        [self setHeaderValueWithAccount:account balance:balance];
    } error:^(NSString *error) {
        //JDStatusBarNotificationError(error);
    }];
    
    [[BargainingRecordService sharedBargainingRecordService] getBargaingRecordWithLastId:_page limit:_pageSize complete:^(BargainingRecordResppnse *response) {
        [self dataManagerWithResponse:response];
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
    
}

-(void)dataManagerWithResponse:(BargainingRecordResppnse *)response {
    
    NSArray *titles = response.data.title;
    if (nil == titles || [titles count] == 0) {
        return;
    }
    
    if (nil == _dataDictionary) {
        self.dataDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    if ([_dataDictionary count] > 0) {
        [_dataDictionary removeAllObjects];
    }
    
    NSMutableArray *list = [response.data.list mutableCopy];
    
    for (int i = 0; i < [titles count]; i ++) {
        
        //初始化dictionary
        NSMutableDictionary *dataDictionary = [NSMutableDictionary new];
        
        BargainingRecordTitle *recordTitle = [titles objectAtIndex:i];
        // NSLog(@"title:%@-%@-%@-%@-%@",recordTitle.cashin,recordTitle.month_end,recordTitle.cashout,recordTitle.lastid,recordTitle.month_start);
        //设置title信息
        [dataDictionary  setObject:recordTitle forKey:@"title"];
        //设置title里面的内容
        NSMutableArray *details = [NSMutableArray new];
        NSMutableArray *addObjects = [NSMutableArray new];
        
        NSInteger lastid = [recordTitle.lastid integerValue];
        for (int j = 0; j < [list count]; j ++) {
            BargainingRecordDetail *recordDetail = [list objectAtIndex:j];
            // NSLog(@"detail:%@-%@-%@-%@-%@-%@",recordDetail.record_id,recordDetail.amount,recordDetail.order_num,recordDetail.record_type,recordDetail.create_time,recordDetail.comments);
            NSInteger record_id = [recordDetail.record_id integerValue];
            if (record_id >= lastid) {
                [details addObject:recordDetail];
                [addObjects addObject:recordDetail];
            }
        }
        
        [list removeObjectsInArray:addObjects];
        
        [dataDictionary setObject:details forKey:@"details"];
        
        [self.dataDictionary setObject:dataDictionary forKey:@(i)];
        
    }
    [_tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    UIView *top_bar = [[UIView alloc] init];
    top_bar.translatesAutoresizingMaskIntoConstraints = NO;
    top_bar.backgroundColor = COLOR_MAIN_WHITE;
    top_bar.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
    top_bar.layer.borderWidth = 1.0;
    [self.view addSubview:top_bar];
    
    self.totalAssetsLabel = [[UILabel alloc] init];
    _totalAssetsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _totalAssetsLabel.textColor = COLOR_TEXT_BLACK;
    [top_bar addSubview:_totalAssetsLabel];
    
    self.availiableLabel = [[UILabel alloc] init];
    _availiableLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _availiableLabel.textColor = COLOR_TEXT_BLACK;
    [top_bar addSubview:_availiableLabel];
    
    self.btnWithdraw = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnWithdraw.translatesAutoresizingMaskIntoConstraints = NO;
    [_btnWithdraw setTitle:@"申请提现" forState:UIControlStateNormal];
    [_btnWithdraw setBackgroundImage:[[UIImage imageNamed:@"btn-bg-orange"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [self.btnWithdraw addTarget:self action:@selector(btnWithdrawClicked:) forControlEvents:UIControlEventTouchUpInside];
    [top_bar addSubview:_btnWithdraw];
    
    self.tableView = [[UITableView alloc] init];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.backgroundColor = COLOR_SPLITE_BG_GRAY;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(top_bar,_totalAssetsLabel,_availiableLabel,_tableView,_btnWithdraw);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[top_bar]-(-1)-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_tableView]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[top_bar(60)][_tableView]|" options:0 metrics:nil views:vds]];
    
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_totalAssetsLabel(200)]-30-[_availiableLabel(200)]" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_btnWithdraw(180)]-10-|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_totalAssetsLabel]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_availiableLabel]|" options:0 metrics:nil views:vds]];
    [top_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btnWithdraw(44)]" options:0 metrics:nil views:vds]];
    
    [top_bar addConstraint:[NSLayoutConstraint constraintWithItem:_btnWithdraw
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:top_bar
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                         constant:0.0]];
    
    [self setHeaderValue];
    [self setupRefresh];
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
    
    [self.tableView setPullToRefreshWithHeight:60.0f actionHandler:^(BMYPullToRefreshView *pullToRefreshView) {
        weakSelf.page = 0;
        
        [[BargainingRecordService sharedBargainingRecordService] getBargaingRecordWithLastId:weakSelf.page limit:weakSelf.pageSize complete:^(BargainingRecordResppnse *response) {
            [weakSelf dataManagerWithResponse:response];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        } error:^(NSString *error) {
            //JDStatusBarNotificationError(error);
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
    [self.tableView.pullToRefreshView setProgressView:progressView1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataDictionary count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dataDictionary = [_dataDictionary objectForKey:@(section)];
    NSMutableArray *data = [dataDictionary objectForKey:@"details"];
    return [data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QYSMyTradeLogsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-trade-logs-h-cell"];
    if (!cell)
    {
        cell = [[QYSMyTradeLogsHeaderCell alloc] initWithReuseIdentifier:@"my-trade-logs-h-cell"];
    }
    
    NSDictionary *dataDictionary = [_dataDictionary objectForKey:@(section)];
    BargainingRecordTitle *recordTitle = [dataDictionary objectForKey:@"title"];
    cell.recordTitle = recordTitle;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSMyTradeLogsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-trade-logs-cell"];
    if (!cell)
    {
        cell = [[QYSMyTradeLogsCell alloc] initWithReuseIdentifier:@"my-trade-logs-cell"];
    }
    
    cell.infoDict = nil;
    NSDictionary *dataDictionary = [_dataDictionary objectForKey:@(indexPath.section)];
    NSMutableArray *data = [dataDictionary objectForKey:@"details"];
    BargainingRecordDetail *recordDetail = [data objectAtIndex:indexPath.row];
    cell.recordDetail = recordDetail;
    
    if (0 == indexPath.row%2)
    {
        cell.type = QYSMyTradeLogsCellTypeOut;
    }
    else
    {
        cell.type = QYSMyTradeLogsCellTypeIncome;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NSDictionary *dataDictionary = [_dataDictionary objectForKey:@(indexPath.section)];
    NSMutableArray *data = [dataDictionary objectForKey:@"details"];
    BargainingRecordDetail *recordDetail = [data objectAtIndex:indexPath.row];
    self.myOrderDetailsNavViewController = [QYSMyOrderDetailsViewController navControllerWithOrderId:recordDetail.order_num];
    _myOrderDetailsNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
    
    QYSPopupView *pop_view = [[QYSPopupView alloc] init];
    pop_view.contentView = _myOrderDetailsNavViewController.view;
    [pop_view show];
    
    return;
     */
}

#pragma mark -

- (void)setHeaderValue
{
        //
    NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.minimumLineHeight = 25.0f;
    paragraph_style.maximumLineHeight = 25.0f;
    
    NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"总资产：" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x333333),
                                                                                                     NSFontAttributeName:FONT_WITH_SIZE(12.0),
                                                                                                     NSParagraphStyleAttributeName:paragraph_style}];
    
    [content_str appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"¥28918.30" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xd93229),
                                                                          NSFontAttributeName:[UIFont systemFontOfSize:24.0],
                                                                          NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    _totalAssetsLabel.attributedText = content_str;
    
    [content_str deleteCharactersInRange:NSMakeRange(0, content_str.length)];
    
    p = [[NSAttributedString alloc] initWithString:@"可提取金额：" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x333333),
                                                                    NSFontAttributeName:FONT_WITH_SIZE(12.0),
                                                                    NSParagraphStyleAttributeName:paragraph_style}];
    
    [content_str appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"¥21000.30" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x1c8973),
                                                                            NSFontAttributeName:[UIFont systemFontOfSize:24.0],
                                                                            NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    _availiableLabel.attributedText = content_str;
}

#pragma mark -

- (void)setHeaderValueWithAccount:(NSString *)account balance:(NSString *)balance
{
    //
    NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.minimumLineHeight = 25.0f;
    paragraph_style.maximumLineHeight = 25.0f;
    
    NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"总资产：" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                                            NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                                            NSParagraphStyleAttributeName:paragraph_style}];
    
    [content_str appendAttributedString:p];
    
    NSString *tottalAccount = account.description.length > 0 ? [NSString stringWithFormat:@"￥%@",account] : @"￥0.00";
    p = [[NSAttributedString alloc] initWithString:tottalAccount attributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                                              NSFontAttributeName:[UIFont boldSystemFontOfSize:22.0],
                                                                              NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    _totalAssetsLabel.attributedText = content_str;
    
    [content_str deleteCharactersInRange:NSMakeRange(0, content_str.length)];
    
    p = [[NSAttributedString alloc] initWithString:@"可提取金额：" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                          NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                          NSParagraphStyleAttributeName:paragraph_style}];
    
    [content_str appendAttributedString:p];
    
    NSString *balanceValue = [balance description].length > 0  ? [NSString stringWithFormat:@"￥%@",balance] : @"￥0.00";
    p = [[NSAttributedString alloc] initWithString:balanceValue attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x1c8973),
                                                                             NSFontAttributeName:[UIFont boldSystemFontOfSize:22.0],
                                                                             NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    _availiableLabel.attributedText = content_str;
}

-(void)btnWithdrawClicked:(id)sender {
    QYSMyCashViewController *c = [[QYSMyCashViewController alloc] initWithNibName:nil bundle:nil];
    [[QYSMainViewController shareInstance].navigationController pushViewController:c animated:YES];
}

@end
