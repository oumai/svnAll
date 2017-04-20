//
//  QYSPopLocationMenusViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/3/7.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSPopLocationMenusViewController.h"

#pragma mark -

typedef enum {
    QYSPopLocationMenusCellTypeI = 0,
    QYSPopLocationMenusCellTypeII
} QYSPopLocationMenusCellType;

@interface QYSPopLocationMenusCell : UITableViewCell

@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSString *extString;
@property (nonatomic, strong) UILabel *extLabel;

@end

@implementation QYSPopLocationMenusCell

- (instancetype)initWithType:(QYSPopLocationMenusCellType)type reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (QYSPopLocationMenusCellTypeI == type)
        {
            UIImage *im = [[UIImage imageNamed:@"main-loc-menu-cell-bg01"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            UIImage *im_h = [[UIImage imageNamed:@"main-loc-menu-cell-bg02"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            self.backgroundView = [[UIImageView alloc] initWithImage:im];
            self.selectedBackgroundView = [[UIImageView alloc] initWithImage:im_h];
        }
        else
        {
            UIImage *im = [[UIImage imageNamed:@"main-loc-menu-cell-bg02"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            self.backgroundView = [[UIImageView alloc] initWithImage:im];
            self.selectedBackgroundView = [[UIImageView alloc] initWithImage:im];
        }
        
        self.extLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _extLabel.textColor = COLOR_MAIN_WHITE;
        _extLabel.font = FONT_NORMAL_13;
        _extLabel.layer.cornerRadius = 7.0;
        _extLabel.layer.masksToBounds = YES;
        _extLabel.backgroundColor = COLOR_MAIN_CLEAR;
        _extLabel.textAlignment = NSTextAlignmentCenter;
        
        self.textLabel.font = FONT_NORMAL;
        self.textLabel.textColor = COLOR_TEXT_BLACK;
    }
    return self;
}

- (void)layoutSubviews
{
    if (_extString)
    {
        _extLabel.text = [NSString stringWithFormat:@"  %@ >  ", _extString];
        _extLabel.frame = CGRectMake(0, 0, 73, 16);
        self.accessoryView = _extLabel;
    }
    else
    {
        _extLabel.frame = CGRectZero;
        self.accessoryView = nil;
    }
    
    [super layoutSubviews];
    
    _extLabel.backgroundColor = COLOR_HEX2RGB(0xd3d2cf);
}

@end

#pragma mark - QYSPopLocationMenusViewController

@interface QYSPopLocationMenusViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIPopoverController *myPopverController;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CALayer *movementBar;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) NSInteger selectedRow1;
@property (nonatomic, assign) NSInteger selectedRow2;

@end

@implementation QYSPopLocationMenusViewController

+ (UIPopoverController *)popverController:(id)delegate data:(NSArray *)data
{
    QYSPopLocationMenusViewController *c = [[QYSPopLocationMenusViewController alloc] init];
    c.actDelegate = delegate;
    
    UIPopoverController *pc = [[UIPopoverController alloc] initWithContentViewController:c];
    pc.popoverContentSize = CGSizeMake(400, 480);
    c.myPopverController = pc;
    c.data = data;
    return pc;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 480)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_HEX2RGB(0xe2e2e2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (UIPopoverController *)popverController
{
    return _myPopverController;
}

- (void)setData:(NSArray *)data
{
    _data = data;
    
    UIView *head_v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    head_v.backgroundColor = COLOR_MAIN_WHITE;
    [self.view addSubview:head_v];
    
    {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.translatesAutoresizingMaskIntoConstraints = NO;
        btn1.titleLabel.font = FONT_NORMAL;
        btn1.titleLabel.textColor = COLOR_TEXT_ORANGE;
        [btn1 setTitleColor:COLOR_TEXT_ORANGE forState:UIControlStateNormal];
        [btn1 setTitle:@"热门景点商圈" forState:UIControlStateNormal];
        btn1.tag = 300;
        [btn1 addTarget:self action:@selector(btnSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
        [head_v addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.translatesAutoresizingMaskIntoConstraints = NO;
        btn2.titleLabel.font = FONT_NORMAL;
        [btn2 setTitleColor:COLOR_TEXT_ORANGE forState:UIControlStateNormal];
        [btn2 setTitle:@"街区" forState:UIControlStateNormal];
        btn2.tag = 301;
        [btn2 addTarget:self action:@selector(btnSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
        [head_v addSubview:btn2];
        
        UIView *line = [[UIView alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = COLOR_MAIN_BORDER_GRAY;
        [head_v addSubview:line];
        
        UIView *line2 = [[UIView alloc] init];
        line2.translatesAutoresizingMaskIntoConstraints = NO;
        line2.backgroundColor = COLOR_MAIN_BORDER_GRAY;
        [head_v addSubview:line2];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(btn1,btn2,line,line2);
        [head_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[btn1]-(0@999)-[line(1)][btn2(btn1)]|" options:0 metrics:nil views:vds]];
        [head_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line2]|" options:0 metrics:nil views:vds]];
        [head_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn1]|" options:0 metrics:nil views:vds]];
        [head_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[line]|" options:0 metrics:nil views:vds]];
        [head_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn2]|" options:0 metrics:nil views:vds]];
        [head_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line2(1)]|" options:0 metrics:nil views:vds]];
        
        [head_v addConstraint:[NSLayoutConstraint constraintWithItem:btn1
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:head_v
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:0.5
                                                            constant:-1.0]];
        
        self.movementBar = [CALayer layer];
        self.movementBar.frame = CGRectMake(0, 56, 200, 3);
        
        CALayer *color_bar = [CALayer layer];
        color_bar.frame = CGRectMake(12, 0, 175, 3);
        color_bar.backgroundColor = COLOR_TEXT_ORANGE.CGColor;
        [_movementBar addSublayer:color_bar];
        
        [head_v.layer addSublayer:_movementBar];
    }
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-60)];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*2, _scrollView.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.tag = 201;
    [self.view addSubview:_scrollView];
    
    UITableView *tv;
    UITableView *tv2;
    for (int i=0; i<4; i++)
    {
        tv = [[UITableView alloc] initWithFrame:CGRectMake((tv?tv.frame.origin.x+tv.frame.size.width+(0==i%2?0:1):0), 0, (0==i%2?200:199), _scrollView.bounds.size.height) style:UITableViewStylePlain];
        tv.tag = 100+i;
        tv.separatorStyle = UITableViewCellSeparatorStyleNone;
        tv.delegate = self;
        tv.dataSource = self;
        [_scrollView addSubview:tv];
        tv2 = tv;
    }
    
    tv = (UITableView *)[_scrollView viewWithTag:100];
    [tv selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    tv = (UITableView *)[_scrollView viewWithTag:102];
    [tv selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger c = 0;
    
    switch (tableView.tag)
    {
        case 100:
            c = [_data[0] count];
            break;
            
        case 101:
        {
            c = [_data[0][_selectedRow1][@"menus"] count];
        }
            break;
            
        case 102:
            c = [_data[1] count];
            break;
            
        case 103:
        {
            c = [_data[1][_selectedRow2][@"menus"] count];
        }
            break;
    }
    
    return c;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSPopLocationMenusCell *cell;
    
    if (0 == tableView.tag%2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"main-loc-menus-cellI"];
        if (!cell)
        {
            cell = [[QYSPopLocationMenusCell alloc] initWithType:QYSPopLocationMenusCellTypeI reuseIdentifier:@"main-loc-menus-cellI"];
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"main-loc-menus-cellII"];
        if (!cell)
        {
            cell = [[QYSPopLocationMenusCell alloc] initWithType:QYSPopLocationMenusCellTypeII reuseIdentifier:@"main-loc-menus-cellII"];
        }
    }
    
    switch (tableView.tag)
    {
        case 100:
        {
            cell.textLabel.text = _data[0][indexPath.row][@"title"];
            
            if (_data[0][indexPath.row][@"ext-string"])
            {
                cell.extString = _data[0][indexPath.row][@"ext-string"];
            }
            else
            {
                cell.extString = nil;
            }

        }
            break;
            
        case 101:
        {
            cell.textLabel.text = _data[0][_selectedRow1][@"menus"][indexPath.row][@"title"];
            cell.extString = nil;
        }
            break;
            
        case 102:
            cell.textLabel.text = _data[1][indexPath.row][@"title"];
            cell.extString = nil;
            break;
            
        case 103:
        {
            cell.textLabel.text = _data[1][_selectedRow2][@"menus"][indexPath.row][@"title"];
            cell.extString = nil;
        }
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == tableView.tag%2)
    {
        if (100 == tableView.tag)
        {
            _selectedRow1 = indexPath.row;
        }
        else
        {
            _selectedRow2 = indexPath.row;
        }
        
        UITableView *tv = (UITableView *)[_scrollView viewWithTag:tableView.tag+1];
        [tv reloadData];
        
        return;
    }
    
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(popLocationMenusViewController:didSelectData:)])
    {
        id data = nil;
        
        if (101 == tableView.tag)
        {
            data = _data[0][_selectedRow1][@"menus"][indexPath.row];
        }
        else
        {
            data = _data[1][_selectedRow2][@"menus"][indexPath.row];
        }
        
        [_actDelegate performSelector:@selector(popLocationMenusViewController:didSelectData:) withObject:self withObject:data];
    }
}

#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (201 != scrollView.tag)
    {
        return;
    }
    
    [CATransaction setAnimationDuration:0.0];
    _movementBar.transform = CATransform3DMakeTranslation(scrollView.contentOffset.x/400*200, 0, 0);
}

#pragma mark -

- (void)btnSwitchClick:(UIButton *)sender
{
    NSInteger idx = sender.tag - 300;
    
//    UITableView *tv = (UITableView *)[_scrollView viewWithTag:(0==idx?100:102)];
//    [tv reloadData];
    
    [_scrollView scrollRectToVisible:CGRectMake(idx*_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height) animated:YES];
}

@end
