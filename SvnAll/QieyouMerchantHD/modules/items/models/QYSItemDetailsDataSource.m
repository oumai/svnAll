//
//  QYSItemDetailsDataSource.m
//  QieYouShop
//
//  Created by Vincent on 1/31/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSItemDetailsDataSource.h"
#import "QYSItemCollectionViewCell.h"
#import "QYSItemDetailsViewController.h"
#import "QYSOrderSubmitViewController.h"
#import "SQImagePlayerView.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "QYSLoginViewController.h"
#import "SDPhotoBrowser.h"
#import "OrderIdManager.h"
#import "ProductDetailTitleCell.h"
#import "ProductStoreInfoCell.h"
#import "ProductPhoneCell.h"
#import "ProductDetailNoteCell.h"
#import "ProductDetailNoteImagesCell.h"
#import "ProductDetailBuyNoteCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "StoreIntroductionViewController.h"

#pragma mark - QYSItemDetailsCell

@interface QYSItemDetailsCell : UITableViewCell

@property (nonatomic, assign) id delegateViewController;
@property (nonatomic, assign) NSDictionary *infoDict;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@implementation QYSItemDetailsCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = COLOR_MAIN_WHITE;
        
        self.layer.cornerRadius = 3.0;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end

#pragma mark - QYSItemInfoCell

@interface QYSItemInfoCell : QYSItemDetailsCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *oldPriceLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIView *salesPropertyView;
@property (nonatomic, strong) GoodDerail *goodDetail;
@property (nonatomic, strong) NSString *productId;

@end

