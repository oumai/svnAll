//
//  QYSOrderSubmitViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/14.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSOrderSubmitViewController.h"
#import "QYSLoginViewController.h"
#import "OrderIdManager.h"
#import "QYSPayViewController.h"
#import "OrderCountSelectedView.h"
#import "QYSMyOrderDetailsViewController.h"

#pragma mark - QYSOrderSubmitCell

@interface QYSOrderSubmitCell : UITableViewCell

@property (nonatomic, copy, readwrite) void(^productStockisNotValidBlock)(); //填写的库存不合法
@property (nonatomic, copy, readwrite) void(^productBuyCountBlock)(NSInteger count);

@property (nonatomic, strong) UIImageView *btnImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UITextField *tfCount;

@property (nonatomic, strong) NSDictionary *infoDict;
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSString *totolPrice;
@property (nonatomic, strong) UILabel *sellCountLabel;
@property (nonatomic, strong) OrderCountSelectedView *countSelectedView;

@end

@implementation QYSOrderSubmitCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLOR_MAIN_CLEAR;
        self.contentView.backgroundColor = COLOR_MAIN_CLEAR;
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"main-buy-bg01"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
        bg.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:bg];
        
        self.btnImage = [[UIImageView alloc] init];
        _btnImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_btnImage];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel.textColor = COLOR_TEXT_BLACK;
        _contentLabel.font = FONT_NORMAL;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        
        UIView *box = [[UIView alloc] init];
        box.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:box];
        
        self.sellCountLabel = [UILabel LabelWithFrame:CGRectMake(102, 60, 200, 28) text:@"剩余库存: 90" textColor:[UIColor grayColor] font:14.0f textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_sellCountLabel];
       
        
        self.totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _totalPriceLabel.numberOfLines = 2;
        [self.contentView addSubview:_totalPriceLabel];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(bg,_btnImage,_contentLabel,box,/*_tfCount,btn_sub,btn_add,*/_totalPriceLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bg]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[_btnImage(78)]-10-[_contentLabel]-[box(155)]-[_totalPriceLabel]-25-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bg]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btnImage(78)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_contentLabel(20)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[box]-10-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_totalPriceLabel]-10-|" options:0 metrics:nil views:vds]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:box
                                                                     attribute:NSLayoutAttributeCenterX
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterX
                                                                    multiplier:1.0
                                                                      constant:0.0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_btnImage
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:0.0]];

        
        self.countSelectedView = [[OrderCountSelectedView alloc] initWithFrame:CGRectMake(423, 35, 140, 30)];
        
        __weak QYSOrderSubmitCell *weakSelf = self;
        [self.countSelectedView setProductCountIsNotValidBlock:^{
            if (weakSelf.productStockisNotValidBlock) {
                weakSelf.productStockisNotValidBlock();
            }
        }];
        
        [self.countSelectedView reloadDateInView:self.contentView];
        
        [self.countSelectedView orderCountSelectedError:^(NSString *error) {
            
        }];
        
        [self.countSelectedView orderCountSelectedWithCount:^(NSInteger count) {
            if (self.productBuyCountBlock) {
                self.productBuyCountBlock(count);
            }
        }];
        
    }
    return self;
}

- (void)btnSubClick
{
    if (0 > _counter-1)
    {
        return;
    }
    
    _counter--;
    _tfCount.text = [NSString stringWithFormat:@"%zd", _counter];
    NSString *totlePrice = [NSString stringWithFormat:@"%.2f",_price * _counter];
    
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.minimumLineHeight = 25.0f;
        paragraph_style.maximumLineHeight = 25.0f;
        paragraph_style.alignment = NSTextAlignmentRight;
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:totlePrice attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                                                   NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],
                                                                                                   NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                         NSFontAttributeName:FONT_WITH_SIZE(14.0),
                                                                         NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        _totalPriceLabel.attributedText = content_str;
    }
}

