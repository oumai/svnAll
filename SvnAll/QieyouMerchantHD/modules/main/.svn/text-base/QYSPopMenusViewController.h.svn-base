//
//  QYSPopMenusViewController.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/23.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSPopMenusViewController : UITableViewController

@property (nonatomic, assign) id actDelegate;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) NSArray *menus;

@property (nonatomic, readonly) UIPopoverController *popverController;

+ (UIPopoverController *)popverController:(id)delegate menus:(NSArray *)menus;

@end

@protocol QYSPopMenusViewControllerDelegate <NSObject>

@optional
- (void)popMenusViewController:(QYSPopMenusViewController *)controller didSelectRowAtIndex:(NSNumber *)index;

@end