@implementation QYSItemInfoCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.layer.cornerRadius = 0.0;
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        _titleLabel.font = FONT_WITH_SIZE(23.0);
        _titleLabel.text = @"";
        [self.contentView addSubview:_titleLabel];
        
        self.subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subTitleLabel.numberOfLines = 2;
        _subTitleLabel.text = @"";
        _subTitleLabel.textColor = COLOR_HEX2RGB(0x686868);
        _subTitleLabel.font = FONT_WITH_SIZE(18.0);
        [self.contentView addSubview:_subTitleLabel];
        
        self.oldPriceLabel = [[UILabel alloc] init];
        _oldPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _oldPriceLabel.text = @"";
        self.oldPriceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_oldPriceLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.text = @"";
        [self.contentView addSubview:_priceLabel];
        
        self.buyButton = [[UIButton alloc] init];
        _buyButton.translatesAutoresizingMaskIntoConstraints = NO;
        _buyButton.titleLabel.font = FONT_WITH_SIZE(17.0);
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyButton setTitle:@"售罄" forState:UIControlStateDisabled];
        [_buyButton setBackgroundImage:[[UIImage imageNamed:@"btn-bg-orange"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        [_buyButton setBackgroundImage:[[UIImage imageNamed:@"bar-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]  forState:UIControlStateHighlighted];
         [_buyButton setBackgroundImage:[[UIImage imageNamed:@"bar-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]  forState:UIControlStateDisabled];
        
        [_buyButton addTarget:self action:@selector(btnBuyClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_buyButton];
        
        UIView *sales_property_view = [[UIView alloc] init];
        sales_property_view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:sales_property_view];
        self.salesPropertyView = sales_property_view;
        
        NSDictionary *dvs = NSDictionaryOfVariableBindings(_titleLabel, _subTitleLabel, _oldPriceLabel, _priceLabel, _buyButton, sales_property_view);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-23-[_titleLabel]-15-[_oldPriceLabel(100)]-0-[_priceLabel(180)]-23-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-23-[_subTitleLabel]-15-[_buyButton(190)]-23-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-23-[sales_property_view]-23-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_titleLabel(>=60)]-0-[_subTitleLabel(>=45)]" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[sales_property_view(20)]-15-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[_oldPriceLabel(40)]-5-[_buyButton(40)]" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[_priceLabel(40)]" options:0 metrics:nil views:dvs]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height-5);
    CGContextAddArcToPoint(ctx, rect.size.width, rect.size.height, rect.size.width-5, rect.size.height, 5);
    CGContextAddLineToPoint(ctx, 5, rect.size.height);
    CGContextAddArcToPoint(ctx, 0, rect.size.height, 0, rect.size.height-5, 5);
    CGContextAddLineToPoint(ctx, 0, 0);
    CGContextClosePath(ctx);
    CGContextClip(ctx);
    
    CGContextSetFillColorWithColor(ctx, COLOR_MAIN_WHITE.CGColor);
    CGContextFillRect(ctx, rect);
    
    CGContextRestoreGState(ctx);
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    _titleLabel.text = @"丽江玉龙雪山超级无敌牛X套票";
    _subTitleLabel.text = @"门票0.5张＋索道车票1＋拍照票2＋饭票2";
    
    //old price
    UIColor *price_color = COLOR_HEX2RGB(0x686868);
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"688元" attributes:@{NSForegroundColorAttributeName:price_color,
                                                                                            NSFontAttributeName:FONT_WITH_SIZE(20.0),
                                                                                            NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                                            NSStrikethroughColorAttributeName:price_color}];
    _oldPriceLabel.attributedText = p;
    
    //price
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
    p = [[NSAttributedString alloc] initWithString:@"230" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:32.0]}];
    [price appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x878787),
                                                                     NSFontAttributeName:FONT_WITH_SIZE(20.0),
                                                                     NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
    [price appendAttributedString:p];
    
    _priceLabel.attributedText = price;
    
    //sales property
    {
        UIColor *b_color = COLOR_RGBA(0.44, 0.71, 0.15, 1.0);
        UIFont *f_font = FONT_WITH_SIZE(12.0);
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.translatesAutoresizingMaskIntoConstraints = NO;
        btn1.userInteractionEnabled = NO;
        [btn1 setImage:[UIImage imageNamed:@"item-icon-support"] forState:UIControlStateNormal];
        [btn1 setTitle:@"支持随时退款" forState:UIControlStateNormal];
        [btn1 iconTheme];
        [btn1 setTitleColor:b_color forState:UIControlStateNormal];
        btn1.titleLabel.font = f_font;
        [_salesPropertyView addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.translatesAutoresizingMaskIntoConstraints = NO;
        btn2.userInteractionEnabled = NO;
        [btn2 setImage:[UIImage imageNamed:@"item-icon-support"] forState:UIControlStateNormal];
        [btn2 setTitle:@"支持过期退款" forState:UIControlStateNormal];
        [btn2 iconTheme];
        [btn2 setTitleColor:b_color forState:UIControlStateNormal];
        btn2.titleLabel.font = f_font;
        [_salesPropertyView addSubview:btn2];
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.translatesAutoresizingMaskIntoConstraints = NO;
        btn3.userInteractionEnabled = NO;
        [btn3 setImage:[UIImage imageNamed:@"item-icon-support"] forState:UIControlStateNormal];
        [btn3 setTitle:@"实物商品线下换货" forState:UIControlStateNormal];
        [btn3 iconTheme];
        [btn3 setTitleColor:b_color forState:UIControlStateNormal];
        btn3.titleLabel.font = f_font;
        [_salesPropertyView addSubview:btn3];
        
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn4.translatesAutoresizingMaskIntoConstraints = NO;
        btn4.userInteractionEnabled = NO;
        [btn4 setImage:[UIImage imageNamed:@"item-icon-support"] forState:UIControlStateNormal];
        [btn4 setTitle:@"商家提供发票" forState:UIControlStateNormal];
        [btn4 iconTheme];
        [btn4 setTitleColor:b_color forState:UIControlStateNormal];
        btn4.titleLabel.font = f_font;
        [_salesPropertyView addSubview:btn4];
        
        NSDictionary *dvs = NSDictionaryOfVariableBindings(btn1,btn2,btn3,btn4);
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[btn1(100)]-20-[btn2(100)]-20-[btn3(150)]-20-[btn4(>=100)]|" options:0 metrics:nil views:dvs]];
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn1]" options:0 metrics:nil views:dvs]];
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn2]" options:0 metrics:nil views:dvs]];
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn3]" options:0 metrics:nil views:dvs]];
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn4]" options:0 metrics:nil views:dvs]];
    }
    
    [self.contentView setNeedsDisplay];
}

-(void)setGoodDetail:(GoodDerail *)goodDetail {
    
    if (nil == goodDetail || [goodDetail.data count] == 0) {
        return;
    }
    self.productId = [goodDetail.data objectForKey:@"product_id"];
    NSString *goodName = [goodDetail.data objectForKey:@"product_name"];
    NSString *subTitle = [goodDetail.data objectForKey:@"content"];
    self.titleLabel.text = goodName.length > 0 ? goodName : @"";
    self.subTitleLabel.text = subTitle.length > 0 ? subTitle : @"";
    
    //处理商品是否已经售罄
    if ([[goodDetail.data objectForKey:@"quantity"] integerValue] == 0) {
        self.buyButton.enabled = NO;
        [self.buyButton setTitle:@"售罄" forState:UIControlStateDisabled];
    }else {
        self.buyButton.enabled = YES;
    }
    
    //处理商品是否已经下架 N表示已经下架
    
    NSString *state = goodDetail.data[@"state"];
    if ([state.description.lowercaseString isEqualToString:@"n"]) {
        self.buyButton.enabled = NO;
        [self.buyButton setTitle:@"已下架" forState:UIControlStateDisabled];
    }
    
    
    NSString *oldPrice = [goodDetail.data objectForKey:@"old_price"];
    NSString *oldPriceValue = oldPrice.length > 0 ? oldPrice : @"0";
    NSString *old_price = [oldPriceValue addString:@"元"];
    
    //old price
    UIColor *price_color = COLOR_HEX2RGB(0x686868);
    NSAttributedString *p = [[NSAttributedString alloc] initWithString:old_price attributes:@{NSForegroundColorAttributeName:price_color,
                                                                                              NSFontAttributeName:FONT_WITH_SIZE(20.0),
                                                                                              NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                                              NSStrikethroughColorAttributeName:price_color}];
    _oldPriceLabel.attributedText = p;
    
    //price
    NSString *priceString = [goodDetail.data objectForKey:@"price"];
    NSString *pirceValue = priceString.length > 0 ? priceString : @"0";
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
    p = [[NSAttributedString alloc] initWithString:pirceValue attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:32.0]}];
    [price appendAttributedString:p];
    
    p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x878787),
                                                                     NSFontAttributeName:FONT_WITH_SIZE(20.0),
                                                                     NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
    [price appendAttributedString:p];
    
    _priceLabel.attributedText = price;
    
    //sales property
    {
        UIColor *b_color = COLOR_RGBA(0.44, 0.71, 0.15, 1.0);
        UIFont *f_font = FONT_WITH_SIZE(12.0);
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.translatesAutoresizingMaskIntoConstraints = NO;
        btn1.userInteractionEnabled = NO;
        [btn1 setImage:[UIImage imageNamed:@"item-icon-support"] forState:UIControlStateNormal];
        [btn1 setTitle:@"支持随时退款" forState:UIControlStateNormal];
        [btn1 iconTheme];
        [btn1 setTitleColor:b_color forState:UIControlStateNormal];
        btn1.titleLabel.font = f_font;
        [_salesPropertyView addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.translatesAutoresizingMaskIntoConstraints = NO;
        btn2.userInteractionEnabled = NO;
        [btn2 setImage:[UIImage imageNamed:@"item-icon-support"] forState:UIControlStateNormal];
        [btn2 setTitle:@"支持过期退款" forState:UIControlStateNormal];
        [btn2 iconTheme];
        [btn2 setTitleColor:b_color forState:UIControlStateNormal];
        btn2.titleLabel.font = f_font;
        [_salesPropertyView addSubview:btn2];
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.translatesAutoresizingMaskIntoConstraints = NO;
        btn3.userInteractionEnabled = NO;
        [btn3 setImage:[UIImage imageNamed:@"item-icon-support"] forState:UIControlStateNormal];
        [btn3 setTitle:@"实物商品线下换货" forState:UIControlStateNormal];
        [btn3 iconTheme];
        [btn3 setTitleColor:b_color forState:UIControlStateNormal];
        btn3.titleLabel.font = f_font;
        [_salesPropertyView addSubview:btn3];
        
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn4.translatesAutoresizingMaskIntoConstraints = NO;
        btn4.userInteractionEnabled = NO;
        [btn4 setImage:[UIImage imageNamed:@"item-icon-support"] forState:UIControlStateNormal];
        [btn4 setTitle:@"商家提供发票" forState:UIControlStateNormal];
        [btn4 iconTheme];
        [btn4 setTitleColor:b_color forState:UIControlStateNormal];
        btn4.titleLabel.font = f_font;
        [_salesPropertyView addSubview:btn4];
        
        NSDictionary *dvs = NSDictionaryOfVariableBindings(btn1,btn2,btn3,btn4);
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[btn1(100)]-20-[btn2(100)]-20-[btn3(150)]-20-[btn4(>=100)]|" options:0 metrics:nil views:dvs]];
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn1]" options:0 metrics:nil views:dvs]];
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn2]" options:0 metrics:nil views:dvs]];
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn3]" options:0 metrics:nil views:dvs]];
        [_salesPropertyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn4]" options:0 metrics:nil views:dvs]];
    }
    
    [self.contentView setNeedsDisplay];
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

