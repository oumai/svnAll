//
//  QYSMyOrderDetailsViewController.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/13.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QYSMyOrderTypeI     = 0,
    QYSMyOrderTypeII,
    QYSMyOrderTypeIII,
    QYSMyOrderTypeIV
} QYSMyOrderType;

@interface QYSMyOrderDetailsViewController : UITableViewController

@property (nonatomic, assign) QYSMyOrderType type;
@property (nonatomic, strong) NSDictionary *data;




+ (UINavigationController *)navController;

+ (UINavigationController *)navControllerWithOrderId:(NSString *)orderId;

+ (UINavigationController *)navControllerWithType:(QYSMyOrderType)type data:(NSDictionary *)data;

@end
