//
//  QYSMyOrderDetailsCells.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/14.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyOrderDetailsCells.h"
#import "OrderStatus.h"
#import "QYSPayViewController.h"

#pragma mark -

@implementation QYSMyOrderDetailsCell

+ (CGFloat)heightForCell
{
    return 80.0;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.haveHeaderLine = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    CGContextSetFillColorWithColor(ctx, COLOR_MAIN_WHITE.CGColor);
    CGContextFillRect(ctx, rect);
    
    if (_haveHeaderLine)
    {
        CGFloat ps[2] = {2.0,3.0};
        
        CGContextSetStrokeColorWithColor(ctx, COLOR_MAIN_BORDER_GRAY.CGColor);
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetLineDash(ctx, 3, ps, 2);
        CGContextMoveToPoint(ctx, 20, 1);
        CGContextAddLineToPoint(ctx, rect.size.width-20, 1);
        CGContextStrokePath(ctx);
    }
    
    CGContextRestoreGState(ctx);
}

@end

#pragma mark -

@interface QYSMyOrderDetailsHeaderCell ()

@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *btnImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *orderStateLabel;

@end

@implementation QYSMyOrderDetailsHeaderCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.haveHeaderLine = NO;
        
        self.stateLabel = [[UILabel alloc] init];
        _stateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _stateLabel.layer.cornerRadius = 3.0;
        _stateLabel.layer.masksToBounds = YES;
        _stateLabel.backgroundColor = COLOR_TEXT_RED;
        _stateLabel.textColor = COLOR_MAIN_WHITE;
        _stateLabel.font = FONT_NORMAL_13;
        [self.contentView addSubview:_stateLabel];
        
        self.btnImage = [[UIImageView alloc] init];
        _btnImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_btnImage];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel.textColor = COLOR_TEXT_BLACK;
        _contentLabel.font = FONT_NORMAL;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        
        self.totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _totalPriceLabel.numberOfLines = 0;
        [self.contentView addSubview:_totalPriceLabel];
        
        /*
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mord-icon02"]];
        iv.center = CGPointMake(355, 70);
        [self.contentView addSubview:iv];
         */
        self.stateLabel = [UILabel LabelWithFrame:CGRectMake(0, 0, 38, 15) text:@"已付款" textColor:[UIColor colorForHexString:@"#ff7e00"] font:12.0f textAlignment:NSTextAlignmentRight];
        self.stateLabel.center = CGPointMake(357, 70);
        [self.contentView addSubview:_stateLabel];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_stateLabel,_btnImage,_contentLabel,_totalPriceLabel,_stateLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_btnImage(70)]-10-[_contentLabel][_totalPriceLabel(100)]-20-|" options:0 metrics:nil views:vds]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_stateLabel(<=100)]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_btnImage(70)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_contentLabel]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_totalPriceLabel(50)]-[_stateLabel(20)]" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
//    _stateLabel.text = @" 已付款 ";
    //[_btnImage setImage:[UIImage imageNamed:@"tst-main-item"] forState:UIControlStateNormal];
    
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.lineSpacing = 5.0f;
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] initWithString:@"云南丽江葱花卷大饼"
                                                                                        attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_BLACK,
                                                                                                     NSFontAttributeName:FONT_WITH_SIZE(18.0),
                                                                                                     NSParagraphStyleAttributeName:paragraph_style}];
        
        
        _contentLabel.attributedText = content_str;
    }
    
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.alignment = NSTextAlignmentRight;
//        paragraph_style.lineSpacing = 3.0f;
//        paragraph_style.minimumLineHeight = 16.0f;
//        paragraph_style.maximumLineHeight = 16.0f;
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"28.30" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                                                   NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                                                 NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元\n" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                         NSFontAttributeName:FONT_WITH_SIZE(13.0),
                                                                           NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"× 5" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                           NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                           NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        _totalPriceLabel.attributedText = content_str;
    }
}