- (void)btnAddClick
{
    if (9999 < _counter+1)
    {
        return;
    }
    
    _counter++;
    _tfCount.text = [NSString stringWithFormat:@"%zd", _counter];
    
    NSString *totlePrice = [NSString stringWithFormat:@"%.2f",_price * _counter];
    
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.minimumLineHeight = 25.0f;
        paragraph_style.maximumLineHeight = 25.0f;
        paragraph_style.alignment = NSTextAlignmentRight;
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:totlePrice attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],
                                                                                                  NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                         NSFontAttributeName:FONT_WITH_SIZE(14.0),
                                                                         NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        _totalPriceLabel.attributedText = content_str;
    }
}

-(void)setTotolPrice:(NSString *)totolPrice {
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.minimumLineHeight = 25.0f;
        paragraph_style.maximumLineHeight = 25.0f;
        paragraph_style.alignment = NSTextAlignmentRight;
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:totolPrice attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                                                   NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],
                                                                                                   NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                         NSFontAttributeName:FONT_WITH_SIZE(14.0),
                                                                         NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        _totalPriceLabel.attributedText = content_str;
    }
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    self.price = [[infoDict objectForKey:@"price"] doubleValue];
    NSString *imageUrl = [infoDict objectForKey:@"thumb"];
    kSetIntenetImageWith(_btnImage, imageUrl);
    
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        
        NSString *productName = [infoDict objectForKey:@"product_name"];
        NSString *productNameValue = productName.description.length > 0 ? productName : @"";
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] initWithString:productNameValue.description
                                                                                        attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                                                     NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                                                     NSParagraphStyleAttributeName:paragraph_style}];
        
        
        _contentLabel.attributedText = content_str;
    }
    
    _tfCount.text = @"1";
    
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.minimumLineHeight = 25.0f;
        paragraph_style.maximumLineHeight = 25.0f;
        paragraph_style.alignment = NSTextAlignmentRight;
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
        
        NSString *price = [infoDict objectForKey:@"price"];
        
        NSString *priceValue = price.description.length > 0 ? price : @"";
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:priceValue.description attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                              NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0],
                                                                              NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                         NSFontAttributeName:FONT_WITH_SIZE(14.0),
                                                                         NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        _totalPriceLabel.attributedText = content_str;
        NSString *sellCount = [infoDict objectForKey:@"quantity"];
        self.sellCountLabel.text = [NSString stringWithFormat:@"库存: %@",sellCount.description];
        self.countSelectedView.stockCount = [sellCount integerValue];
    }
}

@end

#pragma mark - QYSOrderSubmitViewController

@interface QYSOrderSubmitViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *tfPhone;
@property (nonatomic, strong) UITextField *tfContact;
@property (nonatomic, strong) UITextField *tfCarID;

@property (nonatomic, strong)OrderCardSubmitResponse *orderCardSubmitResponse;
@property (nonatomic, strong)NSString *productId;
@property (nonatomic, strong)UIView *footer_v;
@property (nonatomic, strong) NSString *oid;
@property (nonatomic, strong) UILabel *lb_foot;
@property (nonatomic, assign)NSInteger buyNumber;
@property (nonatomic, strong) UINavigationController *myOrderDetailsNavViewController;
@property (nonatomic, strong) NSString *sellCount;
@property (nonatomic, strong) UIButton *btn_submit;

@end

@implementation QYSOrderSubmitViewController

