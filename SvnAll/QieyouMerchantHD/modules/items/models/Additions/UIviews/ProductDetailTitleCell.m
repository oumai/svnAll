//
//  ProductDetailTitleCell.m
//  QieyouMerchant
//
//  Created by lisaiqiang on 15/3/28.
//  Copyright (c) 2015年 lisaiqiang. All rights reserved.
//

#import "ProductDetailTitleCell.h"


#define kLeftMargin 12

@interface ProductDetailTitleCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ProductDetailTitleCell

-(id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:frame];
        bgImageView.image = [[UIImage imageNamed:@"common_cell_title_bg"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        [self.contentView addSubview:bgImageView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5f, frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorForHexString:@"#e5e5e5"];
        [bgImageView addSubview:line];
        
        {
            
            self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, (frame.size.height - 20) / 2, 20, 20)];
            [bgImageView addSubview:_iconImageView];
            
            self.titleLabel = [UILabel LabelWithFrame:CGRectMake(50, (frame.size.height - 18) / 2, 200, 18) text:@"" textColor:[UIColor colorForHexString:@"#333333"] font:18.0f textAlignment:NSTextAlignmentLeft];
            [bgImageView addSubview:_titleLabel];
        }
    }
    return self;
}

-(void)setIconName:(NSString *)iconName {
    self.iconImageView.image = [UIImage imageNamed:iconName];
}

-(void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
