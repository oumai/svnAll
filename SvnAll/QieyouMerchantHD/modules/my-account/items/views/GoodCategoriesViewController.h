//
//  GoodCategoriesViewController.h
//  QieYouShop
//
//  Created by 李赛强 on 15/3/18.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodCategoriesViewController;

@protocol GoodCategoriesViewControllerDelegate <NSObject>

-(void)goodCategoriesViewController:(GoodCategoriesViewController *)viewController
                               cate:(NSString *)cate
                         cateDetail:(NSString *)cateDetail;

-(void)goodCategoriesViewControllerDismiss:(GoodCategoriesViewController *)viewController;

@end

@interface GoodCategoriesViewController : UIViewController

@property (nonatomic, assign) id<GoodCategoriesViewControllerDelegate> delegate;

@end
