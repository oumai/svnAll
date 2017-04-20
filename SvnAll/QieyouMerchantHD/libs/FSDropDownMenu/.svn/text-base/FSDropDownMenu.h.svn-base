//
//  FSDropDownMenu.h
//  FSDropDownMenu
//
//  Created by 李赛强 on 14/12/24.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSDropDownMenu;

@protocol FSDropDownMenuDataSource <NSObject>

@required
- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - delegate
@protocol FSDropDownMenuDelegate <NSObject>
@optional
- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface FSDropDownMenu : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) UIView *transformView;

@property (nonatomic, weak) id <FSDropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <FSDropDownMenuDelegate> delegate;

- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;
- (instancetype)initWithOrigin:(CGPoint)origin andWidth:(CGFloat)width andHeight:(CGFloat)height;

-(void)menuTapped;
- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender;

@end

