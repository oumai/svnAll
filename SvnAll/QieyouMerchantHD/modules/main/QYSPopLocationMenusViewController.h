//
//  QYSPopLocationMenusViewController.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/3/7.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSPopLocationMenusViewController : UIViewController

@property (nonatomic, assign) id actDelegate;
@property (nonatomic, readonly) UIPopoverController *popverController;

+ (UIPopoverController *)popverController:(id)delegate data:(NSArray *)data;

@end

@protocol QYSPopLocationMenusViewControllerDelegate <NSObject>

@optional
- (void)popLocationMenusViewController:(QYSPopLocationMenusViewController *)controller didSelectData:(id)data;

@end