+ (UINavigationController *)navController
{
    QYSOrderSubmitViewController *c = [[QYSOrderSubmitViewController alloc] init];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

+ (UINavigationController *)navControllerWithProductId:(NSString *)productId {
    QYSOrderSubmitViewController *c = [[QYSOrderSubmitViewController alloc] init];
    c.productId = productId;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"提交订单";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack title:@"返回" target:self action:@selector(btnBackClick)];
        self.buyNumber = 1;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    OrderIdManager *orderIdManager = [OrderIdManager sharedOrderIdManager];
    [[OrderCardSubmitService sharedOrderCardSubmitService] submitWithProductId:orderIdManager.orderId login:^{
        
        
        
    } complete:^(OrderCardSubmitResponse *orderCardSubmitResponse) {
        self.orderCardSubmitResponse = orderCardSubmitResponse;
        //        self.productId = response.data
        NSDictionary *product = [orderCardSubmitResponse.data objectForKey:@"product"];
        self.productId = [product objectForKey:@"product_id"];
        
        NSInteger category = [[product objectForKey:@"category"] integerValue];
        self.sellCount = [product objectForKey:@"quantity"];
   
        [self setupFootView:category];
        
        
        NSString *price = [product objectForKey:@"price"];
        
        [self setupTotalPrice:price];
        
        [_tableView reloadData];

    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];

    
    UILabel *lb = (UILabel *)self.navigationItem.titleView;
    lb.font = FONT_WITH_SIZE(21);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = COLOR_MAIN_CLEAR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(17.0, 0, 0, 0);
    [self.view addSubview:_tableView];
    
        //header view
    UIView *header_v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 33)];
    _tableView.tableHeaderView = header_v;
    
    {
        UIImageView *bg = [[UIImageView alloc] initWithImage:nil];
        bg.translatesAutoresizingMaskIntoConstraints = NO;
        bg.backgroundColor = COLOR_MAIN_WHITE;
        [header_v addSubview:bg];
        
        UILabel *lb_field0 = [[UILabel alloc] init];
        lb_field0.translatesAutoresizingMaskIntoConstraints = NO;
        lb_field0.text = @"商品名";
        lb_field0.textColor = COLOR_HEX2RGB(0x686868);
        lb_field0.font = FONT_WITH_SIZE(18);
        [header_v addSubview:lb_field0];
        
        UILabel *lb_field1 = [[UILabel alloc] init];
        lb_field1.translatesAutoresizingMaskIntoConstraints = NO;
        lb_field1.text = @"数量";
        lb_field1.textAlignment = NSTextAlignmentCenter;
        lb_field1.textColor = COLOR_HEX2RGB(0x686868);
        lb_field1.font = FONT_WITH_SIZE(18);
        [header_v addSubview:lb_field1];
        
        UILabel *lb_field2 = [[UILabel alloc] init];
        lb_field2.translatesAutoresizingMaskIntoConstraints = NO;
        lb_field2.text = @"商品总价";
        lb_field2.textAlignment = NSTextAlignmentRight;
        lb_field2.textColor = COLOR_HEX2RGB(0x686868);
        lb_field2.font = FONT_WITH_SIZE(18);
        [header_v addSubview:lb_field2];
        
        NSDictionary *vds0 = NSDictionaryOfVariableBindings(bg,lb_field0,lb_field1,lb_field2);
        [header_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bg]|" options:0 metrics:nil views:vds0]];
        [header_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-19-[lb_field0]-0@999-[lb_field1(150)]-0@999-[lb_field2]-19-|" options:0 metrics:nil views:vds0]];
        [header_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bg]|" options:0 metrics:nil views:vds0]];
        [header_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_field0]|" options:0 metrics:nil views:vds0]];
        [header_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_field1]|" options:0 metrics:nil views:vds0]];
        [header_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_field2]|" options:0 metrics:nil views:vds0]];
        
        [header_v addConstraint:[NSLayoutConstraint constraintWithItem:lb_field1
                                                                     attribute:NSLayoutAttributeCenterX
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:header_v
                                                                     attribute:NSLayoutAttributeCenterX
                                                                    multiplier:1.0
                                                                      constant:0.0]];
    }
        //footer view
    self.footer_v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 209)];
    {
        [self setupFootView:1];
    }
    
        //info bar
    UIView *info_bar = [[UIView alloc] init];
    info_bar.translatesAutoresizingMaskIntoConstraints = NO;
    info_bar.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
    info_bar.layer.borderWidth = 1.0;
    info_bar.backgroundColor = COLOR_MAIN_WHITE;
    [self.view addSubview:info_bar];
    
    {
            //
        self.lb_foot = [[UILabel alloc] init];
        self.lb_foot.translatesAutoresizingMaskIntoConstraints = NO;
        [info_bar addSubview:_lb_foot];
        
        
        [self setupTotalPrice:@"0.00"];
        [info_bar addSubview:_lb_foot];
        
            //
        self.btn_submit = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn_submit.translatesAutoresizingMaskIntoConstraints = NO;
        self.btn_submit.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self.btn_submit setTitle:@"提交订单" forState:UIControlStateNormal];
        [self.btn_submit setTitle:@"无效购买数量" forState:UIControlStateDisabled];
        [self.btn_submit addTarget:self action:@selector(submitOrder:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn_submit setBackgroundImage:[[UIImage imageNamed:@"btn-bg-red2"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [self.btn_submit setBackgroundImage:[[UIImage imageNamed:@"bar-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateDisabled];
        [info_bar addSubview:_btn_submit];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_lb_foot,_btn_submit);
        [info_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-50-[_lb_foot][_btn_submit(190)]-61-|" options:0 metrics:nil views:vds]];
        [info_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_lb_foot]|" options:0 metrics:nil views:vds]];
        [info_bar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btn_submit(40)]" options:0 metrics:nil views:vds]];
        
        [info_bar addConstraint:[NSLayoutConstraint constraintWithItem:_btn_submit
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:info_bar
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                                 constant:0.0]];

    }
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(_tableView,info_bar);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_tableView]-20-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[info_bar]-(-1)-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView][info_bar(71)]-(-1)-|" options:0 metrics:nil views:vds]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardDidHideNotification object:nil];
}


-(void)setupFootView:(NSInteger)category {
    UIImageView *bg = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"main-buy-bg01"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    bg.translatesAutoresizingMaskIntoConstraints = NO;
    [_footer_v addSubview:bg];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main-icon08"]];
    icon.frame = CGRectMake(12, 13, 18, 18);
    //icon.translatesAutoresizingMaskIntoConstraints = NO;
    [_footer_v addSubview:icon];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.translatesAutoresizingMaskIntoConstraints = NO;
    lb.textColor = COLOR_TEXT_BLACK;
    lb.font = FONT_WITH_SIZE(16.0);
    lb.text = @"订单联系人";
    [_footer_v addSubview:lb];
    
    UIButton *btn_contacts = [[UIButton alloc] init];
    btn_contacts.translatesAutoresizingMaskIntoConstraints = NO;
    btn_contacts.titleLabel.font = FONT_WITH_SIZE(16.0);
    btn_contacts.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn_contacts setTitle:@"" forState:UIControlStateNormal];
    [btn_contacts setTitleColor:COLOR_HEX2RGB(0x32a2f9) forState:UIControlStateNormal];
    [btn_contacts addTarget:self action:@selector(btnContactsClick) forControlEvents:UIControlEventTouchUpInside];
    [_footer_v addSubview:btn_contacts];
    
    UIView *line = [[UIView alloc] init];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.backgroundColor = COLOR_MAIN_BORDER_GRAY;
    [_footer_v addSubview:line];
    
    UILabel *lb_phone = [[UILabel alloc] init];
    lb_phone.translatesAutoresizingMaskIntoConstraints = NO;
    lb_phone.textColor = COLOR_HEX2RGB(0xababab);
    lb_phone.font = FONT_WITH_SIZE(18);
    lb_phone.text = @"手机号码";
    [_footer_v addSubview:lb_phone];
    
    UILabel *lb_contact = [[UILabel alloc] init];
    lb_contact.translatesAutoresizingMaskIntoConstraints = NO;
    lb_contact.textColor = COLOR_HEX2RGB(0xababab);
    lb_contact.font = FONT_WITH_SIZE(18);
    lb_contact.text = @"联系人";
    [_footer_v addSubview:lb_contact];
    
    self.tfPhone = [[UITextField alloc] init];
    _tfPhone.translatesAutoresizingMaskIntoConstraints = NO;
    _tfPhone.backgroundColor = COLOR_MAIN_BG_GRAY;
    _tfPhone.placeholder = @"请输入手机号码";
    _tfPhone.keyboardType = UIKeyboardTypeNumberPad;
    _tfPhone.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 0)];
    _tfPhone.leftViewMode = UITextFieldViewModeAlways;
    [_footer_v addSubview:_tfPhone];
    
    //增加监听事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldPhoneChanged:) name:UITextFieldTextDidChangeNotification object:_tfPhone];
    
    self.tfContact = [[UITextField alloc] init];
    _tfContact.translatesAutoresizingMaskIntoConstraints = NO;
    _tfContact.backgroundColor = COLOR_MAIN_BG_GRAY;
    _tfContact.placeholder = @"请输入联系人";
    _tfContact.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 0)];
    _tfContact.leftViewMode = UITextFieldViewModeAlways;
    [_footer_v addSubview:_tfContact];
    //增加监听事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldContactChanged:) name:UITextFieldTextDidChangeNotification object:_tfContact];
    
  
    if (category == 7) {
        
        UILabel *lb_carid = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 71, 36)];