-(void) setOrderBaseObject:(OrderBaseObject *)orderBaseObject {
    
    /*
     @property (nonatomic, strong)NSString *product_name;         //商品的名字
     @property (nonatomic, strong)NSString *product_thumb;        //商品缩略图
     @property (nonatomic, strong)NSString *order_type;           //订单类型
     @property (nonatomic, strong)NSString *order_state;          //支付状态
     @property (nonatomic, strong)NSString *product_price;        //商品价格
     @property (nonatomic, strong)NSString *product_quantity;     //商品数量
     @property (nonatomic, strong)NSString *product_category;     //订单类型 7是保险
     */
    
    //[_btnImage setImage:[UIImage imageNamed:@"tst-main-item"] forState:UIControlStateNormal];
    kSetIntenetImageWith(_btnImage, orderBaseObject.product_thumb);
    self.stateLabel.text = [OrderStatus orderStatus:orderBaseObject.order_state];
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.lineSpacing = 5.0f;
        
        NSString *productName = orderBaseObject.product_name;
        NSString *productNameValue = productName.description.length > 0 ? productName.description : @"";
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] initWithString:productNameValue
                                                                                        attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_BLACK,
                                                                                                     NSFontAttributeName:FONT_WITH_SIZE(18.0),
                                                                                                     NSParagraphStyleAttributeName:paragraph_style}];
        
        
        _contentLabel.attributedText = content_str;
    }
    
    {
        NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
        paragraph_style.alignment = NSTextAlignmentRight;
        //        paragraph_style.lineSpacing = 3.0f;
        //        paragraph_style.minimumLineHeight = 16.0f;
        //        paragraph_style.maximumLineHeight = 16.0f;
        
        NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] init];
        
        NSString *productPrice = orderBaseObject.product_price;
        NSString *productPriceValue = productPrice.description.length > 0 ? productPrice.description : @"";
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:productPriceValue attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                                                 NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                                                 NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元\n" attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                           NSFontAttributeName:FONT_WITH_SIZE(13.0),
                                                                           NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        NSString *productCount = orderBaseObject.product_quantity;
        NSString *productCountValue = productCount.description.length > 0 ? productCount.description : @"0";
        
        NSString *productCountFormate = [@"x " addString:productCountValue];
        
        p = [[NSAttributedString alloc] initWithString:productCountFormate attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_GRAY,
                                                                           NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                           NSParagraphStyleAttributeName:paragraph_style}];
        [content_str appendAttributedString:p];
        
        _totalPriceLabel.attributedText = content_str;
    }
}

@end

#pragma mark -

@interface QYSMyOrderDetailsInfoCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QYSMyOrderDetailsInfoCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_titleLabel,_contentLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_titleLabel(90)]-10-[_contentLabel]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLabel]-10-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_contentLabel]-10-|" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.alignment = NSTextAlignmentLeft;
    paragraph_style.lineSpacing = 7.0;
    
    NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] initWithString:@"订单编号\n联系人\n手机\n下单时间"
                                                                                    attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                                                 NSFontAttributeName:FONT_NORMAL,
                                                                                                 NSParagraphStyleAttributeName:paragraph_style}];
    
    
    _titleLabel.attributedText = content_str;
    

    NSMutableParagraphStyle *paragraph_style2 = [[NSMutableParagraphStyle alloc] init];
    paragraph_style2.alignment = NSTextAlignmentRight;
    paragraph_style2.lineSpacing = 7.0;
    content_str = [[NSMutableAttributedString alloc] initWithString:@"20159008\nVincentLi\n18025367969\n2015-02-01"
                                                         attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xababab),
                                                                      NSFontAttributeName:FONT_NORMAL,
                                                                      NSParagraphStyleAttributeName:paragraph_style2}];
    
    _contentLabel.attributedText = content_str;
}

