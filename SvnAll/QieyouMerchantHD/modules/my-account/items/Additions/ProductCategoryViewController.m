//
//  ProductCategoryViewController.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/23.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductCategoryViewController.h"

@interface ProductCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, strong) NSArray *subList;

@property (nonatomic, strong) CategoryTitle *categoryTitle;

@end

@implementation ProductCategoryViewController

-(void)dealloc {
    _leftTableView = nil;
    _rightTableView = nil;
    _titles = nil;
    _lists = nil;
    _subList = nil;
    _categoryTitle = nil;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.titles = [NSArray new];
        self.lists = [NSArray new];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 350, 64)];
    navView.backgroundColor = [UIColor colorForHexString:@"#f0efed"];
    [self.view addSubview:navView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, navView.frame.size.height - 0.5f, navView.frame.size.width, 0.5f)];
    line.backgroundColor = [UIColor colorForHexString:@"#e2e2e2"];
    [navView addSubview:line];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorForHexString:@"#474747"] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    cancelButton.frame = CGRectMake(18, 0, 64, 64);
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:cancelButton];
    
    UILabel *titleLabel = [UILabel LabelWithFrame:CGRectMake((350 - 80)/2, (64 - 16) / 2, 80, 16) text:@"商品类别" textColor:[UIColor colorForHexString:@"#474747"] font:16.0f textAlignment:NSTextAlignmentCenter];
    [navView addSubview:titleLabel];
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 350 / 2, 500 - 64)];
    self.leftTableView.backgroundColor = [UIColor colorForHexString:@"#f7f7f7"];
    self.leftTableView.separatorColor = [UIColor colorForHexString:@"#e2e2e2"];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    setExtraCellLineHidden(_leftTableView);
    [self.view addSubview:_leftTableView];
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(350 / 2, 64, 350 / 2, 500 - 64)];
    self.rightTableView.backgroundColor = [UIColor colorForHexString:@"#eeeeee"];
    self.rightTableView.separatorColor = [UIColor colorForHexString:@"#e2e2e2"];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    setExtraCellLineHidden(_rightTableView);
    [self.view addSubview:_rightTableView];
    
    CityService *cityService = [CityService sharedCityService];
    
    [[OptionsService sharedOptionsService] getOPtionsWithCityCode:cityService.currentCity.city complete:^(NSArray *categoryTitles, NSArray *categoryList, NSArray *localTitles, NSArray *localList) {
        self.titles = categoryTitles;
        self.lists = categoryList;
        
        if ([_titles count] == 0 || [_lists count] == 0) {
            return;
        }
        
        self.categoryTitle = _titles[0];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"category==%@",_categoryTitle.id];
        self.subList = [_lists filteredArrayUsingPredicate:predicate];
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        
        //默认选中第一条记录
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    } error:^(NSString *error) {
        
    }];
}

#pragma mark - Actions

-(void) cancel:(UIButton *)sender {
    if (self.dismissBlock) {
        self.dismissBlock(self);
    }
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
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 350 / 2, 61.0f)];
        bgView.backgroundColor = [UIColor colorForHexString:@"#eeeeee"];
        cell.selectedBackgroundView = bgView;
    }
    
    if (tableView == _leftTableView) {
        
        CategoryTitle *categoryTitle = _titles[indexPath.row];
        cell.textLabel.text = categoryTitle.name;
        
    }else if (tableView == _rightTableView) {
        CategoryList *categoryList = _subList[indexPath.row];
        cell.textLabel.text = categoryList.name;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        
        CategoryTitle *categoryTitle = _titles[indexPath.row];
        self.categoryTitle = categoryTitle;
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"category==%@",_categoryTitle.id];
        self.subList = [_lists filteredArrayUsingPredicate:predicate];
        [self.rightTableView setContentOffset:CGPointMake(0, 0) animated:YES];
        [_rightTableView reloadData];
        return;
    }
    
    if ([_subList count] > 0) {
        CategoryList *categoryList = _subList[indexPath.row];
        if (self.productCategoryClickedBlock) {
            self.productCategoryClickedBlock(self,_categoryTitle, categoryList);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
