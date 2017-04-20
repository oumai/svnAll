//
//  CalendarViewController.h
//  QieYouShop
//
//  Created by 李赛强 on 15/3/18.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@class CalendarViewController;
@protocol CalendarViewControllerDelegate <NSObject>

-(void)calendarViewController:(CalendarViewController *)viewController calendar:(NSDate *)date;
-(void)calendarViewControllerDismiss:(CalendarViewController *)viewController;

@end

@interface CalendarViewController : UIViewController

@property (strong, nonatomic)  JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic)  JTCalendarContentView *calendarContentView;

@property (strong, nonatomic)  NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) JTCalendar *calendar;

@property (nonatomic, assign) id<CalendarViewControllerDelegate> delegate;

@end
