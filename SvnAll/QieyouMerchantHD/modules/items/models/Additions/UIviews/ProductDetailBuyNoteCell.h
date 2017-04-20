//
//  ProductDetailBuyNoteCell.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/27.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductDetailBottomCell.h"

@interface ProductDetailBuyNoteCell : ProductDetailBottomCell

@property (nonatomic, strong) NSString *buynote;

+(CGFloat) heightForCellWithNote:(NSString *)note;

@end
