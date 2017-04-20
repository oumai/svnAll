//
//  UIViewController+Theme.m
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "UIViewController+Theme.h"

@implementation UIViewController (Theme)

- (void)setupTheme
{
    UINavigationItem *item = self.navigationItem;
    
    UILabel *title_lab = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 44.0)];
    title_lab.tag = 101;
    title_lab.backgroundColor = [UIColor clearColor];
    title_lab.text = self.title;
    title_lab.textAlignment = NSTextAlignmentCenter;
    title_lab.textColor = [UIColor whiteColor];
    title_lab.font = FONT_WITH_SIZE(18.0);
    item.titleView = title_lab;
    
    if ([[self.view class] isSubclassOfClass:[UITableView class]])
    {
        UITableView *tv = (UITableView *)self.view;
        tv.backgroundColor = COLOR_MAIN_BG_GRAY;
        
        UIView *v = [[UIView alloc] initWithFrame:self.view.bounds];
        v.backgroundColor = COLOR_MAIN_BG_GRAY;
        
        tv.backgroundView = v;
    }
    else
    {
        self.view.backgroundColor = COLOR_MAIN_BG_GRAY;
    }
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        [self setEdgesForExtendedLayout:0];
    }
    
    if (self.navigationController)
    {
        [self.navigationController.navigationBar setupTheme];
    }
}

- (void)setupTitleTheme
{
    UINavigationItem *item = self.navigationItem;
    
    UILabel *title_lab = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 44.0)];
    title_lab.tag = 101;
    title_lab.backgroundColor = [UIColor clearColor];
    title_lab.text = self.title;
    title_lab.textAlignment = NSTextAlignmentCenter;
    title_lab.textColor = [UIColor whiteColor];
    title_lab.font = FONT_WITH_SIZE(18.0);
    item.titleView = title_lab;
}

- (void)resetTitle:(NSString *)title
{
    UILabel *lb = (UILabel *)self.navigationItem.titleView;
    lb.text = title;
}

@end
