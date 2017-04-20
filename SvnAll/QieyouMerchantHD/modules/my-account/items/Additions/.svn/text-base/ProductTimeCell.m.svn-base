//
//  ProductTimeCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductTimeCell.h"

@interface ProductTimeCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeContentLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@end


@implementation ProductTimeCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [UILabel LabelWithFrame:CGRectMake(20, 25, 65, 15)
                                             text:@"有效期"
                                        textColor:[UIColor colorForHexString:@"#333333"]
                                             font:15.0f
                                    textAlignment:NSTextAlignmentLeft];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLabel];
        
        self.timeContentLabel = [UILabel LabelWithFrame:CGRectMake(400 - 40 - 200, (60 - 14) / 2, 200, 14)
                                                   text:@"默认(有效期1年)"
                                              textColor:[UIColor colorForHexString:@"#ababab"]
                                                   font:14.0f
                                          textAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_timeContentLabel];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(400 - 31, (60 - 6.5) / 2, 11, 6.5)];
        self.iconImageView.image = [UIImage imageNamed:@"macc-item-add-assory"];
        [self.contentView addSubview:_iconImageView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5f, 400.0f, 0.5f)];
        line.backgroundColor = [UIColor colorForHexString:@"#e2e2e2"];
        [self.contentView addSubview:line];
    }
    return self;
}

-(void) setTimeString:(NSString *)timeString {
    if (nil == timeString || timeString.length == 0) {
        self.timeContentLabel.text = @"默认(有效期1年)";
        return;
    }
    
    self.timeContentLabel.text = timeString;
}

@end
