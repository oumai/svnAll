//
//  ProductCateCell.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCateCell : UITableViewCell

@property (nonatomic, strong) NSString *cateContent;

@property (nonatomic, copy, readwrite) void (^productCateBlock)(CategoryTitle *category, CategoryList *categoryList);

@end