-(void) setOrderLinkManObject:(OrderLinkManObject *)orderLinkManObject {
    NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.alignment = NSTextAlignmentLeft;
    paragraph_style.lineSpacing = 7.0;
    
    NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] initWithString:@"订单编号\n联系人\n手机\n下单时间"
                                                                                    attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                                                 NSFontAttributeName:FONT_NORMAL,
                                                                                                 NSParagraphStyleAttributeName:paragraph_style}];
    
    
    _titleLabel.attributedText = content_str;
    
    
    NSMutableParagraphStyle *paragraph_style2 = [[NSMutableParagraphStyle alloc] init];
    paragraph_style2.alignment = NSTextAlignmentRight;
    paragraph_style2.lineSpacing = 7.0;
    
    /*
     @property (nonatomic, strong)NSString *order_num;            //订单编号
     @property (nonatomic, strong)NSString *order_paytime;        //支付时间
     @property (nonatomic, strong)NSString *order_create_time;    //订单创建时间
     @property (nonatomic, strong)NSString *contact_name;         //联系人
     @property (nonatomic, strong)NSString *contact_telephone;    //联系电话
     @property (nonatomic, assign)BOOL order_cancel_able;
    */
    
    NSMutableArray *orderInfos = [NSMutableArray new];
    
    NSString *orderNum = orderLinkManObject.order_num;
    NSString *orderNumValue = orderNum.description.length > 0 ? orderNum.description : @"";
    [orderInfos addObject:orderNumValue];
    
    NSString *contactName = orderLinkManObject.contact_name;
    NSString *contactNameValue = contactName.description.length > 0 ? contactName.description : @"";
    [orderInfos addObject:contactNameValue];
    
    NSString *contactTel = orderLinkManObject.contact_telephone;
    NSString *contactTelValue = contactTel.description.length > 0 ? contactTel.description : @"";
    [orderInfos addObject:contactTelValue];
    
    NSString *orderPayTime = [NSString stringFromDateSp:[orderLinkManObject.order_create_time longLongValue]];
    NSString *orderPayTimeValue = orderPayTime.description > 0 ? orderPayTime.description : @"";
    [orderInfos addObject:orderPayTimeValue];
    
    if ([orderInfos count] != 4) {
        return;
    }
    
    NSString *stringValue = [orderInfos componentsJoinedByString:@"\n"];
    
    content_str = [[NSMutableAttributedString alloc] initWithString:stringValue
                                                         attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xababab),
                                                                      NSFontAttributeName:FONT_NORMAL,
                                                                      NSParagraphStyleAttributeName:paragraph_style2}];
    
    _contentLabel.attributedText = content_str;
}

- (void)setInfoDict2:(NSDictionary *)infoDict
{
    NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.alignment = NSTextAlignmentLeft;
    paragraph_style.lineSpacing = 7.0;
    
    NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] initWithString:@"订单结算\n"
                                                                                    attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_BLACK,
                                                                                                 NSFontAttributeName:FONT_NORMAL,
                                                                                                 NSParagraphStyleAttributeName:paragraph_style}];
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"订单总额：\n代售佣金：\n平台佣金：\n\n实际收入：\n入账时间："
                                                            attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                         NSFontAttributeName:FONT_NORMAL,
                                                                         NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    _titleLabel.attributedText = content_str;
    
    paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.alignment = NSTextAlignmentRight;
    paragraph_style.lineSpacing = 7.0;
    
    content_str = [[NSMutableAttributedString alloc] initWithString:@"　:\n"
                                                         attributes:@{NSForegroundColorAttributeName:COLOR_MAIN_WHITE,
                                                                      NSFontAttributeName:FONT_NORMAL,
                                                                      NSParagraphStyleAttributeName:paragraph_style}];
    
    p = [[NSAttributedString alloc] initWithString:@"234.00 元\n20.0 元\n21.0 元\n\n30.0 元\n2015-02-01 12:30"
                                                         attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xababab),
                                                                      NSFontAttributeName:FONT_NORMAL,
                                                                      NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    _contentLabel.attributedText = content_str;
}


