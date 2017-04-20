//
//  UIButton+Icon.m
//  QieYouShop
//
//  Created by Vincent on 1/29/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "UIButton+Icon.h"

@implementation UIButton (Icon)

- (void)iconTheme
{
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.titleLabel.font = FONT_NORMAL;
    [self setTitleColor:COLOR_MAIN_BLACK forState:UIControlStateNormal];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (void)iconThemeForBottom
{
    CGSize title_s = [[self titleForState:UIControlStateNormal] sizeWithAttributes:@{NSFontAttributeName:FONT_NORMAL_13}];
    CGFloat total_w = self.titleLabel.frame.origin.x + title_s.width;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView.image.size.height+10, self.imageView.image.size.width*-1, 0, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(-16, (total_w-self.imageView.image.size.width-3)/2, 0, 0);
    self.titleLabel.font = FONT_WITH_SIZE(13.0);
    [self setTitleColor:COLOR_MAIN_BLACK forState:UIControlStateNormal];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

@end
