//
//  ProductBuyNoteCell.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductBuyNoteCell : UITableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, strong) NSString *buyNote;

@property (nonatomic, copy, readwrite) void (^productBuyNoteBlock)(NSString *productBuyNote);

@end