- (void)btnBuyClick
{
    
    [self validateLoginComplete:^{
        OrderIdManager *orderIdManagr = [OrderIdManager sharedOrderIdManager];
        orderIdManagr.orderId = _productId;
        UINavigationController *c = [QYSOrderSubmitViewController navControllerWithProductId:_productId];
        [(UIViewController *)(self.delegateViewController) presentViewController:c animated:YES completion:nil];
    } errror:^(NSString *error) {
        
    }];
    
}

@end

#pragma mark - QYSItemDescriptionCell

@interface QYSItemDescriptionCell : QYSItemDetailsCell

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIView *footerExtView;
@property (nonatomic, strong) NSLayoutConstraint *footerViewHeightConstraint;

@end

@implementation QYSItemDescriptionCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = COLOR_MAIN_CLEAR;
        self.contentView.backgroundColor = COLOR_MAIN_CLEAR;
        
        UIView *header_v = [[UIView alloc] init];
        header_v.translatesAutoresizingMaskIntoConstraints = NO;
        header_v.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
        header_v.layer.borderWidth = 1.0;
        [self.contentView addSubview:header_v];
        
        self.headerImageView = [[UIImageView alloc] init];
        _headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _headerImageView.image = [UIImage imageNamed:@"main-icon01"];
        [header_v addSubview:_headerImageView];
        
        self.headerLabel = [[UILabel alloc] init];
        _headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _headerLabel.textColor = COLOR_TEXT_BLACK;
        _headerLabel.font = FONT_WITH_SIZE(18.0);
        _headerLabel.text = @"商品信息";
        [header_v addSubview:_headerLabel];
        
        [header_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-23-[hv(<=30)]-5-[hl(>=70)]|" options:0 metrics:nil views:@{@"hv":_headerImageView,@"hl":_headerLabel}]];
        [header_v addConstraint:[NSLayoutConstraint constraintWithItem:_headerImageView
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:header_v
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                              constant:0.0]];
        
        [header_v addConstraint:[NSLayoutConstraint constraintWithItem:_headerLabel
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:header_v
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                              constant:0.0]];
        
        self.contentLabel = [[UILabel alloc] init];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = COLOR_HEX2RGB(0x686868);
        _contentLabel.text = @"适用范围：全宇宙通用(地球除外)";
        [self.contentView addSubview:_contentLabel];
        
        self.footerView = [[UIView alloc] init];
        _footerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_footerView];
        
        NSDictionary *dvs = NSDictionaryOfVariableBindings(header_v, _contentLabel, _footerView);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[header_v]-(-1)-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-23-[_contentLabel]-23-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-23-[_footerView]-23-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[header_v(55)]-5-[_contentLabel]" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_footerView]-10-|" options:0 metrics:nil views:dvs]];
        
        self.footerViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_footerView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:0.0];
        
        [self.contentView addConstraint:_footerViewHeightConstraint];
        
        //        [self.contentView printColorForConstraints];
    }
    return self;
}

