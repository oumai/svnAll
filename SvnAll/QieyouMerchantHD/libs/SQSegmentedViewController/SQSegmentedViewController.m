//
//  SQSegmentedViewController.m
//  QieyouMerchant
//
//  Created by 李赛强 on 14-11-26.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import "SQSegmentedViewController.h"
#import "SQSegmentedControl.h"

typedef NS_ENUM(NSUInteger, SQSegmentedViewControllerTransitionDirection) {
    SQSegmentedViewControllerTransitionDirectionLeft,
    SQSegmentedViewControllerTransitionDirectionRight
};

@interface SQSegmentedViewController ()
//@property (nonatomic, strong, readwrite) UISegmentedControl *segmentedControl;
@property (nonatomic, strong, readwrite) SQSegmentedControl *sqSegmentControl;
@property (nonatomic, strong, readwrite) UIPageControl *pageControl;
@property (nonatomic, strong, readwrite) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong, readwrite) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, assign) SQSegmentedViewControllerControlPlacement placement;
@property (nonatomic, assign) SQSegmentedViewControllerControlType type;
@property (nonatomic, assign, readwrite) NSInteger currentViewControllerIndex;
@property (nonatomic, assign) NSInteger previousViewControllerIndex;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureRecognizerLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureRecognizerRight;
@end

@implementation SQSegmentedViewController

- (instancetype)initWithControlPlacement:(SQSegmentedViewControllerControlPlacement)placement
{
    return [self initWithControlPlacement:placement controlType:SQSegmentedViewControllerControlTypeSegmentedControl];
}

- (instancetype)initWithControlPlacement:(SQSegmentedViewControllerControlPlacement)placement controlType:(SQSegmentedViewControllerControlType)controlType
{
    if (self = [super init]) {
        _placement = placement;
        _type = controlType;
        _animatedViewControllerTransitionAnimationEnabled = YES;
        _swipeGestureEnabled = NO;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods
{
    return YES;
}

#pragma mark - Public

- (void)setCurrentViewControllerIndex:(NSInteger)currentViewControllerIndex animated:(BOOL)animated
{
    if (_currentViewControllerIndex == currentViewControllerIndex) return;
    if (currentViewControllerIndex >= 0 && currentViewControllerIndex < [self.dataSource numberOfViewControllers]) {
        if (!animated) {
            [UIView setAnimationsEnabled:NO];
        }
        [self.sqSegmentControl setSelectedSegmentIndex:currentViewControllerIndex];
        [self.sqSegmentControl sendActionsForControlEvents:UIControlEventValueChanged];
        [UIView setAnimationsEnabled:YES];
    }
}


- (void)reload
{
    [self.sqSegmentControl removeAllSegments];
    
    NSInteger numberOfViewControllers = [self.dataSource numberOfViewControllers];
    for (NSInteger i = 0; i < numberOfViewControllers; i++) {
        NSString *title = [self.dataSource SQSegmentedViewController:self segmentedControlTitleForIndex:i];
        [self.sqSegmentControl insertSegmentWithTitle:title atIndex:i];
        [self.sqSegmentControl sizeToFit];
        [self.sqSegmentControl setSelectedSegmentIndex:0];
        self.pageControl.numberOfPages++;
        [self.pageControl sizeToFit];
    }
    
    
    switch (self.placement) {
        case SQSegmentedViewControllerControlPlacementNavigationBar:
        {
            self.navigationItem.titleView = (self.type == SQSegmentedViewControllerControlTypeSegmentedControl) ? self.sqSegmentControl : self.pageControl;
            break;
        }
        case SQSegmentedViewControllerControlPlacementToolbar:
        {
            if (_type == SQSegmentedViewControllerControlTypePageControl) {
                self.backBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(handleSwipeGestureRight:)];
                self.forwardBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(handleSwipeGestureLeft:)];
            } else {
                self.backBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                self.forwardBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                
            }
            self.toolbarItems = @[self.backBarButtonItem,
                                  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                  [[UIBarButtonItem alloc] initWithCustomView:(self.type == SQSegmentedViewControllerControlTypeSegmentedControl) ? self.sqSegmentControl : self.pageControl],
                                  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                  self.forwardBarButtonItem];
            break;
        }
        default:
            break;
    }
}

