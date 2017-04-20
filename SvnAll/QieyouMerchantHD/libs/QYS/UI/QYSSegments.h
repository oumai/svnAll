//
//  QYSSegments.h
//  QieYouShop
//
//  Created by Vincent on 2/9/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSSegments : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIColor *tineColor;
@property (nonatomic, assign) NSArray *segments;

@property (nonatomic, strong) void (^SegmentClicked)(NSInteger selectedIndex);
@end
