//
//  QYSOrderObject.h
//  QieYouShop
//
//  Created by 李赛强 on 15/3/18.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <Foundation/Foundation.h>


//------------------------------------------------------------------------------------------//

@interface OrderBaseObject : NSObject

@property (nonatomic, strong)NSString *product_name;         //商品的名字
@property (nonatomic, strong)NSString *product_thumb;        //商品缩略图
@property (nonatomic, strong)NSString *order_type;           //订单类型
@property (nonatomic, strong)NSString *order_state;          //支付状态
@property (nonatomic, strong)NSString *product_price;        //商品价格
@property (nonatomic, strong)NSString *product_quantity;     //商品数量
@property (nonatomic, strong)NSString *product_category;     //订单类型 7是保险

@end



//------------------------------------------------------------------------------------------//

@interface OrderLinkManObject : NSObject
@property (nonatomic, strong)NSString *order_num;            //订单编号
@property (nonatomic, strong)NSString *order_paytime;        //支付时间
@property (nonatomic, strong)NSString *order_create_time;    //订单创建时间
@property (nonatomic, strong)NSString *contact_name;         //联系人
@property (nonatomic, strong)NSString *contact_telephone;    //联系电话
@property (nonatomic, assign)BOOL order_cancel_able;

@end



//------------------------------------------------------------------------------------------//

@interface OrderCouponObject : NSObject
@property (nonatomic, strong)NSString *order_num;
@property (nonatomic, strong)NSString *order_coupon;         //订单的消费码
@property (nonatomic, strong)NSString *order_state;          //支付状态
@end



//------------------------------------------------------------------------------------------//

@interface OrderProfitObject : NSObject
@property (nonatomic, strong)NSString *order_total;          //订单总额
@property (nonatomic, strong)NSString *settlement_time;      //结算时间
@property (nonatomic, strong)NSString *profit;               //当前商户的收益
@property (nonatomic, strong)NSString *agent_profit;         //代售佣金
@property (nonatomic, strong)NSString *qieyou_profit;        //平台收益
@end


