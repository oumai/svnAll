//
//  QYSMyAccOrdersCell.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/3.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyAccOrdersCell.h"

@implementation QYSMyAccOrdersCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = COLOR_MAIN_CLEAR;
//        self.contentView.backgroundColor = COLOR_MAIN_CLEAR;
        
        UIGraphicsBeginImageContext(CGSizeMake(10, 10));
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ctx, COLOR_MAIN_BORDER_GRAY.CGColor);
        CGContextFillRect(ctx, CGRectMake(0, 0, 10, 10));
        UIImage *btn_bg_im = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        btn_bg_im = [btn_bg_im resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        
        UIFont *font = FONT_WITH_SIZE(15.0);
        UIFont *font2 = FONT_WITH_SIZE(18.0);
        UILabel *tips_label;
        
            //
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.translatesAutoresizingMaskIntoConstraints = NO;
        btn1.tag = 100;
        btn1.titleLabel.font = font2;
        [btn1 setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
        [btn1 setBackgroundImage:btn_bg_im forState:UIControlStateHighlighted];
        [btn1 setTitle:@"1" forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnOrderTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn1];
        
        tips_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
        tips_label.font = font;
        tips_label.text = @"全部订单";
        [btn1 addSubview:tips_label];
        
            //
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.translatesAutoresizingMaskIntoConstraints = NO;
        btn2.tag = 101;
        btn2.titleLabel.font = font2;
        [btn2 setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
        [btn2 setBackgroundImage:btn_bg_im forState:UIControlStateHighlighted];
        [btn2 setTitle:@"2" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btnOrderTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn2];
        
        tips_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
        tips_label.font = font;
        tips_label.textColor = COLOR_RGBA(1.0, 0.35, 0.36, 1.0);
        tips_label.text = @"未支付";
        [btn2 addSubview:tips_label];
        
            //
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.translatesAutoresizingMaskIntoConstraints = NO;
        btn3.tag = 102;
        btn3.titleLabel.font = font2;
        [btn3 setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
        [btn3 setBackgroundImage:btn_bg_im forState:UIControlStateHighlighted];
        [btn3 setTitle:@"3" forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(btnOrderTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn3];
        
        tips_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
        tips_label.font = font;
        tips_label.textColor = COLOR_RGBA(1.0, 0.56, 0.11, 1.0);
        tips_label.text = @"待消费";
        [btn3 addSubview:tips_label];
        
            //
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn4.translatesAutoresizingMaskIntoConstraints = NO;
        btn4.tag = 103;
        btn4.titleLabel.font = font2;
        [btn4 setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
        [btn4 setBackgroundImage:btn_bg_im forState:UIControlStateHighlighted];
        [btn4 setTitle:@"4" forState:UIControlStateNormal];
        [btn4 addTarget:self action:@selector(btnOrderTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn4];
        
        tips_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
        tips_label.font = font;
        tips_label.textColor = COLOR_RGBA(0.18, 0.74, 0.40, 1.0);
        tips_label.text = @"待退款";
        [btn4 addSubview:tips_label];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:btn1
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0.5
                                                                      constant:0.0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:btn1
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0.5
                                                                      constant:0.0]];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(btn1, btn2, btn3, btn4);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[btn1][btn2(btn1)]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[btn3(btn1)][btn4(btn1)]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn1][btn3(btn1)]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn2][btn4(btn1)]|" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    CGContextSetFillColorWithColor(ctx, COLOR_MAIN_WHITE.CGColor);
    CGContextFillRect(ctx, rect);
    
    CGContextSetStrokeColorWithColor(ctx, COLOR_HEX2RGB(0xc7c7c7).CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    
    CGContextMoveToPoint(ctx, rect.size.width/2, 0);
    CGContextAddLineToPoint(ctx, rect.size.width/2, rect.size.height);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, 0, rect.size.height/2);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height/2);
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
}

#pragma mark -

- (void)setCount01:(NSString *)count01
{
    [(UIButton *)[self.contentView viewWithTag:100] setTitle:count01 forState:UIControlStateNormal];
}

- (void)setCount02:(NSString *)count02
{
    [(UIButton *)[self.contentView viewWithTag:101] setTitle:count02 forState:UIControlStateNormal];
}

- (void)setCount03:(NSString *)count03
{
    [(UIButton *)[self.contentView viewWithTag:102] setTitle:count03 forState:UIControlStateNormal];
}

- (void)setCount04:(NSString *)count04
{
    [(UIButton *)[self.contentView viewWithTag:103] setTitle:count04 forState:UIControlStateNormal];
}

#pragma mark -

- (void)btnOrderTypeClick:(UIButton *)button
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(myAccountOrdersCellDidSelectType:index:)])
    {
        [_actDelegate performSelector:@selector(myAccountOrdersCellDidSelectType:index:) withObject:self withObject:@(button.tag-100)];
    }
}

@end
