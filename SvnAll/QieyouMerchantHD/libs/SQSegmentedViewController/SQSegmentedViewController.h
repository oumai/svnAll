//
//  SQSegmentedViewController.h
//  QieyouMerchant
//
//  Created by 李赛强 on 14-11-26.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQSegmentedViewController;

#pragma mark - DataSource and Delegate Protocols

@protocol SQSegmentedViewControllerDataSource <NSObject>

@required

- (NSInteger)numberOfViewControllers;

- (UIViewController *)SQSegmentedViewController:(SQSegmentedViewController *)segmentedViewController viewControllerAtIndex:(NSInteger)index;

- (NSString *)SQSegmentedViewController:(SQSegmentedViewController *)segmentedViewController segmentedControlTitleForIndex:(NSInteger)index;

@end

@protocol SQSegmentedViewControllerDelegate <NSObject>

@optional

- (void)SQSegmentedViewController:(SQSegmentedViewController *)segmentedViewController didMoveToViewControllerAtIndex:(NSInteger)newIndex;

- (void)SQSegmentedViewController:(SQSegmentedViewController *)segmentedViewController willMoveToViewControllerAtIndex:(NSInteger)newIndex;

@end

#pragma mark - ENUMs

typedef NS_ENUM(NSUInteger, SQSegmentedViewControllerControlPlacement)
{
    SQSegmentedViewControllerControlPlacementNavigationBar,
    SQSegmentedViewControllerControlPlacementToolbar
};

typedef NS_ENUM(NSUInteger, SQSegmentedViewControllerControlType)
{
    SQSegmentedViewControllerControlTypeSegmentedControl,
    SQSegmentedViewControllerControlTypePageControl
};

#pragma mark - Public Interface

@interface SQSegmentedViewController : UIViewController

@property (nonatomic, weak) id <SQSegmentedViewControllerDataSource> dataSource;
@property (nonatomic, weak) id <SQSegmentedViewControllerDelegate> delegate;

@property (nonatomic, strong, readonly) UIPageControl *pageControl;

@property (nonatomic, assign, readonly) NSInteger currentViewControllerIndex;

@property (nonatomic, assign, getter = isSwipeGestureEnabled) BOOL swipeGestureEnabled;

@property (nonatomic, assign) BOOL animatedViewControllerTransitionAnimationEnabled;

@property (nonatomic, assign) NSTimeInterval animatedViewControllerTransitionDuration;

@property (nonatomic, weak) UIViewController *currentViewController;

@property (nonatomic, strong, readonly) UIBarButtonItem *backBarButtonItem;

@property (nonatomic, strong, readonly) UIBarButtonItem *forwardBarButtonItem;

#pragma mark - Instance Methods

- (instancetype)initWithControlPlacement:(SQSegmentedViewControllerControlPlacement)placement;

- (instancetype)initWithControlPlacement:(SQSegmentedViewControllerControlPlacement)placement controlType:(SQSegmentedViewControllerControlType)controlType;

- (void)setCurrentViewControllerIndex:(NSInteger)currentViewControllerIndex animated:(BOOL)animated;

- (void)reload;

@end

#pragma mark - Categories

@interface UIViewController (SQSegmentedViewController)

@property (nonatomic, strong, readonly) SQSegmentedViewController *segmentedViewController;

@end