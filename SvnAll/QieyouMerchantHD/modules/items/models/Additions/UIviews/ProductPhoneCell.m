//
//  ProductPhoneCell.m
//  QieyouMerchant
//
//  Created by lisaiqiang on 15/3/28.
//  Copyright (c) 2015年 lisaiqiang. All rights reserved.
//

#import "ProductPhoneCell.h"

@interface ProductPhoneCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *telLabel;

@end

@implementation ProductPhoneCell

-(id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, (frame.size.height - 16) / 2, 14, 16)];
        iconImageView.image = [UIImage imageNamed:@"common_icon_call"];
        [self.bgImageView addSubview:iconImageView];
        
        self.telLabel = [UILabel LabelWithFrame:CGRectMake(50, (frame.size.height - 15) / 2, 500, 15.0f) text:@"" textColor:[UIColor colorForHexString:@"#666666"] font:15.0f textAlignment:NSTextAlignmentLeft];
        [self.bgImageView addSubview:_telLabel];
    }
    
    return self;
}

-(void)setTels:(NSArray *)tels {
    if (nil == tels || [tels count] == 0) {
        self.telLabel.text = @"暂无商家联系电话";
        return;
    }
    
    self.telLabel.text = [tels componentsJoinedByString:@" / "];
}

@end
