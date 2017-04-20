//
//  ProductBaseInfoCell.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductBaseInfoCell : UITableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, copy, readwrite) void(^productBaseInfoBlock)(NSString *info);

@end
