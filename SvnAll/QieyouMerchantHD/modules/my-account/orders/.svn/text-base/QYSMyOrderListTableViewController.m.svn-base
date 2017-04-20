//
//  QYSMyOrderListTableViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/13.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyOrderListTableViewController.h"
#import "QYSMyOrderDetailsViewController.h"
#import "OrderStatus.h"

#pragma mark - QYSMyOrderListCell

@interface QYSMyOrderListCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *btnImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *btn;

@property (nonatomic, strong) NSDictionary *infoDict;
@property (nonatomic, strong) Order *order;

@end

@implementation QYSMyOrderListCell

-(void)dealloc {

    
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = COLOR_HEX2RGB(0xe4e4e4);
  
        
        UIView *content_box = [[UIView alloc] init];
        content_box.translatesAutoresizingMaskIntoConstraints = NO;
        content_box.layer.borderColor = COLOR_HEX2RGB(0xd2d2d2).CGColor;
        content_box.layer.borderWidth = 0.5;
        content_box.backgroundColor = COLOR_MAIN_WHITE;
        [self.contentView addSubview:content_box];
        
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.textColor = COLOR_TEXT_GRAY;
        _nameLabel.font = FONT_NORMAL;
        [content_box addSubview:_nameLabel];
        
        self.stateLabel = [[UILabel alloc] init];
        _stateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _stateLabel.layer.cornerRadius = 3.0;
        _stateLabel.layer.masksToBounds = YES;
        _stateLabel.backgroundColor = COLOR_TEXT_RED;
        _stateLabel.textColor = COLOR_MAIN_WHITE;
        _stateLabel.font = FONT_NORMAL_13;
        [content_box addSubview:_stateLabel];
        
        UIView *line0 = [[UIView alloc] init];
        line0.translatesAutoresizingMaskIntoConstraints = NO;
        line0.backgroundColor = COLOR_HEX2RGB(0xececec);
        [content_box addSubview:line0];
        
        self.btnImage = [[UIImageView alloc] init];
        _btnImage.translatesAutoresizingMaskIntoConstraints = NO;
        [content_box addSubview:_btnImage];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel.font = FONT_NORMAL;
        _contentLabel.numberOfLines = 0;
        [content_box addSubview:_contentLabel];
        
        UIView *line1 = [[UIView alloc] init];
        line1.translatesAutoresizingMaskIntoConstraints = NO;
        line1.backgroundColor = COLOR_HEX2RGB(0xececec);
        [content_box addSubview:line1];
        
        self.dateLabel = [[UILabel alloc] init];
        _dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dateLabel.textColor = COLOR_HEX2RGB(0x686868);
        _dateLabel.font = FONT_WITH_SIZE(15.5);
        [content_box addSubview:_dateLabel];
        
        self.totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [content_box addSubview:_totalPriceLabel];
        
        self.btn = [[UILabel alloc] init];
        self.btn.translatesAutoresizingMaskIntoConstraints = NO;
        self.btn.textColor = [UIColor colorForHexString:@"#ff7e00"];
        self.btn.backgroundColor = [UIColor clearColor];
        self.btn.font = [UIFont systemFontOfSize:13.0f];
        [content_box addSubview:_btn];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(content_box,_nameLabel,_stateLabel,line0,_btnImage,_contentLabel,line1,_totalPriceLabel,_dateLabel,_btn);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-16-[content_box]-16-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[content_box]-15-|" options:0 metrics:nil views:vds]];
        
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_nameLabel(>=200)]" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_btn(<=120)]-15-|" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[line0]-15-|" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_btnImage(101)]-20-[_contentLabel]|" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[line1]-15-|" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[_dateLabel(>=200)]" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_totalPriceLabel(<=200)]-15-|" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nameLabel(52)][line0(1)]-10-[_btnImage(101)]-(8@100)-[line1(1)][_dateLabel(50)]|" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nameLabel(52)][line0(1)]-20-[_contentLabel]" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line1(1)][_totalPriceLabel(50)]|" options:0 metrics:nil views:vds]];
        [content_box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btn(26)]" options:0 metrics:nil views:vds]];
        
        [content_box addConstraint:[NSLayoutConstraint constraintWithItem:_btn
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_nameLabel
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                                 constant:0.0]];
    }
    return self;
}


