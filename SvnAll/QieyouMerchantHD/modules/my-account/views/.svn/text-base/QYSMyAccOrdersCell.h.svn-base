//
//  QYSMyAccOrdersCell.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/3.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSMyAccOrdersCell : UITableViewCell

@property (nonatomic, assign) NSString *count01;
@property (nonatomic, assign) NSString *count02;
@property (nonatomic, assign) NSString *count03;
@property (nonatomic, assign) NSString *count04;

@property (nonatomic, assign) id actDelegate;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@protocol QYSMyAccOrdersCellDelegate <NSObject>

@optional
- (void)myAccountOrdersCellDidSelectType:(QYSMyAccOrdersCell *)cell index:(NSNumber *)type;

@end
