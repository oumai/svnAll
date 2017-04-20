//
//  QYSMyItemCollectionViewCell.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/17.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kProductModelKey;
extern NSString * const kProductAddActKey;
extern NSString * const kProductIndexPathRowkey;

@interface QYSMyItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id actDelegate;
@property (nonatomic, strong) MyManagerProductItem *productItem;

@end

@protocol QYSMyItemCollectionViewCellDelegate <NSObject>

- (void)myItemCollectionViewCellClickEditButton:(QYSMyItemCollectionViewCell *)cell button:(UIButton *)button;

@end
