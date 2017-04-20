//
//  QYSPopMenusViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/23.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSPopMenusViewController.h"

@interface QYSPopMenusViewController ()

@property (nonatomic, strong) UIPopoverController *myPopverController;

@end

@implementation QYSPopMenusViewController

+ (UIPopoverController *)popverController:(id)delegate menus:(NSArray *)menus
{
    QYSPopMenusViewController *c = [[QYSPopMenusViewController alloc] init];
    c.actDelegate = delegate;
    c.menus = menus;
    
    UIPopoverController *pc = [[UIPopoverController alloc] initWithContentViewController:c];
    pc.popoverContentSize = CGSizeMake(300, 60*(menus.count>9?9:menus.count));
    c.myPopverController = pc;
    return pc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (UIPopoverController *)popverController
{
    return _myPopverController;
}

#pragma mark -

- (void)setMenus:(NSArray *)menus
{
    _menus = menus;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menus.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main-reorder-cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        cell.textLabel.font = FONT_NORMAL;
        cell.textLabel.textColor = COLOR_MAIN_BLACK;
        cell.indentationLevel = 2;
    }
    
    cell.textLabel.text = _menus[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(popMenusViewController:didSelectRowAtIndex:)])
    {
        [_actDelegate performSelector:@selector(popMenusViewController:didSelectRowAtIndex:) withObject:self withObject:@(indexPath.row)];
    }
}

@end
