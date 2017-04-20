//
//  UIButton+StoreIntore.m
//  QieyouMerchant
//
//  Created by 李赛强 on 14/12/4.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import "UIButton+StoreIntore.h"
#import <objc/runtime.h>

static const void *IndieBandNameKey = &IndieBandNameKey;

@implementation UIButton (StoreIntore)

-(UIImageView *)imgView {
     return objc_getAssociatedObject(self, IndieBandNameKey);;
}

-(void)setImgView:(UIImageView *)imgView {
    objc_setAssociatedObject(self, IndieBandNameKey, imgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (id)ButtonWithFrame:(CGRect)frame title:(NSString *)titleString normalImage:(NSString *)imageName target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *iimageView = [[UIImageView alloc] initWithFrame:CGRectMake(26, 6, 12, 12)];
    iimageView.image = [UIImage imageNamed:imageName];
    button.frame = frame;
    [button addSubview:iimageView];
    button.imgView = iimageView;
    UILabel *label = [UILabel LabelWithFrame:CGRectMake(44, 6, 35, 11) text:titleString textColor:[UIColor whiteColor] font:12.0f textAlignment:NSTextAlignmentLeft];
    [button addSubview:label];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = .5f;
    button.layer.cornerRadius = 2.0f;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
