//
//  QYSMyOrderDetailsViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/13.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyOrderDetailsViewController.h"
#import "QYSMyOrderDetailsCells.h"
#import "HHHJSONKit.h"
#import "QYSOrderObject.h"
#import <BlocksKit/BlocksKit+UIKit.h>

#import "QYSPayViewController.h"


@interface QYSMyOrderDetailsViewController ()

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) OrderDetail *orderDetail;
@property (nonatomic, strong) NSMutableDictionary *orderDetailDictionary;
@property (nonatomic, strong) NSMutableDictionary *orderCellHeightDictionary;

@property (nonatomic, strong) UITextField *cancelPayWhyTextField;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) OrderBaseObject *orderBaseObject;
@property (nonatomic, strong) OrderLinkManObject *orderLinkManObject;

@end

@implementation QYSMyOrderDetailsViewController

-(void)dealloc {
    
}

+ (UINavigationController *)navController
{
    QYSMyOrderDetailsViewController *c = [[QYSMyOrderDetailsViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

+ (UINavigationController *)navControllerWithOrderId:(NSString *)orderId {
    QYSMyOrderDetailsViewController *c = [[QYSMyOrderDetailsViewController alloc] initWithStyle:UITableViewStylePlain];
    c.orderId = orderId;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;

}

+ (UINavigationController *)navControllerWithType:(QYSMyOrderType)type data:(NSDictionary *)data
{
    QYSMyOrderDetailsViewController *c = [[QYSMyOrderDetailsViewController alloc] initWithStyle:UITableViewStylePlain];
    c.type = type;
    c.data = data;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = @"订单详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    self.view.backgroundColor = COLOR_MAIN_WHITE;
    
    UIView *v = [[UIView alloc] initWithFrame:self.view.bounds];
    v.backgroundColor = COLOR_MAIN_WHITE;
    self.tableView.backgroundView = v;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[OrderDetailService sharedOrderDetailService] getOrderDetailWithOrderId:_orderId completeDictionary:^(NSDictionary *response) {
        [self reloadDataWithResponse:response];
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
}

#pragma mark - Data

-(void)reloadDataWithResponse:(NSDictionary *)dictionary {
    if (nil == _orderDetailDictionary) {
        self.orderDetailDictionary = [NSMutableDictionary new];
    }
    
    if ([_orderDetailDictionary count] > 0) {
        [_orderDetailDictionary removeAllObjects];
    }
    
    if (nil == _orderCellHeightDictionary) {
        self.orderCellHeightDictionary = [NSMutableDictionary new];
    }
    
    if ([_orderCellHeightDictionary count] > 0) {
        [_orderCellHeightDictionary removeAllObjects];
    }
    
    OrderBaseObject *orderBaseObject = [[OrderBaseObject alloc] init];
    orderBaseObject.order_type = [dictionary objectForKey:@"order_type"];
    orderBaseObject.order_state = [dictionary objectForKey:@"order_state"];
    orderBaseObject.product_category = [dictionary objectForKey:@"product_category"];
    orderBaseObject.product_name = [dictionary objectForKey:@"product_name"];
    orderBaseObject.product_thumb = [dictionary objectForKey:@"product_thumb"];
    orderBaseObject.product_price = [dictionary objectForKey:@"product_price"];
    orderBaseObject.product_quantity = [dictionary objectForKey:@"product_quantity"];
    [self.orderDetailDictionary setObject:orderBaseObject forKey:@"order_base_object_key"];
    [self.orderCellHeightDictionary setObject:@(95) forKey:@"0"];
    self.orderBaseObject = orderBaseObject;
    
    OrderLinkManObject *orderLinkManObject = [[OrderLinkManObject alloc] init];
    orderLinkManObject.order_num = [dictionary objectForKey:@"order_num"];
    orderLinkManObject.order_paytime = [dictionary objectForKey:@"order_paytime"];
    orderLinkManObject.order_create_time = [dictionary objectForKey:@"order_create_time"];
    orderLinkManObject.contact_name = [dictionary objectForKey:@"contact_name"];
    orderLinkManObject.contact_telephone = [dictionary objectForKey:@"contact_telephone"];
    orderLinkManObject.order_cancel_able = [[dictionary objectForKey:@"order_cancel_able"] boolValue];
    [self.orderDetailDictionary setObject:orderLinkManObject forKey:@"order_link_man_object"];
    [self.orderCellHeightDictionary setObject:@(87) forKey:@"1"];
    self.orderLinkManObject = orderLinkManObject;
    
    OrderCouponObject *orderCouponObject = [[OrderCouponObject alloc] init];
    orderCouponObject.order_num = [dictionary objectForKey:@"order_num"];
    orderCouponObject.order_coupon = [dictionary objectForKey:@"order_coupon"];
    orderCouponObject.order_state = [dictionary objectForKey:@"order_state"];
    [self.orderDetailDictionary setObject:orderCouponObject forKey:@"order_coupon_object"];
    
    if ([orderCouponObject.order_state isEqualToString:@"A"]) {
        //'A' => '未支付'
        [self.orderCellHeightDictionary setObject:@(170) forKey:@"2"];
    }else if ([orderCouponObject.order_state isEqualToString:@"U"]) {
        //'U' => '待消费'
        [self.orderCellHeightDictionary setObject:@(228) forKey:@"2"];
    }else if ([orderCouponObject.order_state isEqualToString:@"R"]) {
        //'R' => '待退款'
        [self.orderCellHeightDictionary setObject:@(90) forKey:@"2"];
    }else if ([orderCouponObject.order_state isEqualToString:@"C"]) {
        //'C' => '已退款'
        [self.orderCellHeightDictionary setObject:@(90) forKey:@"2"];
    }else if ([orderCouponObject.order_state isEqualToString:@"P"]) {
        //'P' => '已支付'
        [self.orderCellHeightDictionary setObject:@(110) forKey:@"2"];
    }else if ([orderCouponObject.order_state isEqualToString:@"S"]) {
        //'S' => '已完成'
        NSString *order_coupon = orderCouponObject.order_coupon;
        NSArray *array = [order_coupon objectFromHHHJSONString];
        
        NSInteger height = (175 - 62 * [array count]) + 62 * [array count];
        
        [self.orderCellHeightDictionary setObject:@(height) forKey:@"2"];
    }else if ([orderCouponObject.order_state isEqualToString:@"N"]) {
        //'N' => '已取消'
        [self.orderCellHeightDictionary setObject:@(90) forKey:@"2"];
    }
    
    OrderProfitObject *orderProfitObject = [[OrderProfitObject alloc] init];
    orderProfitObject.order_total = [dictionary objectForKey:@"order_total"];
    orderProfitObject.settlement_time = [dictionary objectForKey:@"settlement_time"];
    orderProfitObject.profit = [dictionary objectForKey:@"profit"];
    orderProfitObject.agent_profit = [dictionary objectForKey:@"agent_profit"];
    orderProfitObject.qieyou_profit = [dictionary objectForKey:@"qieyou_profit"];
    [self.orderDetailDictionary setObject:orderProfitObject forKey:@"order_profit_object"];
    [self.orderCellHeightDictionary setObject:@(180) forKey:@"3"];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_orderDetailDictionary count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = 44.0;
    
    switch (indexPath.row)
    {
        case 0:
            h = 101.0;
            break;
            
        case 1:
            h = 130.0;
            break;
            
        case 2:
        {
            switch (_type)
            {
                default:
                case QYSMyOrderTypeI:
                    h = [QYSMyOrderDetailsOperate0Cell heightForCell];
                    break;
                    
                case QYSMyOrderTypeII:
                    h = [QYSMyOrderDetailsOperate1Cell heightForCell];
                    break;
                    
                case QYSMyOrderTypeIII:
                    h = [QYSMyOrderDetailsOperate2Cell heightForCell];
                    break;
                    
                case QYSMyOrderTypeIV:
                    h = [QYSMyOrderDetailsOperate3Cell heightForCell];
                    break;
            }
        }
            break;
            
        case 3:
            h = 220.0;
            break;
    }
    
    return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSMyOrderDetailsCell *cell = nil;
    
    if (0 == indexPath.row)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"my-order-details-header-cell"];
        
        if (!cell)
        {
            cell = [[QYSMyOrderDetailsHeaderCell alloc] initWithReuseIdentifier:@"my-order-details-header-cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        QYSMyOrderDetailsHeaderCell *_cell = (QYSMyOrderDetailsHeaderCell *)cell;
       OrderBaseObject *orderBaseObject = [_orderDetailDictionary objectForKey:@"order_base_object_key"];
        _cell.orderBaseObject = orderBaseObject;
    }
    else if (1 == indexPath.row)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"my-order-details-info-cell"];
        
        if (!cell)
        {
            cell = [[QYSMyOrderDetailsInfoCell alloc] initWithReuseIdentifier:@"my-order-details-info-cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        QYSMyOrderDetailsInfoCell *_cell = (QYSMyOrderDetailsInfoCell *)cell;
        OrderLinkManObject *orderLinkManObject = [_orderDetailDictionary objectForKey:@"order_link_man_object"];
        _cell.orderLinkManObject = orderLinkManObject;
    }
    else if (2 == indexPath.row)
    {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"my-order-details-operate-cell"];
//        
//        if (!cell)
//        {
//            cell = [[QYSMyOrderDetailsOperate3Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
        
        OrderCouponObject *orderCouponObject = [_orderDetailDictionary objectForKey:@"order_coupon_object"];
        
        if ([orderCouponObject.order_state isEqualToString:@"U"]) {
            //'U' => '待消费'
            cell = [[QYSMyOrderDetailsOperate0Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
            QYSMyOrderDetailsOperate0Cell *mCell = (QYSMyOrderDetailsOperate0Cell *)cell;
            __weak QYSMyOrderDetailsOperate0Cell *weakCell = mCell;
            [mCell setSubmitOrderBlock:^{
                NSString *code = weakCell.tfCode.text;
                if (code.length == 0) {
                    JDStatusBarNotificationError(@"请输入消费代码");
                    return ;
                }
                self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                //显示的文字
                self.HUD.labelText = @"";
                //细节文字
                self.HUD.detailsLabelText = @"正在验码...";
                //是否有庶罩
                self.HUD.dimBackground = YES;
                [self.HUD show:YES];
                [[QuickVerifyService sharedQuickVerifyService] quickVerify:code login:^{
                    
                } complete:^(NSString *data) {
                    [self.HUD hide:YES];
                    self.orderId = data;
                    
                    [[OrderDetailService sharedOrderDetailService] getOrderDetailWithOrderId:_orderId completeDictionary:^(NSDictionary *response) {
                        [self reloadDataWithResponse:response];
                    } error:^(NSString *error) {
                        JDStatusBarNotificationError(error);
                    }];
                    
                } error:^(NSString *error) {
                    [self.HUD hide:YES];
                    [JDStatusBarNotification showWithStatus:error dismissAfter:1.5f styleName:JDStatusBarStyleError];
                }];
            }];
            
            [mCell setCancelOrderBlock:^{
                
                OrderLinkManObject *object = [_orderDetailDictionary objectForKey:@"order_link_man_object"];
                if (!object.order_cancel_able) {
                    [JDStatusBarNotification showWithStatus:@"不能取消该订单" dismissAfter:1.5f styleName:JDStatusBarStyleError];
                    return ;
                }
                
                NSString *whyString = weakCell.tfReason.text;
                if (whyString.length == 0) {
                    JDStatusBarNotificationError(@"请输入取消订单原因");
                    return;
                }
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要取消该订单吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
                
                [alertView bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger index) {
                    switch (index) {
                        case 1:
                        {
                            OrderLinkManObject *object = [_orderDetailDictionary objectForKey:@"order_link_man_object"];
                            if (!object.order_cancel_able) {
                                [JDStatusBarNotification showWithStatus:@"不能取消该订单" dismissAfter:1.5f styleName:JDStatusBarStyleError];
                                return ;
                            }
                            
                            NSString *whyString = weakCell.tfReason.text;
                            if (whyString.length == 0) {
                                JDStatusBarNotificationError(@"请输入取消订单原因");
                                return;
                            }
                            
                            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            //显示的文字
                            self.HUD.labelText = @"";
                            //细节文字
                            self.HUD.detailsLabelText = @"正在取消订单...";
                            //是否有庶罩
                            self.HUD.dimBackground = YES;
                            [self.HUD show:YES];
                            
                            [[OrderSubmitService sharedOrderSubmitService] cancelPayWithOid:object.order_num why:whyString complete:^{
                                [self.HUD hide:YES];
                                [[OrderDetailService sharedOrderDetailService] getOrderDetailWithOrderId:_orderId completeDictionary:^(NSDictionary *response) {
                                    [self reloadDataWithResponse:response];
                                } error:^(NSString *error) {
                                    JDStatusBarNotificationError(error);
                                }];
                                
                            } error:^(NSString *error) {
                                [self.HUD hide:YES];
                            }];
                        }
                            break;
                            
                        default:
                            break;
                    }
                }];
            }];
            
        }else if ([orderCouponObject.order_state isEqualToString:@"A"]) {
            //'A' => '未支付'
            cell = [[QYSMyOrderDetailsWatingPayCell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
            QYSMyOrderDetailsWatingPayCell *mCell = (QYSMyOrderDetailsWatingPayCell *)cell;
            __weak QYSMyOrderDetailsWatingPayCell *weakCell = mCell;
            [mCell setSubmitOrderBlock:^{
               
                self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                //显示的文字
                self.HUD.labelText = @"";
                //细节文字
                self.HUD.detailsLabelText = @"正在提交支付...";
                //是否有庶罩
                [self.HUD show:YES];
                
                [[OrderSubmitService sharedOrderSubmitService] payToCenterWithOid:self.orderLinkManObject.order_num complete:^(NSString *webUrl) {
                    [self.HUD hide:YES];
                    QYSPayViewController *PayViewController = [[QYSPayViewController alloc] init];
                    PayViewController.webUrl = webUrl;
                    PayViewController.oid = _orderId;
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:PayViewController];
                    nav.navigationBar.barTintColor = [UIColor redColor];
                    nav.modalPresentationStyle = UIModalPresentationFormSheet;
                    [self presentViewController:nav animated:YES completion:nil];
                    
                    [PayViewController setDismissBlock:^(QYSPayViewController *viewController) {
                        [viewController dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                        
                    }];
                    
                    [PayViewController setFinishBlock:^(QYSPayViewController *viewController) {
                        
                        [viewController dismissViewControllerAnimated:YES completion:^{
                            [[OrderDetailService sharedOrderDetailService] getOrderDetailWithOrderId:_orderId completeDictionary:^(NSDictionary *response) {
                                [self reloadDataWithResponse:response];
                            } error:^(NSString *error) {
                                JDStatusBarNotificationError(error);
                            }];
                            
                        }];
                    }];
                } error:^(NSString *error) {
                    [self.HUD hide:YES];
                }];
                
                
            }];
            
            [mCell setCancelOrderBlock:^{
                
                OrderLinkManObject *object = [_orderDetailDictionary objectForKey:@"order_link_man_object"];
                if (!object.order_cancel_able) {
                    [JDStatusBarNotification showWithStatus:@"不能取消该订单" dismissAfter:1.5f styleName:JDStatusBarStyleError];
                    return ;
                }
                
                NSString *whyString = weakCell.tfReason.text;
                if (whyString.length == 0) {
                    JDStatusBarNotificationError(@"请输入取消订单原因");
                    return;
                }
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要取消该订单吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
                
                [alertView bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger index) {
                    switch (index) {
                        case 1:
                        {
                            OrderLinkManObject *object = [_orderDetailDictionary objectForKey:@"order_link_man_object"];
                            if (!object.order_cancel_able) {
                                [JDStatusBarNotification showWithStatus:@"不能取消该订单" dismissAfter:1.5f styleName:JDStatusBarStyleError];
                                return ;
                            }
                            
                            NSString *whyString = weakCell.tfReason.text;
                            if (whyString.length == 0) {
                                JDStatusBarNotificationError(@"请输入取消订单原因");
                                return;
                            }
                            
                            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            //显示的文字
                            self.HUD.labelText = @"";
                            //细节文字
                            self.HUD.detailsLabelText = @"正在取消订单...";
                            //是否有庶罩
                            self.HUD.dimBackground = YES;
                            [self.HUD show:YES];
                            
                            [[OrderSubmitService sharedOrderSubmitService] cancelPayWithOid:object.order_num why:whyString complete:^{
                                [self.HUD hide:YES];
                                [[OrderDetailService sharedOrderDetailService] getOrderDetailWithOrderId:_orderId completeDictionary:^(NSDictionary *response) {
                                    [self reloadDataWithResponse:response];
                                } error:^(NSString *error) {
                                    JDStatusBarNotificationError(error);
                                }];
                                
                            } error:^(NSString *error) {
                                [self.HUD hide:YES];
                            }];
                        }
                            break;
                            
                        default:
                            break;
                    }
                }];
            }];
        }else if ([orderCouponObject.order_state isEqualToString:@"R"]) {
            //'R' => '待退款'
            cell = [[QYSMyOrderDetailsOperate3Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
            QYSMyOrderDetailsOperate3Cell *_cell = (QYSMyOrderDetailsOperate3Cell *)cell;
            _cell.note = @"该订单正在退款中...";
            
        }else if ([orderCouponObject.order_state isEqualToString:@"C"]) {
            //'C' => '已退款'
            cell = [[QYSMyOrderDetailsOperate3Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
            QYSMyOrderDetailsOperate3Cell *_cell = (QYSMyOrderDetailsOperate3Cell *)cell;
            _cell.note = @"该订单已经退款";
        }else if ([orderCouponObject.order_state isEqualToString:@"P"]) {
            //'P' => '已支付'
            cell = [[QYSMyOrderDetailsOperate1Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
            QYSMyOrderDetailsOperate1Cell *mCell = (QYSMyOrderDetailsOperate1Cell *)cell;
            __weak QYSMyOrderDetailsOperate1Cell *weakCell = mCell;
            [mCell setCancelOrderBlock:^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要取消该订单吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
                
                [alertView bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger index) {
                    switch (index) {
                        case 1:
                        {
                            OrderLinkManObject *object = [_orderDetailDictionary objectForKey:@"order_link_man_object"];
                            if (!object.order_cancel_able) {
                                [JDStatusBarNotification showWithStatus:@"不能取消该订单" dismissAfter:1.5f styleName:JDStatusBarStyleError];
                                return ;
                            }
                            
                             NSString *whyString = weakCell.tfReason.text;
                            if (whyString.length == 0) {
                                JDStatusBarNotificationError(@"请输入取消订单原因");
                                return;
                            }
                            
                            self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                            //显示的文字
                            self.HUD.labelText = @"";
                            //细节文字
                            self.HUD.detailsLabelText = @"正在取消订单...";
                            //是否有庶罩
                            self.HUD.dimBackground = YES;
                            [self.HUD show:YES];
                            
                            [[OrderSubmitService sharedOrderSubmitService] cancelPayWithOid:object.order_num why:whyString complete:^{
                                [self.HUD hide:YES];
                                [[OrderDetailService sharedOrderDetailService] getOrderDetailWithOrderId:_orderId completeDictionary:^(NSDictionary *response) {
                                    [self reloadDataWithResponse:response];
                                } error:^(NSString *error) {
                                    JDStatusBarNotificationError(error);
                                }];
                                
                            } error:^(NSString *error) {
                                [self.HUD hide:YES];
                            }];
                        }
                            break;
                            
                        default:
                            break;
                    }
                }];
            }];
            
            
        }else if ([orderCouponObject.order_state isEqualToString:@"S"]) {
            //'S' => '已完成'
            NSString *order_coupon = orderCouponObject.order_coupon;
            NSArray *array = [order_coupon objectFromHHHJSONString];
            cell = [[QYSMyOrderDetailsOperate2Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
            QYSMyOrderDetailsOperate2Cell *_cell = (QYSMyOrderDetailsOperate2Cell *)cell;
            _cell.orderCoupons = array;
           
        }else if ([orderCouponObject.order_state isEqualToString:@"N"]) {
            //'N' => '已取消'
            cell = [[QYSMyOrderDetailsOperate3Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
            QYSMyOrderDetailsOperate3Cell *_cell = (QYSMyOrderDetailsOperate3Cell *)cell;
            _cell.note = @"该订单已经取消";
        }
        
        /*
        switch (_type)
        {
            default:
            case QYSMyOrderTypeI:
                cell = [[QYSMyOrderDetailsOperate0Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
                break;
                
            case QYSMyOrderTypeII:
                cell = [[QYSMyOrderDetailsOperate1Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
                break;
                
            case QYSMyOrderTypeIII:
                cell = [[QYSMyOrderDetailsOperate2Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
                break;
                
            case QYSMyOrderTypeIV:
                cell = [[QYSMyOrderDetailsOperate3Cell alloc] initWithReuseIdentifier:@"my-order-details-operate-cell"];
                break;
        }
         */
    }
    else if (3 == indexPath.row)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"my-order-details-info-cell"];
        
        if (!cell)
        {
            cell = [[QYSMyOrderDetailsInfoCell alloc] initWithReuseIdentifier:@"my-order-details-info-cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    
    if (3 == indexPath.row)
    {
        OrderProfitObject *orderProfitObject = [_orderDetailDictionary objectForKey:@"order_profit_object"];
        ((QYSMyOrderDetailsInfoCell *)cell).orderProfitObject = orderProfitObject;
    }
    
    return cell;
}

@end
