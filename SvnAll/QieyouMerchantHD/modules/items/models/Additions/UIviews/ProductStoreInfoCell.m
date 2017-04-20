//
//  ProductStoreInfoCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/26.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductStoreInfoCell.h"

@interface ProductStoreInfoCell ()
@property (nonatomic, strong) UILabel *storeNameLabel;
@property (nonatomic, strong) UILabel *storeAddressLabel;
@property (nonatomic, strong) UIButton *storeDistanceButton;
@end

@implementation ProductStoreInfoCell

-(id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        self.storeNameLabel = [UILabel LabelWithFrame:CGRectMake(24.0f, 22, 460, 15.0f) text:@"" textColor:[UIColor colorForHexString:@"#727272"] font:15.0f textAlignment:NSTextAlignmentLeft];
        
        [self.bgImageView addSubview:_storeNameLabel];
        
        self.storeAddressLabel = [UILabel LabelWithFrame:CGRectMake(24.0f, 50, 460, 15.0f) text:@"" textColor:[UIColor colorForHexString:@"#ababab"] font:14.0f textAlignment:NSTextAlignmentLeft];
        [self.bgImageView addSubview:_storeAddressLabel];
        
        self.storeDistanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.storeDistanceButton.frame = CGRectMake(frame.size.width - 100 - 23, 52, 100, 13);
        [self.storeDistanceButton setImage:[UIImage imageNamed:@"common_icon_address"] forState:UIControlStateNormal];
        [self.storeDistanceButton setTitle:@"" forState:UIControlStateNormal];
        [self.storeDistanceButton iconTheme];
        [self.storeDistanceButton setTitleColor:[UIColor colorForHexString:@"#999999"] forState:UIControlStateNormal];
        self.storeDistanceButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.bgImageView addSubview:_storeDistanceButton];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5f, frame.size.width, 0.5f)];
        line.backgroundColor = [UIColor colorForHexString:@"#e5e5e5"];
        [self.bgImageView addSubview:line];
    }
    
    return self;
}

-(void)setStoreName:(NSString *)storeName {
    self.storeNameLabel.text = storeName;
}

-(void)setStoreAddress:(NSString *)storeAddress {
    self.storeAddressLabel.text = storeAddress;
}

-(void) setStoreDistance:(NSString *)storeDistance {
    [self.storeDistanceButton setTitle:storeDistance forState:UIControlStateNormal];
}

@end
