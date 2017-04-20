//
//  OrderStatus.m
//  QieyouMerchant
//
//  Created by 李赛强 on 15/1/12.
//  Copyright (c) 2015年 lisaiqiang. All rights reserved.
//

#import "OrderStatus.h"

@implementation OrderStatus

+(NSString *)orderStatus:(NSString *)orderStatus {
    
    if ([orderStatus isEqualToString:@"A"]) {
        return @"未支付";
    }else if ([orderStatus isEqualToString:@"P"]) {
        return @"已支付";
    }else if ([orderStatus isEqualToString:@"U"]) {
        return @"待消费";
    }else if ([orderStatus isEqualToString:@"S"]) {
        return @"已完成";
    }else if ([orderStatus isEqualToString:@"R"]) {
        return @"待退款";
    }else if ([orderStatus isEqualToString:@"C"]) {
        return @"已退款";
    }else if ([orderStatus isEqualToString:@"N"]) {
        return @"已取消";
    }
    
    return @"";
}

@end
