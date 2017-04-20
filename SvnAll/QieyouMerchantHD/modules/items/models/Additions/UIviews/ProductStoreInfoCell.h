//
//  ProductStoreInfoCell.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/26.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductMiddleCell.h"
@interface ProductStoreInfoCell : ProductMiddleCell

@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeAddress;
@property (nonatomic, strong) NSString *storeDistance;

@end
