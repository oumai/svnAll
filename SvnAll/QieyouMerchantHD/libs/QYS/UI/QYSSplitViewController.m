//
//  QYSSplitViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/11.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSSplitViewController.h"

#pragma mark - QYSSplitViewMenuCell

@interface QYSSplitViewMenuCell : UITableViewCell

@property (nonatomic, strong) UIView *selectedView;

@end

@implementation QYSSplitViewMenuCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if ([self respondsToSelector:@selector(preservesSuperviewLayoutMargins)])
        {
            self.preservesSuperviewLayoutMargins = NO;
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)])
        {
            self.layoutMargins = UIEdgeInsetsZero;
        }
        
        self.clipsToBounds = YES;
        self.backgroundColor = COLOR_HEX2RGB(0xfcfcfc);
        self.separatorInset = UIEdgeInsetsZero;
        
        self.textLabel.textColor = COLOR_HEX2RGB(0x5a5a5a);
        self.textLabel.font = FONT_WITH_SIZE(16.0);
        self.indentationLevel = 6;
        
        UIView *selected_v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 255, 60.5)];
        selected_v.backgroundColor = COLOR_HEX2RGB(0xfcfcfc);
        selected_v.clipsToBounds = YES;
        
        UIView *orange_v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 60.5)];
        orange_v.backgroundColor = COLOR_HEX2RGB(0xec6941);
        [selected_v addSubview:orange_v];
        
        self.selectedView = selected_v;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        __weak typeof(self) weak_self = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weak_self.contentView addSubview:weak_self.selectedView];
            [weak_self.contentView sendSubviewToBack:weak_self.selectedView];
        });
    }
    else
    {
        [_selectedView removeFromSuperview];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect f = self.textLabel.frame;
    f.origin.x = 54;
    
    self.textLabel.frame = f;
}

@end

#pragma mark - QYSSplitViewController

@interface QYSSplitViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) CGRect currCellFrame;
@property (nonatomic, strong) UIView *orange_v;

@end

@implementation QYSSplitViewController

- (instancetype)initWithMenus:(NSArray *)menus
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.menus = menus;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    UILabel *lb = (UILabel *)self.navigationItem.titleView;
    lb.font = FONT_WITH_SIZE(21);
    
    self.menuTableView = [[UITableView alloc] init];
    self.menuTableView.backgroundColor = COLOR_MAIN_WHITE;
    self.menuTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    self.menuTableView.backgroundColor = COLOR_HEX2RGB(0xfcfcfc);
    self.menuTableView.tableFooterView = [[UIView alloc] init];
    self.menuTableView.separatorInset = UIEdgeInsetsMake(0, 1, 0, 1);
    self.menuTableView.separatorColor = COLOR_MAIN_BORDER_GRAY;
    self.menuTableView.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
    self.menuTableView.layer.borderWidth = 0.5;
    [self.view addSubview:self.menuTableView];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.clipsToBounds = YES;
    [self.view addSubview:self.contentView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[m_table(255)][content_v]|" options:0 metrics:nil views:@{@"m_table":self.menuTableView,@"content_v":self.contentView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[m_table]-(-1)-|" options:0 metrics:nil views:@{@"m_table":self.menuTableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[content_v]|" options:0 metrics:nil views:@{@"content_v":self.contentView}]];
    
    [self.menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    self.orange_v = [[UIView alloc] initWithFrame:CGRectMake(_currCellFrame.origin.x, _currCellFrame.origin.y, 10, 60.5)];
    self.orange_v.backgroundColor = COLOR_HEX2RGB(0xec6941);
    [self.menuTableView addSubview:_orange_v];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)setMenus:(NSArray *)menus
{
    _menus = menus;
    [self.menuTableView reloadData];
}

- (void)setSelectedMenuIndex:(NSInteger)selectedMenuIndex
{
    _selectedMenuIndex = selectedMenuIndex;
    [self.menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedMenuIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    self.orange_v.frame = CGRectMake(_currCellFrame.origin.x, selectedMenuIndex * 60.5f, 10.0f, 60.5f);
    [self onSelectedMenuAtIndex:selectedMenuIndex];
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    if (_contentViewController)
    {
        [_contentViewController viewWillDisappear:NO];
        [_contentViewController.view removeFromSuperview];
        [_contentViewController viewDidDisappear:NO];
    }
    
    _contentViewController = contentViewController;
    
    [self.view layoutIfNeeded];
    
    _contentViewController.view.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    [_contentViewController viewWillAppear:NO];
    [self.contentView addSubview:_contentViewController.view];
    [_contentViewController viewDidAppear:NO];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menus.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        return 61.0;
    }
    
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSSplitViewMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-fav-menu-cell"];
    if (!cell)
    {
        cell = [[QYSSplitViewMenuCell alloc] initWithReuseIdentifier:@"my-fav-menu-cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.menus[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    _currCellFrame = cell.frame;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.orange_v.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 10, 60.5);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                            
                         }
                     }];
    
    _currCellFrame = cell.frame;
    self.selectedMenuIndex = indexPath.row;
    [self onSelectedMenuAtIndex:indexPath.row];
}

#pragma mark -

- (void)onSelectedMenuAtIndex:(NSInteger)index
{
    
}

@end
