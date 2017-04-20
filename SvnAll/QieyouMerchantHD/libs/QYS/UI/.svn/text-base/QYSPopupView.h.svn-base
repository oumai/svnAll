//
//  QYSPopupView.h
//  QieYouShop
//
//  Created by Vincent on 2/3/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QYSPopupViewContentAlignLeft = 0,
    QYSPopupViewContentAlignRight,
    QYSPopupViewContentAlignCenter
} QYSPopupViewContentAlign;

@interface QYSPopupView : UIView

@property (nonatomic, assign) QYSPopupViewContentAlign contentAlign;
@property (nonatomic, strong) UIViewController *contentViewController;
@property (nonatomic, assign) UIView *contentView;

+ (void)hideAll:(void(^)())complete;

- (void)show;

- (void)hide:(BOOL)animated complete:(void(^)())complete;

@end
