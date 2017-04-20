//
//  UINavigationBar+Theme.m
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "UINavigationBar+Theme.h"

@implementation UINavigationBar (Theme)

- (void)setupTheme
{
    static UIImage *im = nil;
    
    if (!im)
    {
        CGSize size;
        size.width = [UIScreen mainScreen].bounds.size.width;
        
        if (IS_UP_THAN_IOS7)
        {
            size.height = 64.0f;
        }
        else
        {
            size.height = 44.0f;
        }
        
        UIColor *color = COLOR_MAIN_GREEN;
        
        UIGraphicsBeginImageContextWithOptions(size, YES, 2.0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ctx, color.CGColor);
        CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
        im =  UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        if (IS_UP_THAN_IOS7)
        {
            [self setBackgroundImage:im forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        }
        else
        {
            [self setBackgroundImage:im forBarMetrics:UIBarMetricsDefault];
        }
    }
    
    if ([self respondsToSelector:@selector(setShadowImage:)])
    {
        [self setShadowImage:[[UIImage alloc] init]];
    }
}

@end