#pragma mark - View Controller Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.placement == SQSegmentedViewControllerControlPlacementToolbar) {
        [self.navigationController setToolbarHidden:NO];
    }
}

#pragma mark - Private

- (void)addViewControllerViewAsViewAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(SQSegmentedViewController:willMoveToViewControllerAtIndex:)]) {
        [self.delegate SQSegmentedViewController:self willMoveToViewControllerAtIndex:index];
    }
    
    UIView *previousSnapShot = [[self.view.subviews firstObject] snapshotViewAfterScreenUpdates:NO];
    [self removePreviousViewController];
    [self.view addSubview:previousSnapShot];
    
    SQSegmentedViewControllerTransitionDirection direction = (self.previousViewControllerIndex < index) ?  SQSegmentedViewControllerTransitionDirectionLeft : SQSegmentedViewControllerTransitionDirectionRight;
    
    UIViewController *viewController = [self.dataSource SQSegmentedViewController:self viewControllerAtIndex:index];
    if (!viewController) {
        [[NSException exceptionWithName:@"View Controller is nil" reason:@"The view controller returned from SQSegmentedViewController:viewControllerAtIndex is nil." userInfo:nil] raise];
        return;
    }
    
    [self addChildViewController:viewController];
    UIView *viewControllerView = viewController.view;
    if (previousSnapShot) viewControllerView.frame = CGRectMake(0, 0, CGRectGetWidth(previousSnapShot.frame), CGRectGetHeight(previousSnapShot.frame));
    CGRect startFrame = CGRectOffset(viewControllerView.frame, (direction == SQSegmentedViewControllerTransitionDirectionLeft) ? CGRectGetWidth(viewControllerView.bounds) : -CGRectGetWidth(viewControllerView.bounds), 0);
    viewControllerView.frame = startFrame;
//    NSLog(@"index:%zd, frame:(%f,%f,%f,%f)",index, startFrame.origin.x, startFrame.origin.y, startFrame.size.width, startFrame.size.height);
    [self.view addSubview:viewControllerView];
    [self addSwipeGestureRecognizersToView:viewControllerView];
    
    [self didMoveToParentViewController:self];
    
    if (!previousSnapShot || !self.animatedViewControllerTransitionAnimationEnabled) {
        [UIView setAnimationsEnabled:NO];
        previousSnapShot = [UIView new];
    }
    
    [self animateViewsControllersForInitialDisplay:@[previousSnapShot, viewControllerView] inDirection:direction withXOffset:CGRectGetWidth(viewControllerView.frame) withCompletionCallback:^{
        [previousSnapShot removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(SQSegmentedViewController:didMoveToViewControllerAtIndex:)]) {
            [self.delegate SQSegmentedViewController:self didMoveToViewControllerAtIndex:index];
        }
    }];
    
    [UIView setAnimationsEnabled:YES];
}

- (void)animateViewsControllersForInitialDisplay:(NSArray *)views inDirection:(SQSegmentedViewControllerTransitionDirection)direction withXOffset:(CGFloat)xOffset withCompletionCallback:(void(^)())callback;
{
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:self.animatedViewControllerTransitionDuration delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGFloat originX = (direction == SQSegmentedViewControllerTransitionDirectionLeft) ? view.frame.origin.x - xOffset : view.frame.origin.x + xOffset;
            view.frame = CGRectMake(originX, view.frame.origin.y, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
        } completion:^(BOOL finished) {
            if (callback) {
                callback();
            }
        }];
    }];
}

- (void)addSwipeGestureRecognizersToView:(UIView *)view
{
    if (self.isSwipeGestureEnabled) {
        [view addGestureRecognizer:_swipeGestureRecognizerLeft];
        [view addGestureRecognizer:_swipeGestureRecognizerRight];
    }
}

- (void)removePreviousViewController
{
    if (self.view.subviews.count == 0) {
        return;
    }
    
    UIViewController *currentViewController = [self.dataSource SQSegmentedViewController:self viewControllerAtIndex:self.currentViewControllerIndex];
    [currentViewController removeFromParentViewController];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self didMoveToParentViewController:self];
}

- (void)bounceViewControllerViewInDirection:(SQSegmentedViewControllerTransitionDirection)direction
{
    UIView *view = [self.view.subviews firstObject];
    CGFloat offset = (direction == SQSegmentedViewControllerTransitionDirectionLeft) ? -25.0 : 25.0;
    
    [UIView animateWithDuration:0.10 delay:0 options:kNilOptions animations:^{
        view.frame = CGRectOffset(view.frame, -offset, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.4 options:kNilOptions animations:^{
            view.frame = CGRectOffset(view.frame, offset, 0);
        } completion:nil];
    }];
}

