//
//  QYSItemDetailsDataSource.h
//  QieYouShop
//
//  Created by Vincent on 1/31/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYSItemDetailsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id actDelegate;

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, strong) NSString *productId;

@property (nonatomic, strong) void(^changeBuyButtonStateBlock)(BOOL enable);
@property (nonatomic, strong) void(^changeBuyButtonStateCancelBlock)();

- (void)setupTableView;

- (void)unsetupTableView;

@end
