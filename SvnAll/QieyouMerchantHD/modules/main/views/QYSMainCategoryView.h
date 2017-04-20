//
//  QYSMainCategoryView.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/1/28.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -

@interface VCTDragGesture : UIGestureRecognizer

@property (nonatomic, assign) id actDelegate;
@property (nonatomic, assign) BOOL isOpened;
@property (nonatomic, assign) CGRect useableArea;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint currPoint;
@property (nonatomic, readwrite) UIGestureRecognizerState state;

@end

@protocol VCTDragGestureDelegate <NSObject>

@optional
- (void)dragGestureOpenBegan:(VCTDragGesture *)gesture;
- (void)dragGestureOpenMove:(VCTDragGesture *)gesture;
- (void)dragGestureOpenComplete:(VCTDragGesture *)gesture;
- (void)dragGestureOpenEnd:(VCTDragGesture *)gesture;
- (void)dragGestureCloseBegan:(VCTDragGesture *)gesture;
- (void)dragGestureCloseMove:(VCTDragGesture *)gesture;
- (void)dragGestureCloseComplete:(VCTDragGesture *)gesture;
- (void)dragGestureCloseEnd:(VCTDragGesture *)gesture;

@end

#pragma mark -

@interface QYSMainCategoryView : UITableView

@property (nonatomic, assign) id actDelegate;
@property (nonatomic, readonly) NSArray *menus;
@property (nonatomic, strong) NSArray *menusArray;
@property (nonatomic, strong) NSArray *subMenusArray;

@end

@protocol QYSMainCategoryViewDelegate <NSObject>

@optional
- (void)mainCategoryView:(QYSMainCategoryView *)mainCategoryView didSelectRowAtIndex:(NSNumber *)index;
- (void)mainCategoryViewDidClose:(QYSMainCategoryView *)mainCategoryView;
- (void)mainCategoryView:(QYSMainCategoryView *)mainCategoryView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
