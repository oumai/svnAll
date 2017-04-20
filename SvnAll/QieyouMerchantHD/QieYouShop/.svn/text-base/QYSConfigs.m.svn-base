//
//  QYSConfigs.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/1/28.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSConfigs.h"

@implementation QYSConfigs

+ (CGSize)screenSize
{
    static CGSize s;
    
    if (!s.width)
    {
        UIScreen *scr = [UIScreen mainScreen];
        if (scr.bounds.size.width > scr.bounds.size.height)
        {
            s = CGSizeMake(scr.bounds.size.width, scr.bounds.size.height);
        }
        else
        {
            s = CGSizeMake(scr.bounds.size.height, scr.bounds.size.width);
        }
    }
    
    return s;
}

+ (CGRect)screenRect
{
    static CGRect s;
    
    if (!s.size.width)
    {
        UIScreen *scr = [UIScreen mainScreen];
        if (scr.bounds.size.width > scr.bounds.size.height)
        {
            s = CGRectMake(0, 0, scr.bounds.size.width, scr.bounds.size.height);
        }
        else
        {
            s = CGRectMake(0, 0, scr.bounds.size.height, scr.bounds.size.width);
        }
    }
    
    return s;
}

@end