//        lb_carid.translatesAutoresizingMaskIntoConstraints = NO;
        lb_carid.textColor = COLOR_HEX2RGB(0xababab);
        lb_carid.font = FONT_WITH_SIZE(18);
        lb_carid.text = @"身份证";
        [_footer_v addSubview:lb_carid];
        //说明是保险
        self.tfCarID = [[UITextField alloc] initWithFrame:CGRectMake(97, 204, 393, 51)];
//        self.tfCarID.translatesAutoresizingMaskIntoConstraints = NO;
        self.tfCarID.backgroundColor = COLOR_MAIN_BG_GRAY;
        self.tfCarID.placeholder = @"请输入身份证号码";
        self.tfCarID.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 0)];
        self.tfCarID.leftViewMode = UITextFieldViewModeAlways;
        [_footer_v addSubview:self.tfCarID];
        _footer_v.frame = CGRectMake(0, 0, self.view.bounds.size.width, 309);
    }
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(bg,icon,lb,btn_contacts,line,lb_phone,lb_contact,_tfPhone,_tfContact);
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bg]|" options:0 metrics:nil views:vds]];
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[icon(<=30)]-8@999-[lb][btn_contacts(100)]-20-|" options:0 metrics:nil views:vds]];
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line]|" options:0 metrics:nil views:vds]];
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[lb_phone(80)]-[_tfPhone(391)]" options:0 metrics:nil views:vds]];
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[lb_contact(80)]-[_tfContact(391)]" options:0 metrics:nil views:vds]];
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bg]|" options:0 metrics:nil views:vds]];
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-13-[icon(<=30)]" options:0 metrics:nil views:vds]];
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb(44)][line(1)]-15-[lb_phone(50)]-20-[lb_contact(50)]" options:0 metrics:nil views:vds]];
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb(44)][line(1)]-15-[_tfPhone(50)]-20-[_tfContact(50)]" options:0 metrics:nil views:vds]];
    [_footer_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn_contacts(40)]" options:0 metrics:nil views:vds]];
    
     _tableView.tableFooterView = _footer_v;
}