-(void)setOrderProfitObject:(OrderProfitObject *)orderProfitObject {

    NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.alignment = NSTextAlignmentLeft;
    paragraph_style.lineSpacing = 7.0;
    
    NSMutableAttributedString *content_str = [[NSMutableAttributedString alloc] initWithString:@"订单结算\n"
                                                                                    attributes:@{NSForegroundColorAttributeName:COLOR_TEXT_BLACK,
                                                                                                 NSFontAttributeName:FONT_NORMAL,
                                                                                                 NSParagraphStyleAttributeName:paragraph_style}];
    
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"订单总额：\n代售佣金：\n平台佣金：\n实际收入：\n入账时间："
                                                            attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                         NSFontAttributeName:FONT_NORMAL,
                                                                         NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    _titleLabel.attributedText = content_str;
    
    paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.alignment = NSTextAlignmentRight;
    paragraph_style.lineSpacing = 7.0;
    
    content_str = [[NSMutableAttributedString alloc] initWithString:@"　:\n"
                                                         attributes:@{NSForegroundColorAttributeName:COLOR_MAIN_WHITE,
                                                                      NSFontAttributeName:FONT_NORMAL,
                                                                      NSParagraphStyleAttributeName:paragraph_style}];
    /*
     @property (nonatomic, strong)NSString *order_total;          //订单总额
     @property (nonatomic, strong)NSString *settlement_time;      //结算时间
     @property (nonatomic, strong)NSString *profit;               //当前商户的收益
     @property (nonatomic, strong)NSString *agent_profit;         //代售佣金
     @property (nonatomic, strong)NSString *qieyou_profit;        //平台收益
     */
    NSMutableArray *orderProfits = [NSMutableArray new];
    NSString *orderTotal = orderProfitObject.order_total;
    NSString *orderTotleValue = orderTotal.description.length > 0 ? orderTotal.description : @"0 元";
    [orderProfits addObject:[orderTotleValue addString:@" 元"]];
    
    NSString *agent_profit = orderProfitObject.agent_profit;
    NSString *agent_profit_value = agent_profit.description.length > 0 ? agent_profit.description : @"0 元";
    [orderProfits addObject:[agent_profit_value addString:@" 元"]];
    
    NSString *qieyou_profit = orderProfitObject.qieyou_profit;
    NSString *qieyou_profit_value = qieyou_profit.description.length > 0 ? qieyou_profit.description : @"0 元";
    [orderProfits addObject:[qieyou_profit_value addString:@" 元"]];
    
    NSString *profit = orderProfitObject.profit;
    NSString *profit_value = profit.description.length > 0 ? profit.description : @"0 元";
    [orderProfits addObject:[profit_value addString:@" 元"]];
    
    NSString *settlement_time = orderProfitObject.settlement_time;
    NSString *settlement_time_value = settlement_time.description.length > 0 ? [NSString stringFromDateSp:[settlement_time longLongValue]] : @"";
    [orderProfits addObject:settlement_time_value];
    
    
    if ([orderProfits count] != 5) {
        return;
    }
    
    NSString *stringValue = [orderProfits componentsJoinedByString:@"\n"];
    
    
    p = [[NSAttributedString alloc] initWithString:stringValue
                                        attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xababab),
                                                     NSFontAttributeName:FONT_NORMAL,
                                                     NSParagraphStyleAttributeName:paragraph_style}];
    [content_str appendAttributedString:p];
    
    _contentLabel.attributedText = content_str;
}


@end

#pragma mark - 待消费操作

@interface QYSMyOrderDetailsOperate0Cell ()



@end

@implementation QYSMyOrderDetailsOperate0Cell

