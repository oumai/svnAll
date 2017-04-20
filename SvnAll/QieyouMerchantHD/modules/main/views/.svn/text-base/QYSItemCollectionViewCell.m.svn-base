//
//  QYSItemCollectionViewCell.m
//  QieYouShop
//
//  Created by Vincent on 1/30/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSItemCollectionViewCell.h"

@interface QYSItemCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *descriptionButton;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *distanceButton;

@property (nonatomic, strong) UIImageView *editingImageView;

@end

@implementation QYSItemCollectionViewCell

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
        
        self.editingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"itm-icon-editing"]];
        _editingImageView.frame = CGRectZero;
        [self.contentView addSubview:_editingImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _editingImageView.frame = CGRectZero;
    
    if (_isEditing)
    {
        _editingImageView.frame = CGRectMake(5, 5, 23, 23);
        
        if (_isEditingSelected)
        {
            _editingImageView.image = [UIImage imageNamed:@"itm-icon-editing-h"];
        }
        else
        {
            _editingImageView.image = [UIImage imageNamed:@"itm-icon-editing"];
        }
    }
    else
    {
        _editingImageView.frame = CGRectZero;
    }
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    
    NSString *goodName = [infoDict objectForKey:@"product_name"];
    _titleLabel.text = goodName.length > 0 ? goodName : @"";
    [_descriptionButton setTitle:@"" forState:UIControlStateNormal];
    
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
    UIColor *price_color = COLOR_RGBA(0.71, 0.71, 0.71, 1.0);
    
    {
        NSString *priceValue = [infoDict objectForKey:@"price"];
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:priceValue.length > 0 ? priceValue : @"0" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                                                                                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:23.0]}];
        [price appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元  " attributes:@{NSForegroundColorAttributeName:price_color,
                                                                           NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                           NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
        [price appendAttributedString:p];
        
        NSString *oldPrice = [infoDict objectForKey:@"old_price"];
        NSString *oldPriceString = oldPrice.length > 0 ? [oldPrice addString:@"元"] : @"0元";
        p = [[NSAttributedString alloc] initWithString:oldPriceString attributes:@{NSForegroundColorAttributeName:price_color,
                                                                                   NSFontAttributeName:FONT_WITH_SIZE(14.0),
                                                                                   NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                                   NSStrikethroughColorAttributeName:price_color}];
        [price appendAttributedString:p];
    }
    
    _priceLabel.attributedText = price;
    
    [_distanceButton setTitle:@"2.6km" forState:UIControlStateNormal];
}

-(void) setGood:(Good *)good {
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:kImageUrl(good.thumb)] placeholderImage:kPlaceholderImage];
    
    self.titleLabel.text = good.product_name;
    [self.descriptionButton setTitle:good.content.length > 0 ? good.content : @"暂无"  forState:UIControlStateNormal];
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
    UIColor *price_color = COLOR_RGBA(0.71, 0.71, 0.71, 1.0);
    
    {
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:good.price.length > 0 ? good.price : @"0" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                                                                                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:23.0]}];
        [price appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元  " attributes:@{NSForegroundColorAttributeName:price_color,
                                                                           NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                           NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
        [price appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:[good.old_price addString:@"元"] attributes:@{NSForegroundColorAttributeName:price_color,
                                                                                                    NSFontAttributeName:FONT_WITH_SIZE(14.0),
                                                                                                    NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                                                                                    NSStrikethroughColorAttributeName:price_color}];
        [price appendAttributedString:p];
    }
    
    self.priceLabel.attributedText = price;
    
    //[_distanceButton setImage:[UIImage imageNamed:@"bought_count"] forState:UIControlStateNormal];
    NSString *boughtCountValue = [@"已售" addString:good.bought_count.description];
    
    [_distanceButton setTitle:boughtCountValue forState:UIControlStateNormal];
}

@end
