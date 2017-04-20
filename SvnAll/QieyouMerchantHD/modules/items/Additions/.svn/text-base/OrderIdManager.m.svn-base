//
//  OrderIdManager.m
//  QieYouShop
//
//  Created by 李赛强 on 15/3/23.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "OrderIdManager.h"

@implementation OrderIdManager

+(id)sharedOrderIdManager {
    static OrderIdManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OrderIdManager alloc] init];
    });
    
    return instance;
}

@end