+ (CGFloat)heightForCell
{
    return 180.0;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *lb_tips = [[UILabel alloc] init];
        lb_tips.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips.text = @"订单操作";
        lb_tips.font = FONT_NORMAL;
        lb_tips.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:lb_tips];
        
        UILabel *lb_tips0 = [[UILabel alloc] init];
        lb_tips0.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips0.text = @"验证消费券";
        lb_tips0.font = FONT_WITH_SIZE(16.0);
        lb_tips0.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:lb_tips0];
        
        self.tfCode = [[UITextField alloc] init];
        _tfCode.translatesAutoresizingMaskIntoConstraints = NO;
        _tfCode.backgroundColor = COLOR_MAIN_BG_GRAY;
        _tfCode.placeholder = @"请输入客人出示的消费代码";
        _tfCode.layer.cornerRadius = 3.0;
        _tfCode.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
        _tfCode.layer.borderWidth = 0.5;
        _tfCode.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 0)];
        _tfCode.leftViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:_tfCode];
        
        UIButton *btn_submit0 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_submit0.translatesAutoresizingMaskIntoConstraints = NO;
        btn_submit0.titleLabel.font = FONT_NORMAL;
        [btn_submit0 setTitle:@"提交验证" forState:UIControlStateNormal];
        [btn_submit0 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [btn_submit0 addTarget:self action:@selector(submitorderClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn_submit0];
        
        UILabel *lb_tips1 = [[UILabel alloc] init];
        lb_tips1.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips1.text = @"取消订单";
        lb_tips1.font = FONT_WITH_SIZE(16.0);
        lb_tips1.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:lb_tips1];
        
        self.tfReason = [[UITextField alloc] init];
        _tfReason.translatesAutoresizingMaskIntoConstraints = NO;
        _tfReason.backgroundColor = COLOR_MAIN_BG_GRAY;
        _tfReason.placeholder = @"请输入取消原因";
        _tfReason.layer.cornerRadius = 3.0;
        _tfReason.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
        _tfReason.layer.borderWidth = 0.5;
        _tfReason.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 0)];
        _tfReason.leftViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:_tfReason];
        
        UIButton *btn_submit1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_submit1.translatesAutoresizingMaskIntoConstraints = NO;
        btn_submit1.titleLabel.font = FONT_NORMAL;
        [btn_submit1 setTitle:@"取消订单" forState:UIControlStateNormal];
        [btn_submit1 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-orange"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [btn_submit1 addTarget:self action:@selector(cancelOrderCliked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn_submit1];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(lb_tips,lb_tips0,_tfCode,btn_submit0,lb_tips1,_tfReason,btn_submit1);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips0]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_tfCode]-10-[btn_submit0(100)]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips1]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_tfReason]-10-[btn_submit1(100)]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lb_tips(30)][lb_tips0(30)][_tfCode(35)][lb_tips1(30)][_tfReason(35)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lb_tips(30)][lb_tips0(30)][btn_submit0(35)][lb_tips1(30)][btn_submit1(35)]" options:0 metrics:nil views:vds]];
    }
    return self;
}

-(void)submitorderClicked:(UIButton *)button {
    if (self.submitOrderBlock) {
        self.submitOrderBlock();
    }
}

-(void)cancelOrderCliked:(UIButton *)button {
    if (self.cancelOrderBlock) {
        self.cancelOrderBlock();
    }
}

@end

@implementation QYSMyOrderDetailsWatingPayCell

+ (CGFloat)heightForCell
{
    return 180.0;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *lb_tips = [[UILabel alloc] init];
        lb_tips.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips.text = @"订单操作";
        lb_tips.font = FONT_NORMAL;
        lb_tips.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:lb_tips];
        
        UILabel *lb_tips0 = [[UILabel alloc] init];
        lb_tips0.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips0.text = @"";
        lb_tips0.font = FONT_WITH_SIZE(16.0);
        lb_tips0.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:lb_tips0];
        
        self.tfCode = [[UILabel alloc] init];
        _tfCode.translatesAutoresizingMaskIntoConstraints = NO;
        _tfCode.text = @"点击支付按钮继续支付";
        _tfCode.textColor = COLOR_TEXT_GRAY;
        _tfCode.font = FONT_WITH_SIZE(14.0);
        [self.contentView addSubview:_tfCode];
        
        UIButton *btn_submit0 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_submit0.translatesAutoresizingMaskIntoConstraints = NO;
        btn_submit0.titleLabel.font = FONT_NORMAL;
        [btn_submit0 setTitle:@"继续支付" forState:UIControlStateNormal];
        [btn_submit0 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [btn_submit0 addTarget:self action:@selector(submitorderClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn_submit0];
        
        UILabel *lb_tips1 = [[UILabel alloc] init];
        lb_tips1.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips1.text = @"取消订单";
        lb_tips1.font = FONT_WITH_SIZE(16.0);
        lb_tips1.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:lb_tips1];
        
        self.tfReason = [[UITextField alloc] init];
        _tfReason.translatesAutoresizingMaskIntoConstraints = NO;
        _tfReason.backgroundColor = COLOR_MAIN_BG_GRAY;
        _tfReason.placeholder = @"请输入取消原因";
        _tfReason.layer.cornerRadius = 3.0;
        _tfReason.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
        _tfReason.layer.borderWidth = 0.5;
        _tfReason.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 0)];
        _tfReason.leftViewMode = UITextFieldViewModeAlways;
        [self.contentView addSubview:_tfReason];
        
        UIButton *btn_submit1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_submit1.translatesAutoresizingMaskIntoConstraints = NO;
        btn_submit1.titleLabel.font = FONT_NORMAL;
        [btn_submit1 setTitle:@"取消订单" forState:UIControlStateNormal];
        [btn_submit1 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-orange"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [btn_submit1 addTarget:self action:@selector(cancelOrderCliked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn_submit1];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(lb_tips,lb_tips0,_tfCode,btn_submit0,lb_tips1,_tfReason,btn_submit1);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips0]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_tfCode]-10-[btn_submit0(100)]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips1]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_tfReason]-10-[btn_submit1(100)]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lb_tips(30)][lb_tips0(30)][_tfCode(35)][lb_tips1(30)][_tfReason(35)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lb_tips(30)][lb_tips0(30)][btn_submit0(35)][lb_tips1(30)][btn_submit1(35)]" options:0 metrics:nil views:vds]];
    }
    return self;
}