#pragma mark - Target Action

- (void)handleSwipeGestureRight:(UISwipeGestureRecognizer *)sender
{
    if (_currentViewControllerIndex - 1 != -1) {
        [self.sqSegmentControl setSelectedSegmentIndex:_currentViewControllerIndex - 1 animated:YES];
        [self.sqSegmentControl sendActionsForControlEvents:UIControlEventValueChanged];
    } else {
        [self bounceViewControllerViewInDirection:SQSegmentedViewControllerTransitionDirectionLeft];
    }
}

- (void)handleSwipeGestureLeft:(UISwipeGestureRecognizer *)sender
{
    if (_currentViewControllerIndex + 1 != self.sqSegmentControl.numberOfSegments) {
        [self.sqSegmentControl setSelectedSegmentIndex:_currentViewControllerIndex + 1 animated:YES];
        [self.sqSegmentControl sendActionsForControlEvents:UIControlEventValueChanged];
    } else {
        [self bounceViewControllerViewInDirection:SQSegmentedViewControllerTransitionDirectionRight];
    }
}

- (void)segmentedControlValueChanged:(SQSegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    self.previousViewControllerIndex = _currentViewControllerIndex;
    self.currentViewControllerIndex = index;
}

#pragma mark - Getters


-(SQSegmentedControl *)sqSegmentControl {
    if (!_sqSegmentControl) {
        _sqSegmentControl = [[SQSegmentedControl alloc] initWithFrame:CGRectZero];
        _sqSegmentControl.backgroundColor = [UIColor colorForHexString:@"#33bc60"];
        _sqSegmentControl.segmentIndicatorBackgroundColor = [UIColor colorForHexString:@"#00994a"];
        _sqSegmentControl.titleTextColor = [UIColor colorForHexString:@"#299c54"];
        _sqSegmentControl.selectedTitleTextColor = [UIColor whiteColor];
        _sqSegmentControl.borderColor = [UIColor colorForHexString:@"#00994a"];
        _sqSegmentControl.borderWidth = 1.0f;
        _sqSegmentControl.segmentIndicatorBorderWidth = 0.0f;
        _sqSegmentControl.segmentIndicatorAnimationDuration = 0.3f;
        [_sqSegmentControl sizeToFit];
        [_sqSegmentControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _sqSegmentControl;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    }
    return _pageControl;
}

- (NSTimeInterval)animatedViewControllerTransitionDuration
{
    if (!_animatedViewControllerTransitionDuration) {
        _animatedViewControllerTransitionDuration = 0.6;
    }
    return _animatedViewControllerTransitionDuration;
}

- (UIViewController *)currentViewController
{
    return [self.dataSource SQSegmentedViewController:self viewControllerAtIndex:self.currentViewControllerIndex];
}

#pragma mark - Setters

- (void)setCurrentViewControllerIndex:(NSInteger)currentViewControllerIndex
{
    _currentViewControllerIndex = currentViewControllerIndex;
    [self.sqSegmentControl setSelectedSegmentIndex:_currentViewControllerIndex];
    self.pageControl.currentPage = _currentViewControllerIndex;
    [self addViewControllerViewAsViewAtIndex:_currentViewControllerIndex];
}

- (void)setDataSource:(id<SQSegmentedViewControllerDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reload];
    self.currentViewControllerIndex = 0;
}

- (void)setSwipeGestureEnabled:(BOOL)swipeGestureEnabled
{
    _swipeGestureEnabled = swipeGestureEnabled;
    
    if (_swipeGestureEnabled) {
        _swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestureLeft:)];
        _swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        _swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestureRight:)];
        _swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    } else {
        _swipeGestureRecognizerRight = nil;
        _swipeGestureRecognizerLeft = nil;
    }
}

@end

#pragma mark - Categories

@implementation UIViewController (SQSegmentedViewController)

- (SQSegmentedViewController *)segmentedViewController
{
    return ([self.parentViewController isKindOfClass:[SQSegmentedViewController class]]) ? (SQSegmentedViewController *)self.parentViewController : nil;
}

@end
