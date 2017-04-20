//
//  CityTableViewCell.m
//  QieyouMerchant
//
//  Created by 李赛强 on 15/4/20.
//  Copyright (c) 2015年 lisaiqiang. All rights reserved.
//

#import "CityTableViewCell.h"

@interface CityTableViewCell ()
@property (nonatomic, strong) UILabel *cityNameLabel;
@end

@implementation CityTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cityNameLabel = [UILabel LabelWithFrame:CGRectMake(0, (40 - 12) / 2, 100, 12) text:@"" textColor:[UIColor whiteColor] font:14.0f textAlignment:NSTextAlignmentCenter];
        
        [self.contentView addSubview:_cityNameLabel];
    }
    return self;
}

-(void) setCityName:(NSString *)cityName {
    self.cityNameLabel.text = cityName;
}

@end