-(void)textFieldPhoneChanged:(id)sender {
    NSString *string = _tfPhone.text;
    if (![NSString isValidateMobile:string]) {
        [self.btn_submit setTitle:@"手机号码不合法" forState:UIControlStateDisabled];
        self.btn_submit.enabled = NO;
        return;
    }
    self.btn_submit.enabled = YES;
}

-(void)textFieldContactChanged:(id)sender {
    NSString *string = _tfContact.text;
    if (string.description.length > 10) {
        [self.btn_submit setTitle:@"联系人长度不能超过10位" forState:UIControlStateDisabled];
        self.btn_submit.enabled = NO;
        return;
    }
    self.btn_submit.enabled = YES;
}

-(void)setupTotalPrice:(NSString *)totalPrice {
    NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.minimumLineHeight = 25.0f;
    paragraph_style.maximumLineHeight = 25.0f;
    
    NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"商品总计（含优惠、运费）：" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                                                     NSFontAttributeName:FONT_WITH_SIZE(18.0),
                                                                                                     NSParagraphStyleAttributeName:paragraph_style}];
    
    [content_str appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:totalPrice attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                          NSFontAttributeName:[UIFont systemFontOfSize:24.0],
                                                                          NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                     NSFontAttributeName:FONT_WITH_SIZE(18.0),
                                                                     NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    self.lb_foot.attributedText = content_str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnContactsClick
{
    //TODO: load data from Phone Contacts Book
    NSLog(@"click contacts");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSOrderSubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"order-item-cell"];
    if (!cell)
    {
        cell = [[QYSOrderSubmitCell alloc] initWithReuseIdentifier:@"order-item-cell"];
    }
    
    NSDictionary *productDict = [_orderCardSubmitResponse.data objectForKey:@"product"];
    NSString *price = [productDict objectForKey:@"price"];
    cell.infoDict = productDict;
    
    __weak QYSOrderSubmitCell *weakSelf = cell;
    [cell setProductBuyCountBlock:^(NSInteger count) {
        self.btn_submit.enabled = YES;
        NSLog(@"购买数量:%zd",count);
        self.buyNumber = count;
        CGFloat perPrice = [price doubleValue];
        NSString *totalString = [NSString stringWithFormat:@"%.2f",perPrice * count];
        weakSelf.totolPrice = totalString;
        [self setupTotalPrice:totalString];
    }];
    
    [cell setProductStockisNotValidBlock:^{
        NSLog(@"购买数量不合法");
        self.btn_submit.enabled = NO;
    }];
    
    
    
    
    
    return cell;
}

