//
//  GoodCategoriesViewController.m
//  QieYouShop
//
//  Created by 李赛强 on 15/3/18.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "GoodCategoriesViewController.h"
#import "FSDropDownMenu.h"
#import "UIViewController+SQPopupViewController.h"
#import "GoodCategoriesViewController.h"

@interface GoodCategoriesViewController ()<FSDropDownMenuDataSource,FSDropDownMenuDelegate>

@property (nonatomic, strong) FSDropDownMenu *menu;
@property (nonatomic, strong) NSArray *cateArr;
@property (nonatomic, strong) NSArray *cateDesArr;
@property (nonatomic, strong) NSArray *currentCateArr;
@property (nonatomic, strong) NSString *cate;

@end

@implementation GoodCategoriesViewController


-(void)dealloc {
    _menu = nil;
    _cateArr = nil;
    _cateDesArr = nil;
    _currentCateArr = nil;
    _cate = nil;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _cateArr = @[@"客栈酒店",@"美食饕餮",@"娱乐休闲",@"当地行",@"当地游",@"当地购",@"旅游险"];
        _cateDesArr = @[@[@"精品客栈",@"客栈",@"青年旅社",@"家庭旅馆",@"度假酒店",@"度假公寓"],
                        @[@"高端美食",@"当地美食",@"西餐",@"中餐",@"咖啡馆",@"小吃快餐",@"饮品"],
                        @[@"酒吧",@"茶楼",@"SPA水疗",@"足疗按摩",@"KTV",@"电影院"],
                        @[@"高端房车",@"私家车",@"代驾",@"接送机",@"拼车",@"火车票",@"摩托车",@"自行车"],
                        @[@"当地参团",@"主题摄影",@"个性玩法",@"户外探险",@"半日体验",@"景点门票",@"团队定制",@"私人定制",@"拓展培训"],
                        @[@"手造文化",@"工艺品",@"土特产",@"纪念品"],
                        @[@"户外险",@"境内险",@"境外险",@"领队险",@"团队险"]];
        _currentCateArr = _cateDesArr[0];
    }
    return self;
}

-(void) loadView {
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250.0f, 250.0f + 40.0f)];
    view.layer.cornerRadius = 4.0f;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor colorForHexString:@"#f7f7f7"];
    
    self.view = view;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *cancelButton = [UIButton ButtonItemWithTitle:@"取消" titleNormalColor:[UIColor colorForHexString:@"#33bc60"] titleHighColor:[UIColor grayColor] titleSize:12.0f frame:CGRectMake(8, 10, 30, 20) tag:0 target:self action:@selector(cancelButtonClicked:)];
    [self.view addSubview:cancelButton];
    
    UILabel *titleLabel = [UILabel LabelWithFrame:CGRectMake((250 - 80)/2, 10, 80, 20) text:@"商品类别" textColor:[UIColor colorForHexString:@"#33bc60"] font:13.0f textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLabel];
    
    self.menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 40) andWidth:250 andHeight:250];
    self.menu.delegate = self;
    self.menu.dataSource = self;
    [self.view addSubview:_menu];
    [_menu menuTapped];
    
}

-(void)cancelButtonClicked:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodCategoriesViewControllerDismiss:)]) {
        [self.delegate goodCategoriesViewControllerDismiss:self];
    }
}

#pragma mark - FSDropDown datasource & delegate

- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == menu.rightTableView) {
        return _cateArr.count;
    }else{
        return _currentCateArr.count;
    }
}
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == menu.rightTableView) {
        
        return _cateArr[indexPath.row];
    }else{
        return _currentCateArr[indexPath.row];
    }
}


- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == menu.rightTableView){
        _currentCateArr = _cateDesArr[indexPath.row];
        [menu.leftTableView reloadData];
        self.cate = _cateArr[indexPath.row];
    }else{
        NSString *cateDetail = _currentCateArr[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(goodCategoriesViewController:cate:cateDetail:)]) {
            [self.delegate goodCategoriesViewController:self cate:_cate cateDetail:cateDetail];
        }
    }
}

@end
