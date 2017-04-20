//
//  CalendarViewController.m
//  QieYouShop
//
//  Created by 李赛强 on 15/3/18.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()<JTCalendarDataSource>{
    NSMutableDictionary *eventsByDate;
}

@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation CalendarViewController

-(void) loadView {
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f + 40.0f + 30.0f)];
    view.layer.cornerRadius = 4.0f;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor colorForHexString:@"#f7f7f7"];
    
    self.view = view;
    
}

-(void) viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupCalendarMenuView];
    [self setupCalendarContentView];
    [self setupCalendar];
    [self setupGoToToday];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

#pragma mark - UIInit

-(void)setupNavigationBar {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancelButton = [UIButton ButtonItemWithTitle:@"取消" titleNormalColor:[UIColor colorForHexString:@"#33bc60"] titleHighColor:[UIColor grayColor] titleSize:13.0f frame:CGRectMake(8, 10, 30, 20) tag:0 target:self action:@selector(cancelButtonClicked:)];
    [view addSubview:cancelButton];
    
    UILabel *titleLabel = [UILabel LabelWithFrame:CGRectMake((300 - 80)/2, 10, 80, 20) text:@"有效期设置" textColor:[UIColor colorForHexString:@"#33bc60"] font:14.0f textAlignment:NSTextAlignmentCenter];
    [view addSubview:titleLabel];
    
    UIButton *finishButton = [UIButton ButtonItemWithTitle:@"完成" titleNormalColor:[UIColor colorForHexString:@"#33bc60"] titleHighColor:[UIColor grayColor] titleSize:13.0f frame:CGRectMake(300 - 30 -8, 10, 30, 20) tag:0 target:self action:@selector(finishButtonClicked:)];
    [view addSubview:finishButton];
    
    [self.view addSubview:view];
    
}

-(void)setupCalendarMenuView {
    self.calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(10, 40, 280, 50)];
    self.calendarMenuView.scrollEnabled = YES;
    self.calendarMenuView.layer.masksToBounds = YES;
    self.calendarMenuView.opaque = YES;
    [self.view addSubview:_calendarMenuView];
}

-(void)setupCalendarContentView {
    self.calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(10, 90, 280, 250)];
    self.calendarContentView.scrollEnabled = YES;
    self.calendarContentView.layer.masksToBounds = YES;
    self.calendarContentView.opaque = YES;
    [self.view addSubview:_calendarContentView];
}

-(void)setupCalendar {
    self.calendar = [JTCalendar new];
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 2.;
        self.calendar.calendarAppearance.focusSelectedDayChangeMode = YES;
        // self.calendar.calendarAppearance.weekDayTextColor = [UIColor colorForHexString:@"#ff5353"];
        self.calendar.calendarAppearance.menuMonthTextFont = [UIFont systemFontOfSize:12.0f];
        // Customize the text for each month
        self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, JTCalendar *jt_calendar){
            NSCalendar *calendar = jt_calendar.calendarAppearance.calendar;
            NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
            NSInteger currentMonthIndex = comps.month;
            
            static NSDateFormatter *dateFormatter;
            if(!dateFormatter){
                dateFormatter = [NSDateFormatter new];
                dateFormatter.timeZone = jt_calendar.calendarAppearance.calendar.timeZone;
            }
            
            while(currentMonthIndex <= 0){
                currentMonthIndex += 12;
            }
            
            NSString *monthText = [[dateFormatter standaloneMonthSymbols][currentMonthIndex - 1] capitalizedString];
            
            return [NSString stringWithFormat:@"%ld年\n%@", comps.year, monthText];
        };
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    [self createRandomEvents];
}

-(void)setupGoToToday {
    UIButton *goToTodayButton = [UIButton ButtonItemWithTitle:@"回到今天" titleNormalColor:[UIColor colorForHexString:@"#33bc60"] titleHighColor:[UIColor grayColor] titleSize:13.0f frame:CGRectMake((300 - 60)/2, 345, 60, 20) tag:0 target:self action:@selector(goToToday:)];
    [self.view addSubview:goToTodayButton];
}

#pragma mark - Actions

-(void)finishButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarViewController:calendar:)]) {
        [self.delegate calendarViewController:self calendar:_selectedDate];
    }
}

-(void)cancelButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarViewControllerDismiss:)]) {
        [self.delegate calendarViewControllerDismiss:self];
    }
}

-(void)goToToday:(id)sender {
    [self.calendar setCurrentDate:[NSDate date]];
}


#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    
    self.selectedDate = date;
    NSLog(@"Date: %@ - %ld events", date, [events count]);
}

- (void)calendarDidLoadPreviousPage
{
    NSLog(@"Previous page loaded");
}

- (void)calendarDidLoadNextPage
{
    NSLog(@"Next page loaded");
}

#pragma mark - Fake data

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];
    }
}

@end

