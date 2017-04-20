//
//  QYSItemDetailsGroupDataSource.h
//  QieYouShop
//
//  Created by Vincent on 1/31/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYSItemDetailsGroupDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) void (^LeftListClickedBlock)(Good *good);

- (void)setupTableView;

- (void)unsetupTableView;

@end
