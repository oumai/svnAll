//
//  QYSPostCodeViewController.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/7.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSPostCodeViewController : UIViewController

@property (nonatomic, readonly) NSString *code;

@property (nonatomic, strong) void(^closeBlock)(QYSPostCodeViewController *controller);
@property (nonatomic, strong) void(^submitBlock)(QYSPostCodeViewController *controller, NSString *orderId);

@end
