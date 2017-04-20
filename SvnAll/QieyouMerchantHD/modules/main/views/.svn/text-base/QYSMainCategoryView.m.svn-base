//
//  QYSMainCategoryView.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/1/28.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMainCategoryView.h"

#pragma mark -

@interface VCTDragGesture ()

@property (nonatomic, assign) BOOL startMoved;

@end

@implementation VCTDragGesture

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([[event touchesForWindow:[UIApplication sharedApplication].keyWindow] count] >= 2)
    {
        return;
    }
    
    UITouch *t = [touches anyObject];
    _startPoint = [t locationInView:t.window];
    CGFloat tmp;
    
    if (IS_LESS_THAN_IOS7)
    {
        if (UIDeviceOrientationLandscapeLeft == [UIDevice currentDevice].orientation)
        {
            tmp = _startPoint.y;
            _startPoint.y = t.window.bounds.size.height-_startPoint.x;
            _startPoint.x = tmp;
        }
        else if (UIDeviceOrientationLandscapeRight == [UIDevice currentDevice].orientation)
        {
            tmp = _startPoint.x;
            _startPoint.x = t.window.bounds.size.height-_startPoint.y;
            _startPoint.y = tmp;
        }
        
#if TARGET_IPHONE_SIMULATOR
        tmp = _startPoint.x;
        _startPoint.x = t.window.bounds.size.height-_startPoint.y;
        _startPoint.y = tmp;
#endif
    }
    
    if (!_isOpened)
    {
        if (_startPoint.x >= 8.0)
        {
            self.state = UIGestureRecognizerStateFailed;
            return;
        }
        
        self.state = UIGestureRecognizerStateBegan;
        
        if (_actDelegate && [_actDelegate respondsToSelector:@selector(dragGestureOpenBegan:)])
        {
            [_actDelegate performSelector:@selector(dragGestureOpenBegan:) withObject:self];
        }
    }
    else
    {
        if (CGRectContainsPoint(_useableArea, _startPoint))
        {
            self.state = UIGestureRecognizerStateFailed;
            return;
        }
        
        self.state = UIGestureRecognizerStateBegan;
        
        if (_actDelegate && [_actDelegate respondsToSelector:@selector(dragGestureCloseBegan:)])
        {
            [_actDelegate performSelector:@selector(dragGestureCloseBegan:) withObject:self];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([[event touchesForWindow:[UIApplication sharedApplication].keyWindow] count] >= 2)
    {
        return;
    }
    
    UITouch *t = [touches anyObject];
    _currPoint = [t locationInView:t.window];
    
    CGFloat tmp;
    
    if (IS_LESS_THAN_IOS7)
    {
        if (UIDeviceOrientationLandscapeLeft == [UIDevice currentDevice].orientation)
        {
            tmp = _currPoint.y;
            _currPoint.y = t.window.bounds.size.height-_currPoint.x;
            _currPoint.x = tmp;
        }
        else if (UIDeviceOrientationLandscapeRight == [UIDevice currentDevice].orientation)
        {
            tmp = _currPoint.x;
            _currPoint.x = t.window.bounds.size.height-_currPoint.y;
            _currPoint.y = tmp;
        }
        
#if TARGET_IPHONE_SIMULATOR
        tmp = _currPoint.x;
        _currPoint.x = t.window.bounds.size.height-_currPoint.y;
        _currPoint.y = tmp;
#endif
    }
    
    if (!_isOpened)
    {
        if (!CGRectContainsPoint(_useableArea, _startPoint))
        {
            return;
        }
        
        if (_actDelegate)
        {
            [_actDelegate performSelector:@selector(dragGestureOpenMove:) withObject:self];
        }
    }
    else
    {
//        if (_currPoint.x>=_startPoint.x)
//        {
//            return;
//        }
        
        if (_actDelegate)
        {
            [_actDelegate performSelector:@selector(dragGestureCloseMove:) withObject:self];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([[event touchesForWindow:[UIApplication sharedApplication].keyWindow] count] >= 2)
    {
        return;
    }
    
    UITouch *t = [touches anyObject];
    _currPoint = [t locationInView:t.window];
    
    CGFloat tmp;
    
    if (IS_LESS_THAN_IOS7)
    {
        if (UIDeviceOrientationLandscapeLeft == [UIDevice currentDevice].orientation)
        {
            tmp = _currPoint.y;
            _currPoint.y = t.window.bounds.size.height-_currPoint.x;
            _currPoint.x = tmp;
        }
        else if (UIDeviceOrientationLandscapeRight == [UIDevice currentDevice].orientation)
        {
            tmp = _currPoint.x;
            _currPoint.x = t.window.bounds.size.height-_currPoint.y;
            _currPoint.y = tmp;
        }
        
#if TARGET_IPHONE_SIMULATOR
        tmp = _currPoint.x;
        _currPoint.x = t.window.bounds.size.height-_currPoint.y;
        _currPoint.y = tmp;
#endif
    }
    
    self.state = UIGestureRecognizerStateEnded;
    
    if (!_isOpened)
    {
        _isOpened = YES;
        if (_actDelegate)
        {
            [_actDelegate performSelector:@selector(dragGestureOpenEnd:) withObject:self];
        }
    }
    else
    {
        _isOpened = NO;
        if (_actDelegate)
        {
            [_actDelegate performSelector:@selector(dragGestureCloseEnd:) withObject:self];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateCancelled;
}

@end

#pragma mark - QYSMainCategoryCell

@interface QYSMainCategoryCell : UITableViewCell

@property (nonatomic, assign) BOOL isChecked;

@end

@implementation QYSMainCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *sel_v = [[UIView alloc] init];
        sel_v.backgroundColor = COLOR_RGBA(0, 0, 0, 0.8);
        self.selectedBackgroundView = sel_v;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(94.0, 0.0, self.textLabel.bounds.size.width, self.bounds.size.height);
    self.imageView.center = CGPointMake(62.0, 30.0);
    self.accessoryView.center = CGPointMake(195.0, 30.0);
    
    if (_isChecked)
    {
        [UIView animateWithDuration:0.15
                         animations:^{
                             self.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
                         }];
    }
}

@end

#pragma mark - QYSMainCategoryView

@interface QYSMainCategoryView () <UITableViewDataSource, UITableViewDelegate>



@property (nonatomic, assign) NSInteger selectedSection;
@property (nonatomic, strong) NSString *cate;
@property (nonatomic, strong) NSString *cateDetail;

@end

@implementation QYSMainCategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self)
    {
        _selectedSection = -1;
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main-category-logo"]];
        iv.frame = CGRectMake(0, 0, frame.size.width, 95);
        iv.contentMode = UIViewContentModeTop;
        
        self.contentInset = UIEdgeInsetsMake(20.0, 0, 0, 0);
        self.backgroundColor = COLOR_RGBA(0.0, 0.0, 0.0, 0.89);
        
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = iv;
        self.dataSource = self;
        self.delegate = self;
        
        UISwipeGestureRecognizer *g = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onMainCategorySwapGesture:)];
        g.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:g];
    }
    return self;
}

