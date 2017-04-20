//
//  QYSMyCashLogsViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/13/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSMyCashLogsViewController.h"

#pragma mark - QYSMyCashLogsCell

@interface QYSMyCashLogsCell : UITableViewCell

@property (nonatomic, readonly) UILabel *field0Label;
@property (nonatomic, readonly) UILabel *field1Label;
@property (nonatomic, readonly) UILabel *field2Label;
@property (nonatomic, readonly) UILabel *field3Label;

@property (nonatomic, assign) NSDictionary *infoDict;
@property (nonatomic, strong) DrawMoney *drawMoney;

@end

@implementation QYSMyCashLogsCell

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
        self.backgroundColor = COLOR_HEX2RGB(0xf5f5f5);
        
        _field0Label = [[UILabel alloc] init];
        _field0Label.translatesAutoresizingMaskIntoConstraints = NO;
        _field0Label.textColor = COLOR_HEX2RGB(0x686868);
        _field0Label.font = FONT_NORMAL;
        _field0Label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_field0Label];
        
        _field1Label = [[UILabel alloc] init];
        _field1Label.translatesAutoresizingMaskIntoConstraints = NO;
        _field1Label.textColor = COLOR_HEX2RGB(0x686868);
        _field1Label.font = FONT_NORMAL;
        _field1Label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_field1Label];
        
        _field2Label = [[UILabel alloc] init];
        _field2Label.translatesAutoresizingMaskIntoConstraints = NO;
        _field2Label.textColor = COLOR_HEX2RGB(0xafafaf);
        _field2Label.font = FONT_NORMAL;
        _field2Label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_field2Label];
        
        _field3Label = [[UILabel alloc] init];
        _field3Label.translatesAutoresizingMaskIntoConstraints = NO;
        _field3Label.textColor = COLOR_HEX2RGB(0xafafaf);
        _field3Label.font = FONT_NORMAL;
        _field3Label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_field3Label];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_field0Label, _field1Label, _field2Label, _field3Label);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_field0Label(160)][_field1Label(165)][_field2Label(215)][_field3Label]-30-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_field0Label]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_field1Label]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_field2Label]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_field3Label]|" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    _field0Label.text = @"2015-02-01";
    _field2Label.text = @"已完成";
    _field3Label.text = @"银行处理成功";
    
    UIColor *price_color = COLOR_HEX2RGB(0x686868);
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"230.00" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff1f44),
                                                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0]}];
    [price appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:price_color,
                                                                       NSFontAttributeName:FONT_WITH_SIZE(12.0),
                                                                       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
    [price appendAttributedString:p];
    _field1Label.attributedText = price;
}

-(void)setDrawMoney:(DrawMoney *)drawMoney {
    self.field0Label.text = [NSString stringFromDateFormatterWithyyyyMMdd:[drawMoney.create_time longLongValue]];
    if ([drawMoney.state isEqualToString:@"settled"]) {
        self.field2Label.text = @"已完成";
        self.field2Label.textColor = [UIColor colorForHexString:@"#ababab"];
    }else {
        self.field2Label.text = @"申请中";
        self.field2Label.textColor = [UIColor colorForHexString:@"#33bc60"];
    }
    NSString *commnets = drawMoney.comments;
    if ([commnets isBlank]) {
        self.field3Label.text = @"正在处理中";
    }else {
        self.field3Label.text = drawMoney.comments;
    }
    
    UIColor *price_color = COLOR_RGBA(0.71, 0.71, 0.71, 1.0);
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:drawMoney.amount.length > 0 ? drawMoney.amount : @"0" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                                                                                                          NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0]}];
    [price appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:price_color,
                                                                     NSFontAttributeName:FONT_WITH_SIZE(12.0),
                                                                     NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
    [price appendAttributedString:p];
    _field1Label.attributedText = price;
}

@end

#pragma mark - QYSMyCashLogsViewController

@interface QYSMyCashLogsViewController ()

@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *drawMoneyList;

@end

@implementation QYSMyCashLogsViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.page = 1;
        self.pageSize = 20;
        self.drawMoneyList = [NSMutableArray new];
    }
    
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DrawMoneyService sharedDrawMoneyService] drawMoneyWithPage:[NSString stringWithFormat:@"%zd",_page]
                                                        pageSize:[NSString stringWithFormat:@"%zd",_pageSize]
                                                        complete:^(DrawMoneyResponse *response) {
                                                            [self reloadDataWithResponse:response];
                                                        } error:^(NSString *error) {
                                                            JDStatusBarNotificationError(error);
                                                        }];
}