- (void)setFooterExtView:(UIView *)footerExtView
{
    if ([_footerExtView subviews] > 0) {
        for (UIView *subView in [_footerExtView subviews]) {
            [subView removeFromSuperview];
        }
    }
    _footerExtView = footerExtView;
    
    if (!footerExtView)
    {
        _footerViewHeightConstraint.constant = 0.0;
    }
    else
    {
        _footerViewHeightConstraint.constant = footerExtView.bounds.size.height;
        [_footerView addSubview:footerExtView];
    }
    
    [self.contentView setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    CGContextSetFillColorWithColor(ctx, COLOR_MAIN_WHITE.CGColor);
    CGContextFillRect(ctx, rect);
    
    if (_footerExtView)
    {
        CGFloat ps[2] = {2.0,3.0};
        
        CGContextSetStrokeColorWithColor(ctx, COLOR_HEX2RGB(0xe5e5e5).CGColor);
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetLineDash(ctx, 3, ps, 2);
        CGContextMoveToPoint(ctx, 20, _footerView.frame.origin.y);
        CGContextAddLineToPoint(ctx, rect.size.width-20, _footerView.frame.origin.y);
        CGContextStrokePath(ctx);
    }
    
    CGContextRestoreGState(ctx);
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    if (!infoDict)
    {
        return;
    }
    
    NSMutableParagraphStyle *paragraph_style = [[NSMutableParagraphStyle alloc] init];
    paragraph_style.minimumLineHeight = 23.0f;
    paragraph_style.maximumLineHeight = 23.0f;
    
    NSString *content = infoDict[@"content"];
    NSString *contentValue = (![content isKindOfClass:[NSNull class]] && content.description.length > 0)? content : @"暂无";
    
    NSAttributedString *content_str = [[NSAttributedString alloc] initWithString:contentValue.description
                                                                      attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                                   NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                                   NSParagraphStyleAttributeName:paragraph_style}];
    
    _contentLabel.attributedText = content_str;
}

@end

#pragma mark -

@interface QYSItemRecommendCell : QYSItemDetailsCell <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UICollectionView *itemsCollectionView;
@property (nonatomic, strong) GoodDerail *goodDetail;
@property (nonatomic, strong) NSMutableArray *storeOtherGroupPurchases;

@property (nonatomic, strong) void(^otherTuanBlock)(NSString *productId);

@end

@implementation QYSItemRecommendCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        //        self.backgroundColor = COLOR_MAIN_CLEAR;
        //        self.contentView.backgroundColor = COLOR_MAIN_CLEAR;
        
        UIView *header_v = [[UIView alloc] init];
        header_v.translatesAutoresizingMaskIntoConstraints = NO;
        header_v.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
        header_v.layer.borderWidth = 1.0;
        [self.contentView addSubview:header_v];
        
        self.headerImageView = [[UIImageView alloc] init];
        _headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _headerImageView.image = [UIImage imageNamed:@"main-icon01"];
        [header_v addSubview:_headerImageView];
        
        self.headerLabel = [[UILabel alloc] init];
        _headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _headerLabel.textColor = COLOR_TEXT_BLACK;
        _headerLabel.font = FONT_WITH_SIZE(18.0);
        _headerLabel.text = @"商品信息";
        [header_v addSubview:_headerLabel];
        
        [header_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-23-[hv(<=30)]-5-[hl(>=70)]|" options:0 metrics:nil views:@{@"hv":_headerImageView,@"hl":_headerLabel}]];
        [header_v addConstraint:[NSLayoutConstraint constraintWithItem:_headerImageView
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:header_v
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                              constant:0.0]];
        
        [header_v addConstraint:[NSLayoutConstraint constraintWithItem:_headerLabel
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:header_v
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                              constant:0.0]];
        
        UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc] init];
        [flow_layout setItemSize:CGSizeMake(243, 248)];
        [flow_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flow_layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        self.itemsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 60, 600-20, 300) collectionViewLayout:flow_layout];
        _itemsCollectionView.backgroundColor = [UIColor whiteColor];
        [_itemsCollectionView registerClass:[QYSItemCollectionViewCell class] forCellWithReuseIdentifier:@"items-cell"];
        _itemsCollectionView.delegate = self;
        _itemsCollectionView.dataSource = self;
        [self.contentView addSubview:_itemsCollectionView];
        
        NSDictionary *dvs = NSDictionaryOfVariableBindings(header_v, _itemsCollectionView);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[header_v]-(-1)-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[header_v(55)]" options:0 metrics:nil views:dvs]];
    }
    return self;
}

-(void)setGoodDetail:(GoodDerail *)goodDetail {
    NSArray *tuan = [goodDetail.data objectForKey:@"tuan"];
    self.storeOtherGroupPurchases = [tuan mutableCopy];
    [_itemsCollectionView reloadData];
}

#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_storeOtherGroupPurchases count];;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYSItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"items-cell" forIndexPath:indexPath];
    NSDictionary *tuanDict = [_storeOtherGroupPurchases objectAtIndex:indexPath.row];
    cell.infoDict = tuanDict;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [_storeOtherGroupPurchases objectAtIndex:indexPath.row];
    NSString *product_id = [dict objectForKey:@"product_id"];
    if (self.otherTuanBlock) {
        self.otherTuanBlock(product_id);
    }
}

@end

#pragma mark - QYSItemDetailsDataSource

@interface QYSItemDetailsDataSource ()<SQImagePlayerViewDelegate,MWPhotoBrowserDelegate,SDPhotoBrowserDelegate>

