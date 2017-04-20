//
//  QYSItemDetailsViewController.h
//  QieYouShop
//
//  Created by Vincent on 1/30/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSItemDetailsViewController : UIViewController

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) Good *good;
@property (nonatomic, strong) NSString *productId;

+ (UINavigationController *)navController;

- (void)showBackgroundLayerWithAnimate;

- (void)hideQuickBar:(BOOL)hide;

@end
