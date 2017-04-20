//
//  ProductMiddleCell.m
//  QieyouMerchant
//
//  Created by lisaiqiang on 15/3/28.
//  Copyright (c) 2015年 lisaiqiang. All rights reserved.
//

#import "ProductMiddleCell.h"

#define kLeftMargin 12

@implementation ProductMiddleCell

-(id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:frame];
        self.bgImageView.image = [[UIImage imageNamed:@"common_cell_middle_bg"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        
        
        
        [self.contentView addSubview:_bgImageView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