@property (nonatomic, strong) SQImagePlayerView *imagePlayerView;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *imageUrls;
@property (nonatomic, strong) GoodDerail *goodDetail;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn_fav;
@property (nonatomic, strong) MWPhotoBrowser *browser;
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, strong) UITableView *detailImagesTable;
@property (nonatomic, strong) NSString *pProductId;
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) NSMutableArray *titleMJPhotos;
@end

@implementation QYSItemDetailsDataSource

-(void)dealloc {
    _imagePlayerView = nil;
    _photos = nil;
    _imageUrls = nil;
    _goodDetail = nil;
    _btn1 = nil;
    _btn2 = nil;
    _btn_fav = nil;
    _browser = nil;
    _detailImagesTable = nil;
}

-(void)setProductId:(NSString *)productId {
    self.isFav = NO;
    self.pProductId = productId;
    self.sectionCount = 5;
    if (nil == productId.description || productId.description.length == 0) {
        return;
    }
    
    [[GoodDetailService sharedGoodDetailService] getGoodDetailWithId:productId complete:^(GoodDerail *good) {
        [self reloadDataWithResponse:good];
    } error:^(NSString *error) {
        
    }];
    
}

-(void) reloadDataWithResponse:(GoodDerail *)goodDetail {
    if (nil != _goodDetail) {
        self.goodDetail = nil;
    }
    self.goodDetail = goodDetail;
    //保存浏览记录仪
    {
        MySpoor *spoor = [[MySpoor alloc] init];
        spoor.goodId = [goodDetail.data objectForKey:@"product_id"];
        spoor.goodName = [goodDetail.data objectForKey:@"inn_name"];
        spoor.price = [goodDetail.data objectForKey:@"price"];
        spoor.oldPrice = [goodDetail.data objectForKey:@"old_price"];
        spoor.time = [NSString stringFromDateFormatterWithyyyyMMddhhmmss:[NSDate date]];
        spoor.sellCount = [goodDetail.data objectForKey:@"bought_count"];
        NSString *gallery = [goodDetail.data objectForKey:@"gallery"];
        if (nil != gallery && gallery.length > 0) {
            
            if (nil == _photos) {
                self.photos = [NSMutableArray new];
            }
            if ([_photos count] > 0) {
                [_photos removeAllObjects];
            }
            
            if ([gallery containsString:@","]) {
                NSArray *gallerys = [gallery componentsSeparatedByString:@","];
                spoor.imageUrl = [gallerys lastObject];
                
                for (NSString *url in gallerys) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@",kImageAPIBaseUrlString,url];
                    [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:urlString]]];
                }
                
            }else {
                spoor.imageUrl = gallery;
                [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:gallery]]];
            }
        }
        [[MySpoorService sharedMySpoorService] saveMySpoot:spoor];
    }
    
    //处理顶部预览图片
    {
        if (nil == _imageUrls) {
            self.imageUrls = [NSMutableArray new];
        }
        
        if ([_imageUrls count] > 0) {
            [_imageUrls removeAllObjects];
        }
        
        NSString *gallery = [goodDetail.data objectForKey:@"gallery"];
        NSArray *imageUrls = [NSString imagesArrayFromString:gallery];
        self.imageUrls = [imageUrls mutableCopy];
         [_imagePlayerView reloadData];
        
        //初始化MJModel
        if (nil == _titleMJPhotos) {
            self.titleMJPhotos = [NSMutableArray new];
        }
        
        if ([_titleMJPhotos count] > 0) {
            [_titleMJPhotos removeAllObjects];
        }
        
        for (NSString *imageUrl in _imageUrls) {
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:kImageUrl(imageUrl)];
            [self.titleMJPhotos addObject:photo];
        }
    }
    
    //处理商品信息
    {
        NSString *bought_count = [_goodDetail.data objectForKey:@"bought_count"];
        NSString *count = bought_count.length > 0 ? bought_count : @"0";
        [self.btn1 setTitle:[@"已售" addString:count] forState:UIControlStateNormal];
        
        long long timeStam = [[_goodDetail.data objectForKey:@"tuan_end_time"] longLongValue];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStam];
        NSString *endTime = [NSString stringWithFormat:@" %@ 结束",[confromTimesp stringWithTimeDifference]];
        [self.btn2 setTitle:endTime forState:UIControlStateNormal];
    }
    
    {
        //处理sectio count，本店是否有团购
        NSArray *tuan = [_goodDetail.data objectForKey:@"tuan"];
        if (nil != tuan && [tuan count] > 0) {
            self.sectionCount = 5;
        }else {
            self.sectionCount = 4;
        }
    }
    
    //处理收藏按钮
    {
        self.isFav = [[_goodDetail.data objectForKey:@"is_fav"] boolValue];
        [self setupFavButtonStyle:_isFav];
        
    }
    
    {
        if (self.changeBuyButtonStateBlock) {
            self.changeBuyButtonStateBlock(![[goodDetail.data objectForKey:@"quantity"] integerValue] == 0);
        }
    }
    
    {
        NSString *state = _goodDetail.data[@"state"];
        if ([state.description.lowercaseString isEqualToString:@"n"]) {
            if (self.changeBuyButtonStateCancelBlock) {
                self.changeBuyButtonStateCancelBlock();
            }
        }
    }
    
    
    {
        [_tableView reloadData];
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
}

