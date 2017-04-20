//
//  QYSSegments.m
//  QieYouShop
//
//  Created by Vincent on 2/9/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSSegments.h"

@interface QYSSegments ()

@property (nonatomic, strong) CALayer *movementBar;

@end

@implementation QYSSegments

- (void)dealloc
{
    [_movementBar removeFromSuperlayer];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tineColor = COLOR_MAIN_WHITE;
        _selectedIndex = -1;
    }
    return self;
}

- (void)setSegments:(NSArray *)segments
{
    int i=0;
    UIButton *btn;
    UIButton *btn_tmp;
    for (NSString *str in segments)
    {
        btn = [[UIButton alloc] init];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        btn.tag = 100+i;
        btn.titleLabel.font = FONT_NORMAL;
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
        [btn setTitleColor:_tineColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn]|" options:0 metrics:nil views:@{@"btn":btn}]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1.0/segments.count
                                                          constant:0.0]];
        
        if (0 == i)
        {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.0
                                                              constant:0.0]];
        }
        else
        {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:btn
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:btn_tmp
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1.0
                                                              constant:0.0]];
        }
        
        btn_tmp = btn;
        
        i++;
    }
    
    self.movementBar = [CALayer layer];
    _movementBar.anchorPoint = CGPointMake(0, 0);
    _movementBar.frame = CGRectMake(0, self.bounds.size.height-5, 100, 2.5);
    _movementBar.backgroundColor = _tineColor.CGColor;
    [self.layer addSublayer:_movementBar];
    
    self.selectedIndex = 0;
}

- (void)btnClick:(UIButton *)sender
{
    self.selectedIndex = sender.tag - 100;
    
    if (self.SegmentClicked) {
        self.SegmentClicked(_selectedIndex);
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex == selectedIndex)
    {
        return;
    }
    
    UIButton *v = (UIButton *)[self viewWithTag:100+_selectedIndex];
    v.selected = NO;
    
    _selectedIndex = selectedIndex;
    
    v = (UIButton *)[self viewWithTag:100+_selectedIndex];
    v.selected = YES;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *v = [self viewWithTag:100+_selectedIndex];
    
    CATransform3D tm = CATransform3DMakeTranslation(v.frame.origin.x, self.frame.size.height+2, 0);
    tm = CATransform3DScale(tm, v.frame.size.width/_movementBar.bounds.size.width, 1.0, 1.0);
    
    _movementBar.transform = tm;
}

@end