-(void)reloadDataWithResponse:(DrawMoneyResponse *)response {
    if (nil == _drawMoneyList) {
        self.drawMoneyList = [@[] mutableCopy];
    }
    
    if ([_drawMoneyList count] > 0) {
        [_drawMoneyList removeAllObjects];
    }
    
    self.drawMoneyList = [NSMutableArray arrayWithArray:response.data];
    [self.tableView reloadData];
}

-(void)reloadDataWithFootRefresh:(DrawMoneyResponse *)response {
    [self.drawMoneyList addObjectsFromArray:response.data];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.tableView.separatorColor = COLOR_HEX2RGB(0xd2d2d2);
    
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    _tableHeaderView.backgroundColor = COLOR_SPLITE_BG_GRAY;
    
    UILabel *lb_field0 = [[UILabel alloc] init];
    lb_field0.translatesAutoresizingMaskIntoConstraints = NO;
    lb_field0.textColor = COLOR_HEX2RGB(0x686868);
    lb_field0.font = FONT_NORMAL;
    lb_field0.text = @"申请时间";
    lb_field0.textAlignment = NSTextAlignmentCenter;
    [_tableHeaderView addSubview:lb_field0];
    
    UILabel *lb_filed1 = [[UILabel alloc] init];
    lb_filed1.translatesAutoresizingMaskIntoConstraints = NO;
    lb_filed1.textColor = COLOR_HEX2RGB(0x686868);
    lb_filed1.font = FONT_NORMAL;
    lb_filed1.text = @"提现金额";
    lb_filed1.textAlignment = NSTextAlignmentCenter;
    [_tableHeaderView addSubview:lb_filed1];
    
    UILabel *lb_field2 = [[UILabel alloc] init];
    lb_field2.translatesAutoresizingMaskIntoConstraints = NO;
    lb_field2.textColor = COLOR_HEX2RGB(0x686868);
    lb_field2.font = FONT_NORMAL;
    lb_field2.text = @"状态";
    lb_field2.textAlignment = NSTextAlignmentCenter;
    [_tableHeaderView addSubview:lb_field2];
    
    UILabel *lb_field3 = [[UILabel alloc] init];
    lb_field3.translatesAutoresizingMaskIntoConstraints = NO;
    lb_field3.textColor = COLOR_HEX2RGB(0x686868);
    lb_field3.font = FONT_NORMAL;
    lb_field3.text = @"处理记录";
    lb_field3.textAlignment = NSTextAlignmentCenter;
    [_tableHeaderView addSubview:lb_field3];
    
    UIView *line = [[UIView alloc] init];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.backgroundColor = COLOR_HEX2RGB(0xd2d2d2);
    [_tableHeaderView addSubview:line];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(lb_field0, lb_filed1, lb_field2, lb_field3, line);
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[lb_field0(160)][lb_filed1(165)][lb_field2(215)][lb_field3]-30-|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_field0]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_filed1]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_field2]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_field3]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(0.5)]|" options:0 metrics:nil views:vds]];
    
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
        [[DrawMoneyService sharedDrawMoneyService] drawMoneyWithPage:[NSString stringWithFormat:@"%zd",weakSelf.page]
                                                            pageSize:[NSString stringWithFormat:@"%zd",weakSelf.pageSize]
                                                            complete:^(DrawMoneyResponse *response) {
                                                                [weakSelf reloadDataWithResponse:response];
                                                                 [weakSelf.tableView.pullToRefreshView stopAnimating];
                                                            } error:^(NSString *error) {
                                                                //JDStatusBarNotificationError(error);
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
        
        [[DrawMoneyService sharedDrawMoneyService] drawMoneyWithPage:[NSString stringWithFormat:@"%zd",vc.page]
                                                            pageSize:[NSString stringWithFormat:@"%zd",vc.pageSize]
                                                            complete:^(DrawMoneyResponse *response) {
                                                                [vc reloadDataWithFootRefresh:response];
                                                                [vc.tableView footerEndRefreshing];
                                                            } error:^(NSString *error) {
                                                                //JDStatusBarNotificationError(error);
                                                                [vc.tableView footerEndRefreshing];
                                                            }];
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_drawMoneyList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _tableHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSMyCashLogsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-cash-log-cell"];
    if (!cell)
    {
        cell = [[QYSMyCashLogsCell alloc] initWithReuseIdentifier:@"my-cash-log-cell"];
    }
    
    cell.infoDict = nil;
    DrawMoney *model = [_drawMoneyList objectAtIndex:indexPath.row];
    cell.drawMoney = model;
    
    return cell;
}

@end
