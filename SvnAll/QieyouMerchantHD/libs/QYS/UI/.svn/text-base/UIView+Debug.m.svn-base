//
//  UIView+Debug.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/1/31.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "UIView+Debug.h"

@implementation UIView (Debug)

- (void)printColorForConstraints
{
#ifdef DEBUG
    for (NSLayoutConstraint *c in self.constraints)
    {
        if (c.firstItem)
        {
            ((UIView *)(c.firstItem)).backgroundColor = COLOR_RANDOM;
        }
    }
#endif
}

@end
