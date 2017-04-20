//
//  QYSButtonGroup.m
//  QieYouShop
//
//  Created by Vincent on 1/29/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSButtonGroup.h"

@interface QYSButtonGroup ()


@end

@implementation QYSButtonGroup

- (void)setItems:(NSArray *)items
{
    float tw = 0;
    float btns_w = 0;
    int flexible_cnt = 0;
    float flexible_w = 0.0;
    
    for (UIView *v in items)
    {
        if ([v isKindOfClass:[UIBarButtonItem class]])
        {
            if (0.0 == ((UIBarButtonItem *)v).width)
            {
                flexible_cnt++;
            }
        }
        else
        {
            btns_w += v.bounds.size.width;
        }
    }
    
    if (flexible_cnt)
    {
        flexible_w = (self.bounds.size.width-btns_w)/flexible_cnt;
    }
    
    for (UIView *v in items)
    {
        if ([v isKindOfClass:[UIBarButtonItem class]])
        {
            if (0.0 == ((UIBarButtonItem *)v).width)
            {
                tw += flexible_w;
            }
            else
            {
                tw += ((UIBarButtonItem *)v).width;
            }
        }
        else
        {
            tw += v.bounds.size.width;
        }
    }
    
    CGFloat offset_x = (self.bounds.size.width-tw)*0.5;
    
    CGRect f;
    CGFloat offset_xt = offset_x;
    for (UIView *v in items)
    {
        if ([v isKindOfClass:[UIBarButtonItem class]])
        {
            if (0.0 == ((UIBarButtonItem *)v).width)
            {
                offset_xt += flexible_w;
            }
            else
            {
                offset_xt += ((UIBarButtonItem *)v).width;
            }
            
            continue;
        }
        
        f = v.frame;
        f.origin.x = offset_xt;
        v.frame = f;
        [self addSubview:v];
        
        offset_xt += f.size.width;
    }
}

@end