- (void)setupTableView
{
    if (nil != _tableView) {
        [_tableView removeFromSuperview];
        _tableView = nil;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = COLOR_MAIN_CLEAR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = COLOR_MAIN_CLEAR;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.layer.cornerRadius = 3.0;
    _tableView.layer.masksToBounds = YES;
    
    UIView *head_v = [[UIView alloc] initWithFrame:CGRectMake(0, -290, 615, 290)];
    _tableView.contentInset = UIEdgeInsetsMake(290, 0, 0, 0);
    _tableView.contentOffset = CGPointMake(0, -290);
    [_tableView addSubview:head_v];
    
    
    self.imagePlayerView = [[SQImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, 615, 290)];
    self.imagePlayerView.pageControlPosition = SQPageControlPosition_BottomCenter;
    [self.imagePlayerView initWithCount:3 delegate:self];
    [head_v addSubview:_imagePlayerView];
    {
        UIImage *im;
        UIGraphicsBeginImageContextWithOptions(_imagePlayerView.bounds.size, NO, 2.0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGColorSpaceRef color_ref = CGColorSpaceCreateDeviceRGB();
        CGFloat locations[2] = {1.0, 0.0};
        CFMutableArrayRef colors_ref = CFArrayCreateMutable(NULL, 2, NULL);
        CFArrayInsertValueAtIndex(colors_ref, 0, COLOR_RGBA(0, 0, 0, 1.0).CGColor);
        CFArrayInsertValueAtIndex(colors_ref, 0, COLOR_RGBA(0, 0, 0, 0.0).CGColor);
        CGGradientRef gradient_ref = CGGradientCreateWithColors(color_ref, colors_ref, locations);
        
        CGContextDrawLinearGradient(ctx, gradient_ref, CGPointMake(0, _imagePlayerView.bounds.size.height), CGPointMake(0, _imagePlayerView.bounds.size.height-_imagePlayerView.bounds.size.height/4), kCGGradientDrawsBeforeStartLocation);
        
        CGGradientRelease(gradient_ref);
        CFRelease(colors_ref);
        CGColorSpaceRelease(color_ref);
        
        im = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *v = [[UIImageView alloc] initWithImage:im];
        [_imagePlayerView addSubview:v];
    }
    
    UIView *head_tool_v = [[UIView alloc] init];
    head_tool_v.translatesAutoresizingMaskIntoConstraints = NO;
    [head_v addSubview:head_tool_v];
    [head_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-23-[v]-23-|" options:0 metrics:nil views:@{@"v":head_tool_v}]];
    [head_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v(30)]-5-|" options:0 metrics:nil views:@{@"v":head_tool_v}]];
    
    {
        UIFont *f_font = FONT_WITH_SIZE(13.0);
        
        self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn1.translatesAutoresizingMaskIntoConstraints = NO;
        self.btn1.userInteractionEnabled = NO;
        [self.btn1 setImage:[UIImage imageNamed:@"main-icon02"] forState:UIControlStateNormal];
        [self.btn1 setTitle:@"已售0" forState:UIControlStateNormal];
        [self.btn1 iconTheme];
        [self.btn1 setTitleColor:COLOR_MAIN_WHITE forState:UIControlStateNormal];
        self.btn1.titleLabel.font = f_font;
        [head_tool_v addSubview:_btn1];
        
        self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn2.translatesAutoresizingMaskIntoConstraints = NO;
        self.btn2.userInteractionEnabled = NO;
        [self.btn2 setImage:[UIImage imageNamed:@"main-icon03"] forState:UIControlStateNormal];
        [self.btn2 setTitle:@" " forState:UIControlStateNormal];
        [self.btn2 iconTheme];
        [self.btn2 setTitleColor:COLOR_MAIN_WHITE forState:UIControlStateNormal];
        self.btn2.titleLabel.font = f_font;
        [head_tool_v addSubview:_btn2];
        
        self.btn_fav = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn_fav.translatesAutoresizingMaskIntoConstraints = NO;
        [self.btn_fav setImage:[UIImage imageNamed:@"main-icon-fav"] forState:UIControlStateNormal];
        [self.btn_fav addTarget:self action:@selector(favoriteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [head_tool_v addSubview:_btn_fav];
        
        UIButton *btn_share = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_share.translatesAutoresizingMaskIntoConstraints = NO;
        [btn_share setImage:[UIImage imageNamed:@"main-icon-share"] forState:UIControlStateNormal];
        [head_tool_v addSubview:btn_share];
        
        NSDictionary *dvs = NSDictionaryOfVariableBindings(_btn1,_btn2,_btn_fav,btn_share);
        [head_tool_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_btn1(>=130)]-10-[_btn2(>=150)]" options:0 metrics:nil views:dvs]];
        [head_tool_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_btn_fav(21)]-30-[btn_share(21)]-10-|" options:0 metrics:nil views:dvs]];
        [head_tool_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btn1]-15-|" options:0 metrics:nil views:dvs]];
        [head_tool_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btn2]-15-|" options:0 metrics:nil views:dvs]];
        [head_tool_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btn_fav]-15-|" options:0 metrics:nil views:dvs]];
        [head_tool_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[btn_share]-15-|" options:0 metrics:nil views:dvs]];
    }
}

-(void)favoriteButtonClicked:(id)sender {
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
                    self.btn_fav.spring.scaleXY = CGPointMake(1.5, 1.5);
                } completion:^(BOOL finished) {
                    [[FavoriteService sharedFavoriteService] favoriteGoodWithGoodId:self.goodDetail.data[@"product_id"] operate:state complete:^(NSString *completeString) {
                        self.btn_fav.spring.scaleXY = CGPointMake(1.0, 1.0);
                        self.isFav = !_isFav;
                        [self setupFavButtonStyle:_isFav];
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
        self.btn_fav.spring.scaleXY = CGPointMake(1.5, 1.5);
    } completion:^(BOOL finished) {
        [[FavoriteService sharedFavoriteService] favoriteGoodWithGoodId:self.goodDetail.data[@"product_id"] operate:state complete:^(NSString *completeString) {
            self.btn_fav.spring.scaleXY = CGPointMake(1.0, 1.0);
            self.isFav = !_isFav;
            [self setupFavButtonStyle:_isFav];
        } error:^(NSString *error) {
            
        }];
        
    }];
}

- (void)unsetupTableView
{
    _tableView = nil;
}

#pragma mark - SQImagePlayerViewDelegate

- (NSInteger)numberOfItems {
    return [_imageUrls count];
}

- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index {
    
    NSString *imageUrl = [_imageUrls objectAtIndex:index];
    kSetIntenetImageWith(imageView, imageUrl);
}

- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index {
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index; // 弹出相册时显示的第一张图片是？
    browser.photos = _titleMJPhotos; // 设置所有的图片
    [browser show];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    if (photoBrowser == _browser) {
        return _photos.count;
    }
    return 0;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (photoBrowser == _browser) {
        if (index < _photos.count)
            return [_photos objectAtIndex:index];
        
    }
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return YES;
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [(UIViewController *)(self.actDelegate) dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate DataSOurce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 || section == 1) {
        return 3;
    }else if (section == 3) {
        return 2;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 14.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 177.0f;
    }else if (1 == indexPath.section) {
        if (indexPath.row == 0) {
            return 55.0f;
        }else if (indexPath.row == 1) {
            return 85.0f;
        }else if (indexPath.row == 2) {
            return 63.0f;
        }
    }else if (2 == indexPath.section) {
        if (indexPath.row == 0) {
            return 55.0f;
        }else if (1 == indexPath.row) {
           return [ProductDetailNoteCell heightForCellWithNote:_goodDetail.data[@"note"]];
        }else if (2 == indexPath.row) {
            NSString *noteImageUrl = _goodDetail.data[@"product_images"];
            NSArray *images = [NSString imagesArrayFromString:noteImageUrl];
            return [ProductDetailNoteImagesCell heightForCellWithImageCount:[images count]];
        }
        return 0.0f;
    }else if (3 == indexPath.section) {
        if (indexPath.row == 0) {
            return 55.0f;
        }else if (1 == indexPath.row) {
            return [ProductDetailBuyNoteCell heightForCellWithNote:_goodDetail.data[@"booking_info"]];
        }
    }else if (4 == indexPath.section) {
        return 360.0f;
    }
  
    return .0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSItemDetailsCell *cell = nil;
    if (0 == indexPath.section) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"item-details-info-cell"];
        if (!cell)
        {
            cell = [[QYSItemInfoCell alloc] initWithReuseIdentifier:@"item-details-info-cell"];
        }
        QYSItemInfoCell *_cell = (QYSItemInfoCell *)cell;
        _cell.goodDetail = _goodDetail;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegateViewController = _actDelegate;
        
        return cell;
    }else if (1 == indexPath.section) {
        if (indexPath.row == 0) {
            ProductDetailTitleCell *cell = [[ProductDetailTitleCell alloc] initWithFrame:CGRectMake(0, 0, 609.0f, 55.0f)];
            cell.title = @"商家信息";
            cell.iconName = @"common_store_info";
            return cell;
        }else if (indexPath.row == 1) {
            ProductStoreInfoCell *cell = [[ProductStoreInfoCell alloc] initWithFrame:CGRectMake(0, 0, 609, 85.0f)];
            cell.storeAddress = _goodDetail.data[@"inn_address"];
            cell.storeName = _goodDetail.data[@"inn_name"];
            
            Location *locationManager =[Location sharedLocationManager];
            if ([locationManager isFinished]) {
                double lati = locationManager.latitude;
                double longi = locationManager.longitude;
                
                double lat = [_goodDetail.data[@"lat"] doubleValue];
                double lon = [_goodDetail.data[@"lon"] doubleValue];
                
                double distance = [Location LantitudeLongitudeDist:lon other_Lat:lat self_Lon:longi self_Lat:lati];
                if (distance > 0) {
                    
                    NSString *dist = [Location distanceToString:distance];
                    NSLog(@"店铺距离:%f,%@",distance,dist);
                    cell.storeDistance = dist;
                }
                
                
            }else {
                cell.storeDistance = @"暂无";
            }
            
            
            return cell;
        }else if (indexPath.row == 2) {
            ProductPhoneCell *cell = [[ProductPhoneCell alloc] initWithFrame:CGRectMake(0, 0, 609, 63)];
            NSMutableArray *tels = [NSMutableArray new];
            NSString *inner_moblie_number = _goodDetail.data[@"inner_moblie_number"];
            if ([inner_moblie_number isValid]) {
                [tels addObject:inner_moblie_number];
            }
            NSString *inner_telephone = _goodDetail.data[@"inner_telephone"];
            if ([inner_telephone isValid]) {
                [tels addObject:inner_telephone];
            }
            
            cell.tels = tels;
            return cell;
        }
    }else if (2 == indexPath.section) {
        if (indexPath.row == 0) {
            ProductDetailTitleCell *cell = [[ProductDetailTitleCell alloc] initWithFrame:CGRectMake(0, 0, 609.0f, 55.0f)];
            cell.title = @"本单详情";
            cell.iconName = @"common_order_detail";
            return cell;
        }else if (indexPath.row == 1) {
            CGFloat height = [ProductDetailNoteCell heightForCellWithNote:_goodDetail.data[@"note"]];
            ProductDetailNoteCell *cell = [[ProductDetailNoteCell alloc] initWithFrame:CGRectMake(0, 0, 609, height)];
            cell.note = _goodDetail.data[@"note"];
            return cell;
        }else if (indexPath.row == 2) {
            NSString *noteImageUrl = _goodDetail.data[@"product_images"];
            NSArray *images = [NSString imagesArrayFromString:noteImageUrl];
            CGFloat height = [ProductDetailNoteImagesCell heightForCellWithImageCount:[images count]];
            ProductDetailNoteImagesCell *cell = [[ProductDetailNoteImagesCell alloc] initWithFrame:CGRectMake(0, 0, 609, height)];
            cell.noteImagesString = _goodDetail.data[@"product_images"];
            
            [cell setProductNoteImagesClikedBlock:^(NSArray *mjPhotos, NSInteger index) {
                MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
                browser.currentPhotoIndex = index; // 弹出相册时显示的第一张图片是？
                browser.photos = mjPhotos; // 设置所有的图片
                [browser show];
            }];
            
            return cell;
        }
    }else if (3 == indexPath.section) {
        if (indexPath.row == 0) {
            ProductDetailTitleCell *cell = [[ProductDetailTitleCell alloc] initWithFrame:CGRectMake(0, 0, 609.0f, 55.0f)];
            cell.title = @"购买须知";
            cell.iconName = @"common_buy_needknow";
            return cell;
        }else if (indexPath.row == 1) {
            CGFloat height = [ProductDetailBuyNoteCell heightForCellWithNote:_goodDetail.data[@"booking_info"]];
            ProductDetailBuyNoteCell *cell = [[ProductDetailBuyNoteCell alloc] initWithFrame:CGRectMake(0, 0, 609, height)];
            cell.buynote = _goodDetail.data[@"booking_info"];
            return cell;
        }
    }else if (4 == indexPath.section) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"item-recommented-cell"];
        if (!cell)
        {
            cell = [[QYSItemRecommendCell alloc] initWithReuseIdentifier:@"item-recommented-cell"];
        }
        
        QYSItemRecommendCell *qcell = (QYSItemRecommendCell *)cell;
        qcell.headerImageView.image = [UIImage imageNamed:@"main-icon06"];
        qcell.headerLabel.text = @"本店其它团购";
        qcell.goodDetail = _goodDetail;
        
        [qcell setOtherTuanBlock:^(NSString *productId) {
            UINavigationController *nc = [QYSItemDetailsViewController navController];
            
            QYSItemDetailsViewController *c = (QYSItemDetailsViewController *)(nc.topViewController);
            c.productId = productId;
            c.title = @"商品详情";
            c.backgroundImage = nil;
            [(UIViewController *)(self.actDelegate) presentViewController:nc animated:NO completion:^{
                [c showBackgroundLayerWithAnimate];
            }];
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegateViewController = _actDelegate;
    }
    
 
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        [(QYSItemDetailsViewController *)_actDelegate hideQuickBar:YES];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        [(QYSItemDetailsViewController *)_actDelegate hideQuickBar:NO];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    if (indexPath.section == 1 && indexPath.row == 1) {
        StoreIntroductionViewController *storeViewController = [[StoreIntroductionViewController alloc] init];
        storeViewController.storeId = _goodDetail.data[@"inn_id"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:storeViewController];
        nav.view.frame = CGRectMake(0, 0, 400, 768);
        QYSPopupView *pop_view = [[QYSPopupView alloc] init];
        pop_view.contentView = nav.view;
        [pop_view show];
    }
     */
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"common_placehoder_image"];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    
    NSString *detail_images = [_goodDetail.data objectForKey:@"detail_images"];
    
    if (nil == detail_images.description || detail_images.description.length == 0 ) {
        return nil;
    }else {
        NSArray *detailImages = [detail_images componentsSeparatedByString:@","];
        if ([detailImages count] == 0) {
            return nil;
        }else {
            NSString *urlString = [detailImages objectAtIndex:index];
            return [NSURL URLWithString:kImageUrl(urlString)];
        }
    }
    
}

#pragma mark - helper

-(void)setupFavButtonStyle:(BOOL)isFav {
    
    if (isFav) {
        [self.btn_fav setImage:[UIImage imageNamed:@"main-icon-fav03-h"] forState:UIControlStateNormal];
        [self.btn_fav setImage:[UIImage imageNamed:@"main-icon-fav03-h"] forState:UIControlStateHighlighted];
    }else {
        [self.btn_fav setImage:[UIImage imageNamed:@"main-icon-fav"] forState:UIControlStateNormal];
        [self.btn_fav setImage:[UIImage imageNamed:@"main-icon-fav"] forState:UIControlStateHighlighted];
    }
   
}

-(CGFloat)labelHeight:(NSString *)note {
    if (nil == note || [note isKindOfClass:[NSNull class]] || note.description.length == 0) {
        return 96.0f;
    }
    UILabel *label = [[UILabel alloc] init];
    label.text = note;
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textColor = [UIColor colorForHexString:@"#686868"];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize constraint = CGSizeMake(300, 20000.0f);
    CGSize size = [note sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height =MAX(size.height, 96.0f);
    return height ;
}

@end