#pragma mark -

-(void)submitOrder:(id)sender {
    
    NSString *contactText = _tfContact.text;
    NSString *phonetext = _tfPhone.text;
    NSString *carId = [NSString new];
    if (nil != _tfCarID) {
        carId = _tfCarID.text;
    }
    
    NSDictionary *product = [_orderCardSubmitResponse.data objectForKey:@"product"];
    NSInteger quantity = [[product objectForKey:@"quantity"] integerValue];
    if (_buyNumber > quantity) {
        [JDStatusBarNotification showWithStatus:@"抱歉！您购买的数量超过了当前库存" dismissAfter:1.5f styleName:JDStatusBarStyleError];
        return;
    }
    
    OrderIdManager *orderIdManager = [OrderIdManager sharedOrderIdManager];
    
    [[OrderSubmitService sharedOrderSubmitService] submitOrderWithProductId:orderIdManager.orderId count:[NSString stringWithFormat:@"%zd",_buyNumber] partnerId:nil partnerName:contactText partnerMobile:phonetext iCard:carId complete:^(NSString *payUrl, NSString *oid) {
        
        QYSPayViewController *PayViewController = [[QYSPayViewController alloc] init];
        PayViewController.webUrl = payUrl;
        PayViewController.oid = oid;
        self.oid = oid;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:PayViewController];
        nav.navigationBar.barTintColor = [UIColor redColor];
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:nav animated:YES completion:nil];
        
        [PayViewController setDismissBlock:^(QYSPayViewController *viewController) {
            [viewController dismissViewControllerAnimated:YES completion:^{
              [self.navigationController dismissViewControllerAnimated:YES completion:^{
                  self.myOrderDetailsNavViewController = [QYSMyOrderDetailsViewController navControllerWithOrderId:oid];
                  _myOrderDetailsNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
                  
                  QYSPopupView *pop_view = [[QYSPopupView alloc] init];
                  pop_view.contentView = _myOrderDetailsNavViewController.view;
                  [pop_view show];
              }];
            }];
            
        }];
        
        [PayViewController setFinishBlock:^(QYSPayViewController *viewController) {
        
            [viewController dismissViewControllerAnimated:YES completion:^{
                
                 [self.navigationController dismissViewControllerAnimated:YES completion:^{
                     self.myOrderDetailsNavViewController = [QYSMyOrderDetailsViewController navControllerWithOrderId:oid];
                     _myOrderDetailsNavViewController.view.frame = CGRectMake(0, 0, 400, 768);
                     
                     QYSPopupView *pop_view = [[QYSPopupView alloc] init];
                     pop_view.contentView = _myOrderDetailsNavViewController.view;
                     [pop_view show];
                 }];
            }];
        }];
        
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
    
    
}

#pragma mark -

- (void)onKeyboardShow:(NSNotification *)notify
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 400, 0);
                         [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionNone animated:YES];
                     }];
}

- (void)onKeyboardHide:(NSNotification *)notify
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.tableView.contentInset = UIEdgeInsetsZero;
                     }];
}

@end
