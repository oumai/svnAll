//
//  ProductTimeViewController.h
//  QieYouShop
//
//  Created by 李赛强 on 15/4/23.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@class CalendarViewController;

@interface ProductTimeViewController : UIViewController

@property (strong, nonatomic)  JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic)  JTCalendarContentView *calendarContentView;
@property (strong, nonatomic)  NSLayoutConstraint *calendarContentViewHeight;
@property (strong, nonatomic) JTCalendar *calendar;

@property (nonatomic, copy, readwrite) void(^dismissBlock)(ProductTimeViewController *viewController);
@property (nonatomic, copy, readwrite) void(^productTimeViewClickedBlock)(ProductTimeViewController *viewController, NSString *time);

@end