-(void)submitorderClicked:(UIButton *)button {
    if (self.submitOrderBlock) {
        self.submitOrderBlock();
    }
}

-(void)cancelOrderCliked:(UIButton *)button {
    if (self.cancelOrderBlock) {
        self.cancelOrderBlock();
    }
}

@end



#pragma mark - 待消费操作

@interface QYSMyOrderDetailsOperate1Cell ()



@end

@implementation QYSMyOrderDetailsOperate1Cell

+ (CGFloat)heightForCell
{
    return 90.0;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *lb_tips = [[UILabel alloc] init];
        lb_tips.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips.text = @"订单操作";
        lb_tips.font = FONT_NORMAL;
        lb_tips.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:lb_tips];
        
        self.tfReason = [[UITextField alloc] init];
        _tfReason.translatesAutoresizingMaskIntoConstraints = NO;
        _tfReason.backgroundColor = COLOR_MAIN_BG_GRAY;
        _tfReason.placeholder = @"请输入取消原因";
        _tfReason.layer.cornerRadius = 3.0;
        _tfReason.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
        _tfReason.layer.borderWidth = 0.5;
        [self.contentView addSubview:_tfReason];
        
        UIButton *btn_submit1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_submit1.translatesAutoresizingMaskIntoConstraints = NO;
        btn_submit1.titleLabel.font = FONT_NORMAL;
        [btn_submit1 setTitle:@"取消订单" forState:UIControlStateNormal];
        [btn_submit1 addTarget:self action:@selector(cancelOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn_submit1 setBackgroundImage:[[UIImage imageNamed:@"btn-bg-orange"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [self.contentView addSubview:btn_submit1];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(lb_tips,_tfReason,btn_submit1);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_tfReason]-10-[btn_submit1(100)]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lb_tips(30)][_tfReason(35)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lb_tips(30)][btn_submit1(35)]" options:0 metrics:nil views:vds]];
    }
    return self;
}

-(void)cancelOrderClicked:(UIButton *)button {
    if (self.cancelOrderBlock) {
        self.cancelOrderBlock();
    }
}

@end

#pragma mark - 已完成

@interface QYSMyOrderDetailsOperate2Cell ()

@property (nonatomic, strong) UITextField *tfReason;
@property (nonatomic, strong) UILabel *lb_code;
@property (nonatomic, strong) UILabel *lb_date;
@end

@implementation QYSMyOrderDetailsOperate2Cell

