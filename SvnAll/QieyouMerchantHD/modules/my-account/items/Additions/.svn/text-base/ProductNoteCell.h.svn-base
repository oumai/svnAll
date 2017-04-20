//
//  ProductNoteCell.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductNoteCell : UITableViewCell

@property (nonatomic, strong) NSArray *noteImages;
@property (nonatomic, strong) NSString *note;

@property (nonatomic, copy, readwrite) void(^productNoteImagesAddBlock)();
@property (nonatomic, copy, readwrite) void(^productNoteBlock)(NSString *note);
@property (nonatomic, copy, readwrite) void (^reloadProductNoteImageCell)(BOOL finished, NSInteger index);
@property (nonatomic, copy, readwrite) void (^productNoteImagesClickedBlock)(NSInteger index);

+(CGFloat)heightForCellWithImages:(NSArray *)images;

@end
