//
//  ProductDetailNoteImagesCell.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/26.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductDetailBottomCell.h"

@interface ProductDetailNoteImagesCell : ProductDetailBottomCell

@property (nonatomic, strong) NSString *noteImagesString;

@property (nonatomic, copy, readwrite) void(^productNoteImagesClikedBlock)(NSArray *mjPhotos, NSInteger index);

+(CGFloat) heightForCellWithImageCount:(NSInteger)imageCount;

@end
