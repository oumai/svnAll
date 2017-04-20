//
//  SQSegmentedControl.h
//  QieyouMerchant
//
//  Created by 李赛强 on 14/11/29.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQSegmentedControl : UIControl

@property (nonatomic) BOOL stylesTitleForSelectedSegment;

@property (nonatomic) UIFont *titleFont UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *titleTextColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIFont *selectedTitleFont UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *selectedTitleTextColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *borderColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) CGFloat borderWidth UI_APPEARANCE_SELECTOR;

@property (nonatomic) BOOL drawsGradientBackground;

@property (nonatomic) UIColor *gradientTopColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *gradientBottomColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) CGFloat segmentIndicatorAnimationDuration UI_APPEARANCE_SELECTOR;

@property (nonatomic) CGFloat segmentIndicatorInset UI_APPEARANCE_SELECTOR;

@property (nonatomic) BOOL drawsSegmentIndicatorGradientBackground;

@property (nonatomic) UIColor *segmentIndicatorBackgroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *segmentIndicatorGradientTopColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *segmentIndicatorGradientBottomColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *segmentIndicatorBorderColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) CGFloat segmentIndicatorBorderWidth UI_APPEARANCE_SELECTOR;

@property (nonatomic, readonly) NSUInteger numberOfSegments;

@property (nonatomic) NSUInteger selectedSegmentIndex;

- (instancetype)initWithItems:(NSArray *)items;

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index;

- (void)removeSegmentAtIndex:(NSUInteger)index;

- (void)removeAllSegments;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index;

- (NSString *)titleForSegmentAtIndex:(NSUInteger)index;

- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex animated:(BOOL)animated;

@end
