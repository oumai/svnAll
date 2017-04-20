//
//  QYSMyCustomersViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/4/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSMyCustomersViewController.h"

#pragma mark - QYSMyCustomersCell

@interface QYSMyCustomersCell : UITableViewCell

@property (nonatomic, readonly) UILabel *nameLabel;
@property (nonatomic, readonly) UILabel *phoneLabel;
@property (nonatomic, readonly) UILabel *spendLabel;

@property (nonatomic, assign) NSDictionary *infoDict;
@property (nonatomic, strong) Customer *customer;

@end

@implementation QYSMyCustomersCell

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
        
        self.separatorInset = UIEdgeInsetsZero;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.textColor = COLOR_HEX2RGB(0x686868);
        _nameLabel.font = FONT_NORMAL;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _phoneLabel.textColor = COLOR_HEX2RGB(0x686868);
        _phoneLabel.font = FONT_NORMAL;
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_phoneLabel];
        
        _spendLabel = [[UILabel alloc] init];
        _spendLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _spendLabel.font = FONT_NORMAL;
        _spendLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_spendLabel];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_nameLabel, _phoneLabel, _spendLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_nameLabel(100)][_phoneLabel(200)][_spendLabel(100)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_phoneLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_spendLabel]|" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    _nameLabel.text = @"老李头";
    _phoneLabel.text = @"18025367969";
    
    {
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:@"230 " attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff1f44),
                                                                                               NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
        [price appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                           NSFontAttributeName:FONT_WITH_SIZE(14.0),
                                                                           NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
        [price appendAttributedString:p];
        
        self.spendLabel.attributedText = price;
    }
}

-(void)setCustomer:(Customer *)customer {
    self.nameLabel.text = customer.real_name;
    self.phoneLabel.text = customer.mobile_phone;
    
    /*
    {
        UIColor *price_color = COLOR_RGBA(0.71, 0.71, 0.71, 1.0);
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:customer.expenditure.length > 0 ? customer.expenditure : @"0" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                                                                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:23.0]}];
        [price appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元  " attributes:@{NSForegroundColorAttributeName:price_color,
                                                                           NSFontAttributeName:FONT_WITH_SIZE(16.0),
                                                                           NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
        [price appendAttributedString:p];
        
        self.spendLabel.attributedText = price;
    }
     */
    {
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] init];
        
        NSString *expenditure = ([customer.expenditure isValid] && ![customer.expenditure isBlank]) ? customer.expenditure : @"";
        
        NSAttributedString *p = [[NSAttributedString alloc] initWithString:[expenditure addString:@""] attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0xff1f44),
                                                                                                NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
        [price appendAttributedString:p];
        
        p = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSForegroundColorAttributeName:COLOR_HEX2RGB(0x686868),
                                                                         NSFontAttributeName:FONT_WITH_SIZE(14.0),
                                                                         NSStrikethroughStyleAttributeName:@(NSUnderlineStyleNone)}];
        [price appendAttributedString:p];
        
        self.spendLabel.attributedText = price;
    }
}

@end

#pragma mark - QYSMyCustomersViewController

@interface QYSMyCustomersViewController ()

@property (nonatomic, strong) UIView *tableHeaderView;
/*
@property (nonatomic, strong) UITextField *searchBar;
 */
@property (nonatomic, strong) NSMutableArray *customerList;

@end

@implementation QYSMyCustomersViewController

