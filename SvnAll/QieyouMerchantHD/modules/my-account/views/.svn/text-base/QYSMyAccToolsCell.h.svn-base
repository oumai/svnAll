//
//  QYSMyAccToolsCell.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/3.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSMyAccToolsCell : UITableViewCell

@property (nonatomic, assign) id actDelegate;

@property (nonatomic, assign) NSString *count01;
@property (nonatomic, assign) NSString *count02;
@property (nonatomic, assign) NSString *count03;
@property (nonatomic, assign) NSString *count04;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@protocol QYSMyAccToolsCellDelegate <NSObject>

@optional
- (void)myAccountToolsCellDidSelect:(QYSMyAccToolsCell *)cell index:(NSNumber *)index;

@end
