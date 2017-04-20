//
//  UIBarButtonItem+Theme.m
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "UIBarButtonItem+Theme.h"

@implementation UIBarButtonItem (Theme)

- (id)initWithBarButtonThemeItem:(UIBarButtonThemeItem)item target:(id)target action:(SEL)action
{
    UIImage *img = nil;
//    UIImage *img_h = nil;
    
    switch (item)
    {
        case UIBarButtonThemeItemOK:
            img = [UIImage imageNamed:@"nav-icon-ok"];
            break;
            
        case UIBarButtonThemeItemBack:
            img = [UIImage imageNamed:@"nav-icon-back"];
            break;
            
        case UIBarButtonThemeItemRegBack:
            img = [UIImage imageNamed:@"nav-icon-reg-back"];
            break;
            
        case UIBarButtonThemeItemSave:
            img = [UIImage imageNamed:@"nav-icon-save"];
            break;
            
        case UIBarButtonThemeItemList:
            img = [UIImage imageNamed:@"nav-icon-list"];
            break;
            
        case UIBarButtonThemeItemFilter:
            img = [UIImage imageNamed:@"nav-icon-filter"];
            break;
            
        case UIBarButtonThemeItemAdd:
            img = [UIImage imageNamed:@"nav-icon-add"];
            break;
            
        case UIBarButtonThemeItemSettings:
            img = [UIImage imageNamed:@"nav-icon-settings"];
            break;
            
        case UIBarButtonThemeItemMore:
            img = [UIImage imageNamed:@"nav-icon-more"];
            break;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, img.size.width, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
//    [btn setImage:img_h forState:UIControlStateHighlighted];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (id)initWithBarButtonThemeWithImageName:(NSString *)imageName hight:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIImage *img = [UIImage imageNamed:imageName];
    UIImage *imgHight = [UIImage imageNamed:highImageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, img.size.width, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setImage:imgHight forState:UIControlStateHighlighted];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    CGFloat fs = 0.0;
    CGSize s = [title sizeWithFont:FONT_NORMAL minFontSize:10.0 actualFontSize:&fs forWidth:100 lineBreakMode:NSLineBreakByWordWrapping];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, s.width+10.0, s.height);
    btn.titleLabel.font = FONT_NORMAL;
    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:COLOR_TEXT_BLUE forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

- (id)initWithBarButtonThemeItem:(UIBarButtonThemeItem)item title:(NSString *)title target:(id)target action:(SEL)action
{
    UIImage *img = nil;
    
    switch (item)
    {
        case UIBarButtonThemeItemOK:
            img = [UIImage imageNamed:@"nav-icon-ok"];
            break;
            
        case UIBarButtonThemeItemBack:
            img = [UIImage imageNamed:@"nav-icon-back"];
            break;
            
        case UIBarButtonThemeItemRegBack:
            img = [UIImage imageNamed:@"nav-icon-reg-back"];
            break;
            
        case UIBarButtonThemeItemSave:
            img = [UIImage imageNamed:@"nav-icon-save"];
            break;
            
        case UIBarButtonThemeItemList:
            img = [UIImage imageNamed:@"nav-icon-list"];
            break;
            
        case UIBarButtonThemeItemFilter:
            img = [UIImage imageNamed:@"nav-icon-filter"];
            break;
            
        case UIBarButtonThemeItemAdd:
            img = [UIImage imageNamed:@"nav-icon-add"];
            break;
            
        case UIBarButtonThemeItemSettings:
            img = [UIImage imageNamed:@"nav-icon-settings"];
            break;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect title_r = [title boundingRectWithSize:CGSizeMake(200, 15)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0], NSParagraphStyleAttributeName:paragraphStyle}
                                         context:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, img.size.width+10+title_r.size.width, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn iconTheme];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

@end