- (NSArray *)menus
{
    return _subMenusArray[_selectedSection];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _menusArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger c = 0;
    
    if (-1 == _selectedSection || _selectedSection != section)
    {
        c = 0;
    }
    else
    {
        c = [_subMenusArray[_selectedSection] count];
    }
    
    return c;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QYSMainCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main-category-cell"];
    if (!cell)
    {
        cell = [[QYSMainCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"main-category-cell"];
        cell.backgroundColor = COLOR_MAIN_CLEAR;
        cell.textLabel.textColor = COLOR_HEX2RGB(0xcccccc);
        cell.textLabel.font = FONT_WITH_SIZE(19.0);
        [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapCategoryHeaderView:)]];
    }
    
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main-category-arrow"]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"main-category-icon%02ld", section+1]];
    
    CategoryTitle *cTitle  = _menusArray[section];
    cell.textLabel.text = cTitle.name;
    cell.frame = CGRectMake(0, 0, self.bounds.size.width, 83.0f);
    cell.tag = 100 + section;
    
    if (cell.tag == _selectedSection+100)
    {
        cell.isChecked = YES;
    }
    else
    {
        cell.isChecked = NO;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSMainCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main-category-cell2"];
    if (!cell)
    {
        cell = [[QYSMainCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"main-category-cell2"];
        cell.backgroundColor = COLOR_MAIN_CLEAR;
        cell.textLabel.textColor = COLOR_HEX2RGB(0xb2b2b1);
        cell.textLabel.font = FONT_WITH_SIZE(16.0);
    }
    
    cell.accessoryView = nil;
    CategoryList *cList = _subMenusArray[indexPath.section][indexPath.row];
    cell.textLabel.text = cList.name;;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(mainCategoryView:didSelectRowAtIndex:)])
    {
        [_actDelegate performSelector:@selector(mainCategoryView:didSelectRowAtIndex:) withObject:self withObject:@(indexPath.row)];
    }
     */
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(mainCategoryView:didSelectRowAtIndexPath:)]) {
        [_actDelegate performSelector:@selector(mainCategoryView:didSelectRowAtIndexPath:) withObject:self withObject:indexPath];
    }
}

#pragma mark -

- (void)onTapCategoryHeaderView:(UITapGestureRecognizer *)gesture
{
    if (_selectedSection == gesture.view.tag-100)
    {
        _selectedSection = -1;
        [self reloadData];
        return;
    }
    
    
    _selectedSection = gesture.view.tag - 100;
    [self reloadData];
    
    [self scrollRectToVisible:gesture.view.frame animated:YES];
}

- (void)onMainCategorySwapGesture:(UIGestureRecognizer *)gesture
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(mainCategoryViewDidClose:)])
    {
        [_actDelegate performSelector:@selector(mainCategoryViewDidClose:) withObject:self];
    }
}

@end
