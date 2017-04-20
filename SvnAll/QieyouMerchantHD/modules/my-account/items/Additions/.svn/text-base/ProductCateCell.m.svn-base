//
//  ProductCateCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductCateCell.h"

@interface ProductCateCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *cateContentLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation ProductCateCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorForHexString:@"#f0efed"];
        self.contentView.backgroundColor = [UIColor colorForHexString:@"#f0efed"];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 400, 50)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        self.titleLabel = [UILabel LabelWithFrame:CGRectMake(20, 25, 65, 15)
                                             text:@"商品类别"
                                        textColor:[UIColor colorForHexString:@"#333333"]
                                             font:15.0f
                                    textAlignment:NSTextAlignmentLeft];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLabel];
        
        self.cateContentLabel = [UILabel LabelWithFrame:CGRectMake(400 - 40 - 200, (50 - 14) / 2, 200, 14)
                                                   text:@"默认"
                                              textColor:[UIColor colorForHexString:@"#ababab"]
                                                   font:14.0f
                                          textAlignment:NSTextAlignmentRight];
        [bgView addSubview:_cateContentLabel];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(400 - 31, (50 - 6.5) / 2, 11, 6.5)];
        self.iconImageView.image = [UIImage imageNamed:@"macc-item-add-assory"];
        [bgView addSubview:_iconImageView];
    }
    return self;
}

-(void) setCateContent:(NSString *)cateContent {
    self.cateContentLabel.text = cateContent;
}

@end