+ (CGFloat)heightForCell
{
    return 160.0;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *lb_tips = [[UILabel alloc] init];
        lb_tips.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips.text = @"订单操作";
        lb_tips.font = FONT_NORMAL;
        lb_tips.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:lb_tips];
        
        UILabel *lb_tips0 = [[UILabel alloc] init];
        lb_tips0.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips0.text = @"验证消费券";
        lb_tips0.font = FONT_WITH_SIZE(16.0);
        lb_tips0.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:lb_tips0];
        
        UIView *box = [[UIView alloc] init];
        box.translatesAutoresizingMaskIntoConstraints = NO;
        box.backgroundColor = COLOR_HEX2RGB(0xf0efed);
        box.layer.borderColor = COLOR_HEX2RGB(0xdcdcdc).CGColor;
        box.layer.borderWidth = 0.5;
        [self.contentView addSubview:box];
        
        UILabel *lb_tips1 = [[UILabel alloc] init];
        lb_tips1.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips1.text = @"消费代码：";
        lb_tips1.font = FONT_NORMAL_14;
        lb_tips1.textColor = COLOR_HEX2RGB(0x4f4f4f);
        [box addSubview:lb_tips1];
        
        self.lb_code = [[UILabel alloc] init];
        self.lb_code.translatesAutoresizingMaskIntoConstraints = NO;
        self.lb_code.text = @"  2015000879  ";
        self.lb_code.font = FONT_NORMAL_14;
        self.lb_code.textColor = COLOR_HEX2RGB(0x737373);
        self.lb_code.backgroundColor = COLOR_HEX2RGB(0xdcdcdc);
        self.lb_code.layer.cornerRadius = 4.0;
        self.lb_code.layer.masksToBounds = YES;
        [box addSubview:_lb_code];
        
        UIView *line = [[UIView alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = COLOR_HEX2RGB(0xdcdcdc);
        [box addSubview:line];
        
        UILabel *lb_tips2 = [[UILabel alloc] init];
        lb_tips2.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips2.text = @"已消费";
        lb_tips2.font = FONT_NORMAL_14;
        lb_tips2.textColor = COLOR_HEX2RGB(0xababab);
        [box addSubview:lb_tips2];
        
        self.lb_date = [[UILabel alloc] init];
        self.lb_date.translatesAutoresizingMaskIntoConstraints = NO;
        self.lb_date.text = @"2015-02-12";
        self.lb_date.font = FONT_NORMAL_14;
        self.lb_date.textColor = COLOR_HEX2RGB(0xababab);
        [box addSubview:_lb_date];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(lb_tips,lb_tips0,box,lb_tips1,_lb_code,line,lb_tips2,_lb_date);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips0]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[box]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lb_tips(30)][lb_tips0(30)][box]-10-|" options:0 metrics:nil views:vds]];
        
        [box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-11-[lb_tips1]-[line(0.5)]-11-[lb_tips2]-|" options:0 metrics:nil views:vds]];
        [box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-18-[_lb_code]" options:0 metrics:nil views:vds]];
        [box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[line(0.5)]-11-[_lb_date]-|" options:0 metrics:nil views:vds]];
        [box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[line]|" options:0 metrics:nil views:vds]];
        [box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[lb_tips1(25)]-[_lb_code(23)]" options:0 metrics:nil views:vds]];
        [box addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[lb_tips2(25)]-[_lb_date(23)]" options:0 metrics:nil views:vds]];
        
        [box addConstraint:[NSLayoutConstraint constraintWithItem:line
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:box
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0.0]];
    }
    return self;
}

-(void)setOrderCoupons:(NSArray *)orderCoupons {
    if (orderCoupons ==  0) {
        return;
    }
    
    for (int i = 0; i < [orderCoupons count]; i ++) {
        NSDictionary *dict = [orderCoupons objectAtIndex:i];
        NSString *code = [dict objectForKey:@"code"];
        self.lb_code.text = code;
        
        NSString *time = [dict objectForKey:@"time"];
        NSString *formatterTime = [NSString stringFromDateFormatterWithyyyyMMdd:[time longLongValue]];
        self.lb_date.text = formatterTime;
    }
}

@end

#pragma mark - 处理中

@interface QYSMyOrderDetailsOperate3Cell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QYSMyOrderDetailsOperate3Cell

+ (CGFloat)heightForCell
{
    return 80.0;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *lb_tips = [[UILabel alloc] init];
        lb_tips.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips.text = @"订单操作";
        lb_tips.font = FONT_NORMAL;
        lb_tips.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:lb_tips];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel.text = @"正在处理中...";
        _contentLabel.font = FONT_NORMAL;
        _contentLabel.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:_contentLabel];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(lb_tips,_contentLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_tips]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_contentLabel]-20-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lb_tips(25)][_contentLabel]-10-|" options:0 metrics:nil views:vds]];
    }
    return self;
}

-(void)setNote:(NSString *)note {
    self.contentLabel.text = note;
}

@end
