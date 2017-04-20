//
//  QYSMyOrderDetailsCells.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/14.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYSOrderObject.h"

@interface QYSMyOrderDetailsCell : UITableViewCell

@property (nonatomic, assign) BOOL haveHeaderLine;
@property (nonatomic, strong) NSDictionary *infoDict;

+ (CGFloat)heightForCell;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@interface QYSMyOrderDetailsHeaderCell : QYSMyOrderDetailsCell

@property (nonatomic, strong) OrderBaseObject *orderBaseObject;

@end

@interface QYSMyOrderDetailsInfoCell : QYSMyOrderDetailsCell

@property (nonatomic, strong) NSDictionary *infoDict2;
@property (nonatomic, strong) OrderLinkManObject *orderLinkManObject;

@property (nonatomic, strong) OrderProfitObject *orderProfitObject;

@end

@interface QYSMyOrderDetailsOperate0Cell : QYSMyOrderDetailsCell
@property (nonatomic, strong) UITextField *tfCode;
@property (nonatomic, strong) UITextField *tfReason;

@property (nonatomic, strong) void(^submitOrderBlock)(void);
@property (nonatomic, strong) void(^cancelOrderBlock)(void);

@end

@interface QYSMyOrderDetailsWatingPayCell: QYSMyOrderDetailsCell
@property (nonatomic, strong) UILabel *tfCode;
@property (nonatomic, strong) UITextField *tfReason;
@property (nonatomic, strong) void(^submitOrderBlock)(void);
@property (nonatomic, strong) void(^cancelOrderBlock)(void);
@end

@interface QYSMyOrderDetailsOperate1Cell : QYSMyOrderDetailsCell
@property (nonatomic, strong) UITextField *tfReason;
@property (nonatomic, strong) void (^cancelOrderBlock)(void);

@end

@interface QYSMyOrderDetailsOperate2Cell : QYSMyOrderDetailsCell

@property (nonatomic, strong) NSArray *orderCoupons;

@end

@interface QYSMyOrderDetailsOperate3Cell : QYSMyOrderDetailsCell

@property (nonatomic, strong) NSString *note;

@end
