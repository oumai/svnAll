//
//  HotLocalView.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/20.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "HotLocalView.h"

 NSString *const kTitleKey = @"kTitleKey";
 NSString *const kListKey = @"kListKey";

@interface HotLocalView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, strong) NSArray *subList;
@property (nonatomic, strong) LocalTitle *localTitle;

@end

@implementation HotLocalView

-(id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.titles = [NSArray new];
        self.lists = [NSArray new];
        
        self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2, frame.size.height)];
        self.leftTableView.backgroundColor = [UIColor colorForHexString:@"#f7f7f7"];
        self.leftTableView.separatorColor = [UIColor colorForHexString:@"#e2e2e2"];
        self.leftTableView.delegate = self;
        self.leftTableView.dataSource = self;
        setExtraCellLineHidden(_leftTableView);
        [self addSubview:_leftTableView];
        
        self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width / 2, 0, frame.size.width / 2, frame.size.height)];
        self.rightTableView.backgroundColor = [UIColor colorForHexString:@"#eeeeee"];
        self.rightTableView.separatorColor = [UIColor colorForHexString:@"#e2e2e2"];
        self.rightTableView.delegate = self;
        self.rightTableView.dataSource = self;
        setExtraCellLineHidden(_rightTableView);
        [self addSubview:_rightTableView];
    }
    return self;
}

-(void) setInfoDict:(NSDictionary *)infoDict {
    if (nil == infoDict || [infoDict count] == 0 || [infoDict count] != 2) {
        return;
    }
    self.titles = infoDict[kTitleKey];
    self.lists = infoDict[kListKey];
    if ([_titles count] == 0 || [_lists count] == 0) {
        return;
    }
    
    LocalTitle *localTitle = _titles[0];
    self.localTitle = localTitle;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"dest_id==%@",localTitle.dest_id];
    self.subList = [_lists filteredArrayUsingPredicate:predicate];
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    
    //默认选中第一条记录
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - UITableViewDelegate DataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return [_titles count];
    }
    return [_subList count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identrifier_categroy_sub_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.textColor = [UIColor colorForHexString:@"#000000"];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, 61.0f)];
        bgView.backgroundColor = [UIColor colorForHexString:@"#eeeeee"];
        cell.selectedBackgroundView = bgView;
    }
    
    if (tableView == _leftTableView) {
        
        LocalTitle *localTitle = _titles[indexPath.row];
        cell.textLabel.text = localTitle.dest_name;

    }else if (tableView == _rightTableView) {
        LocalList *localList = _subList[indexPath.row];
        cell.textLabel.text = localList.local_name;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        
        LocalTitle *localTitle = _titles[indexPath.row];
        self.localTitle = localTitle;
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"dest_id==%@",localTitle.dest_id];
        self.subList = [_lists filteredArrayUsingPredicate:predicate];
        [self.rightTableView setContentOffset:CGPointMake(0, 0) animated:YES];
        [_rightTableView reloadData];
        return;
       
    }
    
    if ([_subList count] > 0) {
        LocalList *localList = _subList[indexPath.row];
        if (self.localSelectedBlock) {
            self.localSelectedBlock(_localTitle, localList);
        }
    }
}

@end
