//
//  SQImagePlayerView.h
//  QieyouMerchant
//
//  Created by 李赛强 on 14/12/8.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SQPageControlPosition) {
    SQPageControlPosition_TopLeft,
    SQPageControlPosition_TopCenter,
    SQPageControlPosition_TopRight,
    SQPageControlPosition_BottomLeft,
    SQPageControlPosition_BottomCenter,
    SQPageControlPosition_BottomRight
};

@protocol SQImagePlayerViewDelegate;

@interface SQImagePlayerView : UIView

@property (nonatomic, assign) id<SQImagePlayerViewDelegate> imagePlayerViewDelegate;
@property (nonatomic, assign) BOOL autoScroll;  //默认 YES
@property (nonatomic, assign) NSUInteger scrollInterval;    //自动滚动时间 默认2秒
@property (nonatomic, assign) SQPageControlPosition pageControlPosition;    // pageControl position, defautl is bottomright
@property (nonatomic, assign) BOOL hidePageControl; // hide pageControl, default is NO
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

- (void)reloadData;

- (void)stopTimer;

#pragma mark - deprecated methods

- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<SQImagePlayerViewDelegate>)delegate;

- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<SQImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets;


- (void)initWithCount:(NSInteger)count delegate:(id<SQImagePlayerViewDelegate>)delegate;

- (void)initWithCount:(NSInteger)count delegate:(id<SQImagePlayerViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets;

@end


#pragma mark - ImagePlayerViewDelegate

@protocol SQImagePlayerViewDelegate <NSObject>

@required
- (NSInteger)numberOfItems;

- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index;

@optional

- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index;

#pragma mark - deprecated protocol methods

- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index imageURL:(NSURL *)imageURL;
@end