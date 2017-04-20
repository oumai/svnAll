//
//  UIHelper.m
//  QieYouShop
//
//  Created by 李赛强 on 15/3/17.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "UIHelper.h"

void setExtraCellLineHidden(UITableView *tableView) {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

inline UIView * tableViewEmpty(CGRect frame) {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 264) / 2, 100, 264, 109)];
    imageView.image = [UIImage imageNamed:@"common_empty"]; //common_empty
    [view addSubview:imageView];
    return view;
}

