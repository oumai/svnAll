//
//  OrderCountSelectedView.h
//  QieyouMerchant
//
//  Created by 李赛强 on 15/1/28.
//  Copyright (c) 2015年 lisaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCountSelectedView : UIView

@property (nonatomic, assign) NSInteger stockCount;
@property (nonatomic, copy, readwrite) void(^productCountIsNotValidBlock)();

-(void) orderCountSelectedWithCount:(void(^)(NSInteger count))block;

-(void) orderCountSelectedError:(void(^)(NSString *error))block;



-(void)reloadDateInView:(UIView *)view;

@end
