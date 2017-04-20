//
//  ProductTitleImagesCell.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTitleImagesCell : UITableViewCell

@property (nonatomic, strong) NSArray *titleImages;

@property (nonatomic, copy, readwrite) void (^reloadProductTitleImageCell)(BOOL finished, NSInteger index);
@property (nonatomic, copy, readwrite) void (^productTitleImagesBlock)(NSArray *images);
@property (nonatomic, copy, readwrite) void (^productAddBlock)();
@property (nonatomic, copy, readwrite) void (^productImagesClicedBlock)(NSInteger index);

+(CGFloat) heightForCellWithImage:(NSArray *)images;

@end