-(void)dealloc {
    _customerList = nil;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.title = @"客人资料";
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack target:self action:@selector(btnBackClick)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = COLOR_HEX2RGB(0xe6e6e5);
    
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _tableHeaderView.backgroundColor = COLOR_MAIN_WHITE;
    
     /*
    UIView *search_bar_bv = [[UIView alloc] init];
    search_bar_bv.translatesAutoresizingMaskIntoConstraints = NO;
    search_bar_bv.backgroundColor = COLOR_HEX2RGB(0xf0f0f0);
    [_tableHeaderView addSubview:search_bar_bv];
    
   
    self.searchBar = [[UITextField alloc] init];
    _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    _searchBar.backgroundColor = COLOR_MAIN_CLEAR;
    _searchBar.placeholder = @"请输入姓名、手机号";
    _searchBar.font = FONT_NORMAL_14;
    {
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tf-icon-search"]];
        iv.contentMode = UIViewContentModeCenter;
        iv.frame = CGRectMake(0, 0, 38, 38);
        _searchBar.leftView = iv;
    }
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    [_tableHeaderView addSubview:_searchBar];
     
    
    UIButton *btn_edit = [[UIButton alloc] init];
    btn_edit.translatesAutoresizingMaskIntoConstraints = NO;
    [btn_edit setTitleColor:COLOR_MAIN_BLACK forState:UIControlStateNormal];
    [btn_edit setTitle:@"编辑" forState:UIControlStateNormal];
    btn_edit.titleLabel.font = FONT_NORMAL;
    [btn_edit addTarget:self action:@selector(btnEditClick) forControlEvents:UIControlEventTouchUpInside];
    [_tableHeaderView addSubview:btn_edit];
      */
    
    UILabel *lb_name = [[UILabel alloc] init];
    lb_name.translatesAutoresizingMaskIntoConstraints = NO;
    lb_name.textColor = COLOR_HEX2RGB(0x999999);
    lb_name.font = FONT_NORMAL;
    lb_name.text = @"客人姓名";
    [_tableHeaderView addSubview:lb_name];
    
    UILabel *lb_phone = [[UILabel alloc] init];
    lb_phone.translatesAutoresizingMaskIntoConstraints = NO;
    lb_phone.textAlignment = NSTextAlignmentCenter;
    lb_phone.textColor = COLOR_HEX2RGB(0x999999);
    lb_phone.font = FONT_NORMAL;
    lb_phone.text = @"手机号码";
    [_tableHeaderView addSubview:lb_phone];
    
    UILabel *lb_spend = [[UILabel alloc] init];
    lb_spend.translatesAutoresizingMaskIntoConstraints = NO;
    lb_spend.textColor = COLOR_HEX2RGB(0x999999);
    lb_spend.font = FONT_NORMAL;
    lb_spend.text = @"累计消费";
    lb_spend.textAlignment = NSTextAlignmentRight;
    [_tableHeaderView addSubview:lb_spend];
    
    UIView *line = [[UIView alloc] init];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.backgroundColor = COLOR_HEX2RGB(0xe6e6e5);
    [_tableHeaderView addSubview:line];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(/*search_bar_bv, _searchBar, btn_edit, */lb_name, lb_phone, lb_spend, line);
    /*
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[search_bar_bv]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[search_bar_bv(60)]" options:0 metrics:nil views:vds]];
    
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_searchBar][btn_edit(70)]-|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_searchBar(60)]" options:0 metrics:nil views:vds]];
     
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn_edit(60)]" options:0 metrics:nil views:vds]];
     */
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[lb_name]" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-170-[lb_phone]" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-320-[lb_spend]" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lb_name(60)]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lb_phone(60)]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lb_spend(60)]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line]|" options:0 metrics:nil views:vds]];
    [_tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(0.5)]|" options:0 metrics:nil views:vds]];
    
    [self setupRefresh];
}

-(void)setupRefresh {
    UIImage *logoImage = [UIImage imageNamed:@"bicon.png"];
    UIImage *backCircleImage = [UIImage imageNamed:@"light_circle.png"];
    UIImage *frontCircleImage = [UIImage imageNamed:@"dark_circle.png"];
    
    BMYCircularProgressView *progressView1 = [[BMYCircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)
                                                                                       logo:logoImage
                                                                            backCircleImage:backCircleImage
                                                                           frontCircleImage:frontCircleImage];
    __weak typeof(self) weakSelf = self;
    
    [self.tableView setPullToRefreshWithHeight:60.0f actionHandler:^(BMYPullToRefreshView *pullToRefreshView) {
        
        [[CustomerService sharedCustomerService] getCustomers:^(CustomerResponse *response) {
            [weakSelf reloadDataWithResponse:response];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        } error:^(NSString *error) {
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
    [self.tableView.pullToRefreshView setProgressView:progressView1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[CustomerService sharedCustomerService] getCustomers:^(CustomerResponse *response) {
        [self reloadDataWithResponse:response];
    } error:^(NSString *error) {
//        JDStatusBarNotificationError(error);
    }];
}

-(void)reloadDataWithResponse:(CustomerResponse *)response {
    if (nil == _customerList) {
        self.customerList = [@[] mutableCopy];
    }
    
    if ([_customerList count] > 0) {
        [_customerList removeAllObjects];
    }
    
    self.customerList = [NSMutableArray arrayWithArray:response.data];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_customerList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _tableHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSMyCustomersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-customer-cell"];
    if (!cell)
    {
        cell = [[QYSMyCustomersCell alloc] initWithReuseIdentifier:@"my-customer-cell"];
    }
    
//    cell.infoDict = nil;
    Customer *customer = [_customerList objectAtIndex:indexPath.row];
    cell.customer = customer;
    
    return cell;
}

/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
 */

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
 */

/*
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
 */


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnEditClick
{
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

@end
