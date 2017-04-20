//
//  QYSMyAccToolsCell.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/3.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyAccToolsCell.h"

@implementation QYSMyAccToolsCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.translatesAutoresizingMaskIntoConstraints = NO;
        btn1.tag = 100;
        [btn1 setImage:[UIImage imageNamed:@"macc-cell-icon01"] forState:UIControlStateNormal];
        [btn1 setTitle:@"商品管理" forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnToolClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 iconThemeForBottom];
        btn1.titleLabel.font = FONT_NORMAL_14;
        [self.contentView addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.translatesAutoresizingMaskIntoConstraints = NO;
        btn2.tag = 101;
        [btn2 setImage:[UIImage imageNamed:@"macc-cell-icon02"] forState:UIControlStateNormal];
        [btn2 setTitle:@"提现申请" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btnToolClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 iconThemeForBottom];
        btn2.titleLabel.font = FONT_NORMAL_14;
        [self.contentView addSubview:btn2];
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.translatesAutoresizingMaskIntoConstraints = NO;
        btn3.tag = 102;
        [btn3 setImage:[UIImage imageNamed:@"macc-cell-icon03"] forState:UIControlStateNormal];
        [btn3 setTitle:@"交易流水" forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(btnToolClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 iconThemeForBottom];
        btn3.titleLabel.font = FONT_NORMAL_14;
        [self.contentView addSubview:btn3];
        
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn4.translatesAutoresizingMaskIntoConstraints = NO;
        btn4.tag = 103;
        [btn4 setImage:[UIImage imageNamed:@"macc-cell-icon04"] forState:UIControlStateNormal];
        [btn4 setTitle:@"店铺设置" forState:UIControlStateNormal];
        [btn4 addTarget:self action:@selector(btnToolClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn4 iconThemeForBottom];
        btn4.titleLabel.font = FONT_NORMAL_14;
        [self.contentView addSubview:btn4];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(btn1, btn2, btn3, btn4);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[btn1]-[btn2(btn1)]-[btn3(btn1)]-[btn4(btn1)]-15-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn1]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn2]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn3]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn4]|" options:0 metrics:nil views:vds]];
    }
    return self;
}

#pragma mark -

- (void)btnToolClick:(UIButton *)sender
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(myAccountToolsCellDidSelect:index:)])
    {
        [_actDelegate performSelector:@selector(myAccountToolsCellDidSelect:index:) withObject:self withObject:@(sender.tag-100)];
    }
}

#pragma mark -

- (void)setCount01:(NSString *)count01
{
    
}

- (void)setCount02:(NSString *)count02
{
    
}

- (void)setCount03:(NSString *)count03
{
    
}

- (void)setCount04:(NSString *)count04
{
    
}

@end
