//
//  QYSSegmentedControl.m
//  QieYouShop
//
//  Created by Vincent on 3/16/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSSegmentedControl.h"

@interface QYSSegmentedControl ()

@property (nonatomic, strong) NSMutableArray *titleItems;

@property (nonatomic, strong) CALayer *scrollBGLayer;

@end

@implementation QYSSegmentedControl

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 4.0;
        self.layer.borderColor = COLOR_HEX2RGB(0x17964d).CGColor;
        self.layer.masksToBounds = YES;
        
        self.titleItems = [NSMutableArray arrayWithArray:items];
        
        self.scrollBGLayer = [CALayer layer];
        [self.layer addSublayer:_scrollBGLayer];
        
        {
            CGFloat w = self.frame.size.width/_titleItems.count;
            
            UILabel *lb;
            int i=0;
            for (NSString *title in _titleItems)
            {
                lb = [[UILabel alloc] initWithFrame:CGRectMake(w*i, 0, w, self.frame.size.height)];
                lb.tag = 100 + i;
                lb.text = title;
                lb.backgroundColor = COLOR_MAIN_CLEAR;
                if (_itemFont)
                {
                    lb.font = _itemFont;
                }
                else
                {
                    lb.font = FONT_NORMAL_14;
                }
                [self addSubview:lb];
                
                i++;
            }
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.borderColor = _tintColor.CGColor;
    
    CGFloat w = self.frame.size.width/_titleItems.count;
    
    _scrollBGLayer.backgroundColor = _tintColor.CGColor;
    _scrollBGLayer.frame = CGRectMake(w*_selectedSegmentIndex, 0, w, self.frame.size.height);
    
    UILabel *lb;
    int i=0;
    for (NSString *title in _titleItems)
    {
        lb = (UILabel *)[self viewWithTag:100+i];
        lb.frame = CGRectMake(w*i, 0, w, self.frame.size.height);
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = title;
        lb.textColor = _tintColor;
        if (_itemFont)
        {
            lb.font = _itemFont;
        }
        else
        {
            lb.font = FONT_NORMAL_13;
        }
        
        i++;
    }
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    if (selectedSegmentIndex >= _titleItems.count)
    {
        return;
    }
    
    if (-1 == _selectedSegmentIndex)
    {
        return;
    }
    else
    {
        UILabel *lb = (UILabel *)[self viewWithTag:100+_selectedSegmentIndex];
        lb.textColor = _tintColor;
    }
    
    _selectedSegmentIndex = selectedSegmentIndex;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    if (-1 == selectedSegmentIndex)
    {
        return;
    }
    
    [self layoutIfNeeded];
    
    UILabel *lb = (UILabel *)[self viewWithTag:100+selectedSegmentIndex];
    lb.textColor = COLOR_MAIN_WHITE;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self];
    
    UILabel *lb;
    for (int i=0;i<_titleItems.count;i++)
    {
        lb = (UILabel *)[self viewWithTag:100+i];
        if (CGRectContainsPoint(lb.frame, p))
        {
            self.selectedSegmentIndex = i;
            
            _scrollBGLayer.frame = lb.frame;
        }
    }
}

//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//}


@end
