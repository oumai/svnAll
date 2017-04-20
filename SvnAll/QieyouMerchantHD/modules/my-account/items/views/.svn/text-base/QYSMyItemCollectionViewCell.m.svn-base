//
//  QYSMyItemCollectionViewCell.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/17.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyItemCollectionViewCell.h"

NSString * const kProductModelKey = @"kProductModelKey";
NSString * const kProductAddActKey = @"kProductAddActKey";
NSString * const kProductIndexPathRowkey = @"kProductIndexPathRowkey";

@interface QYSMyItemCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *descriptionButton;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *distanceButton;
//@property (nonatomic, strong) UIView *addView;

@end

@implementation QYSMyItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = COLOR_MAIN_WHITE;
        self.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.0].CGColor;
        self.layer.borderWidth = 0.5;
        
        self.imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.image = [UIImage imageNamed:@"tst-main-item"];
        [self.contentView addSubview:_imageView];
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = FONT_NORMAL;
        _titleLabel.text = @" ";
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:_titleLabel];
        
        self.descriptionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _descriptionButton.translatesAutoresizingMaskIntoConstraints = NO;
        _descriptionButton.userInteractionEnabled = NO;
        //[_descriptionButton setImage:[UIImage imageNamed:@"btn-icon03"] forState:UIControlStateNormal];
        [_descriptionButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_descriptionButton setTitle:@" " forState:UIControlStateNormal];
        [_descriptionButton iconTheme];
        [_descriptionButton setTitleColor:COLOR_TEXT_LIGHT_GRAY forState:UIControlStateNormal];
        _descriptionButton.titleLabel.font = FONT_WITH_SIZE(13.0);
        [self.contentView addSubview:_descriptionButton];
        
        self.priceLabel = [[UILabel alloc] init];
        _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceLabel.text = @" ";
        [self.contentView addSubview:_priceLabel];
        
        self.distanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _distanceButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_distanceButton setImage:[UIImage imageNamed:@"gooddetail_user_icon"] forState:UIControlStateNormal];
        [_distanceButton setTitle:@" " forState:UIControlStateNormal];
        [_distanceButton iconTheme];
        [_distanceButton setTitleColor:COLOR_TEXT_LIGHT_GRAY forState:UIControlStateNormal];
        _distanceButton.titleLabel.font = FONT_WITH_SIZE(13);
        _distanceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.contentView addSubview:_distanceButton];
        
        NSDictionary *dvs = NSDictionaryOfVariableBindings(_imageView, _titleLabel, _descriptionButton, _priceLabel, _distanceButton);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_imageView]|" options:0 metrics:nil views:dvs]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-12-[_titleLabel]-10-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-12-[_descriptionButton]-10-|" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-12-[_priceLabel(<=180)]" options:0 metrics:nil views:dvs]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_distanceButton(>=80)]-10-|" options:0 metrics:nil views:dvs]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView(162)]-8-[_titleLabel(20)]-5-[_descriptionButton(18)]-0-[_priceLabel(28)]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:dvs]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_distanceButton
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:-11.0]];
    }
    return self;
}

- (void)btnEditClick:(UIButton *)sender
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(myItemCollectionViewCellClickEditButton:button:)])
    {
        [_actDelegate performSelector:@selector(myItemCollectionViewCellClickEditButton:button:) withObject:self withObject:sender];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];

}

-(void) setProductItem:(MyManagerProductItem *)productItem {
    if (nil == productItem) {
        return;
    }
    
    self.titleLabel.text = productItem.product_name;
    kSetIntenetImageWith(_imageView, productItem.thumb);
    [_descriptionButton setTitle:productItem.content forState:UIControlStateNormal];
    
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
    UIColor *price_color = COLOR_RGBA(0.71, 0.71, 0.71, 1.0);
    
    {
        NSString *priceString = productItem.price;
        NSString *priceValue = priceString.length > 0 ? priceString.description : @"";
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:priceValue attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff5d5d),
                                                                                                   NSFontAttributeName:[UIFont systemFontOfSize:24.0]}];
        [price appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元  " attributes:@{NSForegroundColorAttributeName:price_color,
                                                                           NSFontAttributeName:FONT_WITH_SIZE(12.0),
                                                                           NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
        [price appendAttributedString:p];
        
        NSString *oldPrice = productItem.old_price;
        NSString *oldPriceValue = oldPrice.description.length > 0 ? [oldPrice.description addString:@"元"] : @"0元";
        
        p = [[NSAttributedString alloc] initWithString:oldPriceValue attributes:@{NSForegroundColorAttributeName:price_color,
                                                                                  NSFontAttributeName:FONT_WITH_SIZE(12.0),
                                                                                  NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                                  NSStrikethroughColorAttributeName:price_color}];
        [price appendAttributedString:p];
    }
    
    _priceLabel.attributedText = price;
    
    NSString *boughtCount = productItem.bought_count;
    [_distanceButton setTitle:[@"已售" addString:boughtCount] forState:UIControlStateNormal];
    
}


-(void) setAddImage:(UIImage *)addImage {
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.frame = CGRectMake(0, 0, 176, 176);
    imageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    imageView.image = addImage;
    [view addSubview:imageView];
    [self.contentView addSubview:view];
}

@end
