//
//  QYSSplitViewController.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/11.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSSplitViewController : UIViewController

@property (nonatomic, strong) NSArray *menus;
@property (nonatomic, assign) NSInteger selectedMenuIndex;
@property (nonatomic, strong) UIViewController *contentViewController;

- (instancetype)initWithMenus:(NSArray *)menus;

- (void)onSelectedMenuAtIndex:(NSInteger)index;

@end