-(void)setOrder:(Order *)order {
    
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@",order.contact,order.telephone];
    self.btn.text = [OrderStatus orderStatus:order.state];
    
    kSetIntenetImageWith(_btnImage, order.product_thumb);
    
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.lineSpacing = 10.0f;
        
        NSString *productName = ValidateParam(order.product_name);
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] initWithString:[productName addString:@"\n"]
                                                                                        attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                                                     NSFontAttributeName:FONT_NORMAL,
                                                                                                     NSParagraphStyleAttributeName:paragraph_style}];
        NSString *price = ValidateParam(order.price);
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:price attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_BLACK,
                                                                                                NSFontAttributeName:FONT_WITH_SIZE(18.5),
                                                                                                NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元\n" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                           NSFontAttributeName:FONT_NORMAL,
                                                                           NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:ValidateParam(order.quantity) attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                          NSFontAttributeName:FONT_WITH_SIZE(20.0),
                                                                          NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        
        _contentLabel.attributedText = content_str;
    }

    _dateLabel.text = [NSString stringFromDateSp:[order.create_time longLongValue]];
    
    {
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:ValidateParam(order.total) attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xfe471a),
                                                                                                   NSFontAttributeName:FONT_WITH_SIZE(24.0)}];
        [price appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                         NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                         NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
        [price appendAttributedString:p];
        
        _totalPriceLabel.attributedText = price;
    }
}

@end

#pragma mark - QYSMyOrderListTableViewController

@interface QYSMyOrderListTableViewController ()

@property (nonatomic, strong) UINavigationController *myOrderDetailsNavViewController;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger PageSize;
@property (nonatomic, strong) OrderResponse *orderResponse;
@property (nonatomic, strong) NSMutableArray *orderList;

@end

@implementation QYSMyOrderListTableViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.page = 1;
        self.PageSize = 20;
        self.orderList = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.tableView.backgroundColor = COLOR_HEX2RGB(0xe4e4e4);
    
    UIView *v = [[UIView alloc] initWithFrame:self.view.bounds];
    v.backgroundColor = COLOR_HEX2RGB(0xe4e4e4);
    
    self.tableView.backgroundView = v;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupRefresh];
    [self setupFootRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [[OrderService sharedOrderService] getOrdersWithPage:_page pageSize:_PageSize OrderState:_orderState firstResponse:^{
         
     } complete:^(OrderResponse *orderResponse) {
         [self reloadDataWithResponse:orderResponse];
     } error:^(NSString *error) {
         JDStatusBarNotificationError(error);
     }];
}

-(void)reloadDataWithResponse:(OrderResponse *)orderResponse {
    self.tableView.sqEV_emptyView = tableViewEmpty(self.tableView.frame);
    self.orderResponse = orderResponse;
    
    if (nil == self.orderList) {
        self.orderList = [@[] mutableCopy];
    }
    
    if ([self.orderList count] > 0) {
        [self.orderList removeAllObjects];
    }
    
    self.orderList = [orderResponse.data mutableCopy];
    
    [self.tableView reloadData];
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
        weakSelf.page = 1;
        
        [[OrderService sharedOrderService] getOrdersWithPage:weakSelf.page pageSize:weakSelf.PageSize OrderState:weakSelf.orderState firstResponse:^{
            
        } complete:^(OrderResponse *orderResponse) {
             [weakSelf reloadDataWithResponse:orderResponse];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        } error:^(NSString *error) {
            JDStatusBarNotificationError(error);
             [weakSelf.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
    [self.tableView.pullToRefreshView setProgressView:progressView1];
}

-(void)setupFootRefresh {
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在玩命加载中...";
}

- (void)footerRereshing {
    self.page += 1;
    [[OrderService sharedOrderService] getOrdersWithPage:_page pageSize:_PageSize OrderState:_orderState firstResponse:^{
        
    } complete:^(OrderResponse *orderResponse) {
        [self reloadFootDateWithResponse:orderResponse];
        [self.tableView footerEndRefreshing];
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
        [self.tableView footerEndRefreshing];
    }];
}

-(void)reloadFootDateWithResponse:(OrderResponse *)orderResponse {
    [self.orderList addObjectsFromArray:orderResponse.data];
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_orderList count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.orderState == kOrderStateWatingPay && [_orderList count] > 0) {
        return 30.0f;
    }
    
    return 0.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 30)];
    headView.backgroundColor = COLOR_HEX2RGB(0xe4e4e4);
    UILabel *label = [UILabel LabelWithCustomFontFrame:CGRectMake(20, (30 - 12) / 2, 380, 13) text:@"2小时内不支付，订单将自动取消" textColor:[UIColor orangeColor] font:10.0f textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont systemFontOfSize:13.0f];
    [headView addSubview:label];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 257.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSMyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-order-list-cell"];
    if (!cell)
    {
        cell = [[QYSMyOrderListCell alloc] initWithReuseIdentifier:@"my-order-list-cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Order *order = [_orderList objectAtIndex:indexPath.row];
    cell.order = order;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Order *order = [_orderList objectAtIndex:indexPath.row];
   
    
    self.myOrderDetailsNavViewController = [QYSMyOrderDetailsViewController navControllerWithOrderId:order.order_num];
    _myOrderDetailsNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
    
    QYSPopupView *pop_view = [[QYSPopupView alloc] init];
    pop_view.contentView = _myOrderDetailsNavViewController.view;
    [pop_view show];
}

@end
