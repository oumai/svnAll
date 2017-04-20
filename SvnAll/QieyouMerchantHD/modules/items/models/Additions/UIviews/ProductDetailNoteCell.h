//
//  ProductNoteCell.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/26.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductMiddleCell.h"

@interface ProductDetailNoteCell : ProductMiddleCell

@property (nonatomic, strong) NSString *note;

+(CGFloat) heightForCellWithNote:(NSString *)note;

@end
