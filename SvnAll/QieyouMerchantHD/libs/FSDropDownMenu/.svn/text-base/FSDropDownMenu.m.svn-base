//
//  FSDropDownMenu.m
//  FSDropDownMenu
//
//  Created by 李赛强 on 14/12/24.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import "FSDropDownMenu.h"


@interface FSDropDownMenu()


@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, assign) CGFloat menuWidth;

@end

#define ScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)

@implementation FSDropDownMenu

#pragma mark - init method
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, 0)];
    if (self) {
        _origin = origin;
        _show = NO;
        _height = height;
        self.menuWidth = ScreenWidth;
        
        //tableView init
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x+_menuWidth*0.5, self.frame.origin.y + self.frame.size.height, _menuWidth*0.5, 0) style:UITableViewStylePlain];
        _leftTableView.rowHeight = 42;
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.separatorColor = [UIColor colorForHexString:@"#e2e2e2"];
        _leftTableView.backgroundColor = [UIColor colorForHexString:@"#f7f7f7"];
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x, self.frame.origin.y + self.frame.size.height, _menuWidth*0.5, 0) style:UITableViewStylePlain];
        _rightTableView.rowHeight = 42;
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        _rightTableView.separatorColor = [UIColor colorForHexString:@"#e2e2e2"];
        _rightTableView.backgroundColor = [UIColor colorForHexString:@"#f7f7f7"];

        //self tapped
        self.backgroundColor = [UIColor colorForHexString:@"#eeeeee"];;
        
        //add bottom shadow
        UIView *bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, screenSize.width, 0.5)];
        bottomShadow.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomShadow];
    }
    return self;
}

- (instancetype)initWithOrigin:(CGPoint)origin andWidth:(CGFloat)width andHeight:(CGFloat)height{
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, width, 0)];
    if (self) {
        _origin = origin;
        _show = NO;
        _height = height;
        self.menuWidth = width;
        
        //tableView init
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x+_menuWidth*0.5, self.frame.origin.y + self.frame.size.height,_menuWidth*0.5, 0) style:UITableViewStylePlain];
        _leftTableView.rowHeight = 42;
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.separatorColor = [UIColor colorForHexString:@"#e2e2e2"];
        _leftTableView.backgroundColor = [UIColor colorForHexString:@"#f7f7f7"];
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x, self.frame.origin.y + self.frame.size.height, _menuWidth*0.5, 0) style:UITableViewStylePlain];
        _rightTableView.rowHeight = 42;
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        _rightTableView.separatorColor = [UIColor colorForHexString:@"#e2e2e2"];
        _rightTableView.backgroundColor = [UIColor colorForHexString:@"#f7f7f7"];
        
        
        //self tapped
        self.backgroundColor = [UIColor colorForHexString:@"#eeeeee"];;
        
        //        //background init and tapped
        //        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, screenSize.height)];
        //        _backGroundView.backgroundColor = [UIColor colorForHexString:@"#eeeeee"];
        //        _backGroundView.opaque = NO;
        //        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        //        [_backGroundView addGestureRecognizer:gesture];
        
        //add bottom shadow
        UIView *bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, width, 0.5)];
        bottomShadow.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomShadow];
    }
    return self;
}



#pragma mark - gesture handle

- (void)menuTapped{
    if (!_show) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.rightTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    [self animateBackGroundView:self.backGroundView show:!_show complete:^{
        [self animateTableViewShow:!_show complete:^{
            [self tableView:self.rightTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            _show = !_show;
        }];
    }];

}

- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender
{
    [self animateBackGroundView:_backGroundView show:NO complete:^{
        [self animateTableViewShow:NO complete:^{
            _show = NO;
            
        }];
    }];
}

#pragma mark - animation method


- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

- (void)animateTableViewShow:(BOOL)show complete:(void(^)())complete {
    if (show) {

        _leftTableView.frame = CGRectMake(self.origin.x+_menuWidth*0.5, self.frame.origin.y, _menuWidth*0.5, 0);
        [self.superview addSubview:_leftTableView];
        _rightTableView.frame = CGRectMake(self.origin.x, self.frame.origin.y, _menuWidth*0.5, 0);
        [self.superview addSubview:_rightTableView];
        
        _leftTableView.alpha = 1.f;
        _rightTableView.alpha = 1.f;
        [UIView animateWithDuration:0.2 animations:^{
            _leftTableView.frame = CGRectMake(self.origin.x+_menuWidth*0.5, self.frame.origin.y, _menuWidth*0.5, _height);
            _rightTableView.frame = CGRectMake(self.origin.x, self.frame.origin.y, _menuWidth*0.5, _height);
            if (self.transformView) {
                self.transformView.transform = CGAffineTransformMakeRotation(M_PI);
            }
        } completion:^(BOOL finished) {
            
        }];
    } else {

        [UIView animateWithDuration:0.2 animations:^{
            _leftTableView.alpha = 0.f;
            _rightTableView.alpha = 0.f;
            if (self.transformView) {
                self.transformView.transform = CGAffineTransformMakeRotation(0);
            }
        } completion:^(BOOL finished) {
            [_leftTableView removeFromSuperview];
            [_rightTableView removeFromSuperview];
        }];
    }
    complete();
}


#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSAssert(self.dataSource != nil, @"menu's dataSource shouldn't be nil");
    if ([self.dataSource respondsToSelector:@selector(menu:tableView:numberOfRowsInSection:)]) {
        return [self.dataSource menu:self tableView:tableView
                numberOfRowsInSection:section];
    } else {
        NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DropDownMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSAssert(self.dataSource != nil, @"menu's datasource shouldn't be nil");
    if ([self.dataSource respondsToSelector:@selector(menu:tableView:titleForRowAtIndexPath:)]) {
        cell.textLabel.text = [self.dataSource menu:self tableView:tableView titleForRowAtIndexPath:indexPath];
    } else {
        NSAssert(0 == 1, @"dataSource method needs to be implemented");
    }
    if(tableView == _leftTableView){
        cell.backgroundColor = [UIColor colorForHexString:@"#eeeeee"];
    }else{
        UIView *sView = [[UIView alloc] init];
        sView.backgroundColor = [UIColor colorForHexString:@"#eeeeee"];
        cell.selectedBackgroundView = sView;
        cell.backgroundColor = [UIColor colorForHexString:@"#f7f7f7"];
        [cell setSelected:YES animated:NO];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.textColor = [UIColor colorForHexString:@"#333333"];
    

    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate || [self.delegate respondsToSelector:@selector(menu:tableView:didSelectRowAtIndexPath:)]) {
        if (tableView == self.leftTableView) {
            [self animateBackGroundView:_backGroundView show:NO complete:^{
                [self animateTableViewShow:NO complete:^{
                    _show = NO;
                }];
            }];
        }
        [self.delegate menu:self tableView:tableView didSelectRowAtIndexPath:indexPath];
    } else {
        //TODO: delegate is nil
    }
}

@end

