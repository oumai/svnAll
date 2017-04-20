//
//  QYSItemCollectionViewCell.h
//  QieYouShop
//
//  Created by Vincent on 1/30/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSDictionary *infoDict;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) BOOL isEditingSelected;

@property (nonatomic, strong) Good *good;

@end
