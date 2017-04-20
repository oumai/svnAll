//
//  QYSMyShopSettingsViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/5.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyShopSettingsViewController.h"
#import "TITokenField.h"
#import "QYSPopMenusViewController.h"

#pragma mark - QYSMyShopSettingsCell

@interface QYSMyShopSettingsCell : UITableViewCell

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UITextField *inputField;

@property (nonatomic, assign) NSDictionary *infoDict;
@property (nonatomic, copy, readwrite) void(^textFieldBlock)(NSString *info);

@end

@implementation QYSMyShopSettingsCell

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = COLOR_MAIN_WHITE;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([self respondsToSelector:@selector(preservesSuperviewLayoutMargins)])
        {
            self.preservesSuperviewLayoutMargins = NO;
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)])
        {
            self.layoutMargins = UIEdgeInsetsZero;
        }
        
        self.separatorInset = UIEdgeInsetsZero;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = FONT_NORMAL;
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:_titleLabel];
        
        UIView *line = [[UIView alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = COLOR_MAIN_BORDER_GRAY;
        [self.contentView addSubview:line];
        
        _inputField = [[UITextField alloc] init];
        _inputField.translatesAutoresizingMaskIntoConstraints = NO;
        _inputField.font = FONT_NORMAL;
        _inputField.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:_inputField];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_titleLabel, line, _inputField);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_titleLabel(90)]-[line(0.5)]-[_inputField]-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[line]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_inputField]|" options:0 metrics:nil views:vds]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_inputField];
    }
    return self;
}

- (void)textFieldChanged:(id)sender {
    NSLog(@"%@",_inputField.text);
    if (self.textFieldBlock) {
        self.textFieldBlock(_inputField.text);
    }
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    
}

@end

#pragma mark -

#pragma mark - QYSMyShopSettingsCell

@interface QYSMyShopSettingsTextViewCell : UITableViewCell

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) SQTextView *inputField;

@property (nonatomic, assign) NSDictionary *infoDict;

+ (CGFloat)heightForCell:(id)content;

@end

@implementation QYSMyShopSettingsTextViewCell

+ (CGFloat)heightForCell:(id)content
{
    CGSize s = [content sizeWithAttributes:@{NSFontAttributeName:FONT_NORMAL}];
    
    if (s.height < 15)
    {
        return 60.0;
    }
    
    if (s.height > 200.0)
    {
        return 200.0;
    }
    
    return s.height+16.0;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = FONT_NORMAL;
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:_titleLabel];
        
        UIView *line = [[UIView alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = COLOR_MAIN_BORDER_GRAY;
        [self.contentView addSubview:line];
        
        _inputField = [[SQTextView alloc] init];
        _inputField.translatesAutoresizingMaskIntoConstraints = NO;
        _inputField.font = FONT_NORMAL;
        _inputField.placeholder = @"请输入店铺简介";
        _inputField.textColor = COLOR_TEXT_GRAY;
        [self.contentView addSubview:_inputField];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_titleLabel, line, _inputField);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_titleLabel(90)]-[line(0.5)]-[_inputField]-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLabel(20)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[line]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_inputField]|" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    
}

@end

#pragma mark - StoreSettingTags

@interface StoreTagsCell : UITableViewCell

@property (nonatomic, strong) TITokenFieldView * tokenFieldView;
@property (nonatomic, strong) NSString *tagsString;

@end

@implementation StoreTagsCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [UILabel LabelWithFrame:CGRectMake(20, 14, 78, 14) text:@"店铺标签" textColor:[UIColor colorForHexString:@"#333333"] font:15.0f textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:label];
        
        self.tokenFieldView = [[TITokenFieldView alloc] initWithFrame:CGRectMake(120, 0, 268, 100)];
        [self.tokenFieldView setShouldSearchInBackground:NO];
        [self.tokenFieldView setShouldSortResults:NO];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(118, 0, 0.5f, 100.0f)];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = COLOR_MAIN_BORDER_GRAY;
        [self.contentView addSubview:line];
        
        // [self.tokenFieldView.tokenField addTarget:self action:@selector(tokenFieldFrameDidChange:) forControlEvents:TITokenFieldControlEventFrameDidChange];
        [self.tokenFieldView.tokenField setTokenizingCharacters:[NSCharacterSet characterSetWithCharactersInString:@",;."]];
        [self.tokenFieldView.tokenField setPromptText:@""];
        [self.tokenFieldView.tokenField setPlaceholder:@"输入店铺标签"];
        self.tokenFieldView.tokenField.tokenLimit = 20.0f;
        // [self.tokenFieldView.tokenField addTokensWithTitleArray:@[@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3",@"2",@"3"]];
        [self.contentView addSubview:_tokenFieldView];
        
    }
    return self;
}

- (void)tokenFieldFrameDidChange:(TITokenField *)tokenField {
    
}

-(void)setTagsString:(NSString *)tagsString {
    
    if (nil == tagsString || [tagsString isBlank]) {
        return;
    }
    
    if (![tagsString containsString:@","]) {
        //此时说明 只有一个标签
        [self.tokenFieldView.tokenField addTokensWithTitleArray:@[tagsString]];
    }else {
        NSArray *array = [tagsString componentsSeparatedByString:@","];
        if ([self.tokenFieldView.tokenTitles count] > 0) {
            [self.tokenFieldView.tokenField removeAllTokens];
        }
        [self.tokenFieldView.tokenField addTokensWithTitleArray:array];
    }
}

@end

#pragma mark - QYSMyShopSettingsViewController

@interface QYSMyShopSettingsViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,QYSPopMenusViewControllerDelegate>//<UITextViewDelegate>

@property (nonatomic, copy) NSString *shopDescription;
@property (nonatomic, strong) StoreIntroduction *storeIntroduction;
@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation QYSMyShopSettingsViewController

-(void)dealloc {
    _shopDescription = nil;
    _storeIntroduction =  nil;
    _avatarImage = nil;
    _HUD = nil;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        self.title = @"店铺设置";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack target:self action:@selector(btnBackClick)];
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[MyStoreService sharedMyStoreService] getMyStoreInfoWithStoreId:nil Complete:^(StoreIntroductionResponse *response) {
        self.storeIntroduction = response.data;
        [self.tableView reloadData];
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.tableView.separatorColor = COLOR_MAIN_BORDER_GRAY;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 1, 0, 0);
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400, 44.0)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 0, v.bounds.size.width-40, v.bounds.size.height);
    [btn setTitle:@"保存设置" forState:UIControlStateNormal];
    [btn setBackgroundImage:[[UIImage imageNamed:@"btn-bg-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
    
    self.tableView.tableFooterView = v;
}

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 1;
    }
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 0.1;
    }
    
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 0.1;
    }
    
    return 25.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        return 69.0;
    }
    else if (1 == indexPath.section && 5 == indexPath.row)
    {
        return 133.0f;//[QYSMyShopSettingsTextViewCell heightForCell:_shopDescription];
    }else if (1 == indexPath.section && 4 == indexPath.row) {
        return 100.0f;
    }
    
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-shop-sett0-cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"my-shop-sett0-cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.textColor = COLOR_TEXT_BLACK;
        cell.textLabel.text = _storeIntroduction.inn_name.length > 0 ? _storeIntroduction.inn_name : @"暂无";
        
        UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tst-user-avatar"]];
        avatar.frame = CGRectMake(0, 0, 46, 46);
        avatar.layer.cornerRadius = 23.0f;
        avatar.layer.masksToBounds = YES;
        avatar.tag = 1;
        kSetIntenetImageWith(avatar, _storeIntroduction.inn_head);
        cell.accessoryView = avatar;
        
        return cell;
    }
    
    if (5 == indexPath.row)
    {
        QYSMyShopSettingsTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-shop-desc-cell"];
        if (!cell)
        {
            cell = [[QYSMyShopSettingsTextViewCell alloc] initWithReuseIdentifier:@"my-shop-desc-cell"];
        }
        
        cell.titleLabel.text = @"店铺简介";
        cell.inputField.tag = 101;
        cell.inputField.text = _storeIntroduction.inn_summary.length > 0 ? _storeIntroduction.inn_summary : @"";
        //cell.inputField.delegate = self;
        
        return cell;
    }
    
    QYSMyShopSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my-shop-sett-cell"];
    if (!cell)
    {
        cell = [[QYSMyShopSettingsCell alloc] initWithReuseIdentifier:@"my-shop-sett-cell"];
        cell.inputField.placeholder = cell.titleLabel.text;
    }
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"店铺地址";
        cell.inputField.text = _storeIntroduction.inn_address;
        [cell setTextFieldBlock:^(NSString *info) {
            _storeIntroduction.inn_address = info;
        }];
    }else if (indexPath.row == 1) {
        cell.titleLabel.text = @"联系座机";
        cell.inputField.text = _storeIntroduction.inner_telephone;
        cell.inputField.keyboardType = UIKeyboardTypeNumberPad;
        [cell setTextFieldBlock:^(NSString *info) {
            _storeIntroduction.inner_telephone = info;
        }];
    }else if (indexPath.row == 2) {
        cell.titleLabel.text = @"联系人";
        cell.inputField.text = _storeIntroduction.bank_account_name;
        [cell setTextFieldBlock:^(NSString *info) {
            _storeIntroduction.bank_account_name = info;
        }];
    }else if (indexPath.row == 3) {
        cell.titleLabel.text = @"联系手机";
        cell.inputField.text = _storeIntroduction.inner_moblie_number;
        cell.inputField.keyboardType = UIKeyboardTypeNumberPad;
        [cell setTextFieldBlock:^(NSString *info) {
            _storeIntroduction.inner_moblie_number = info;
        }];
    }else if (indexPath.row == 4) {
        StoreTagsCell *tagCell = (StoreTagsCell *)[tableView dequeueReusableCellWithIdentifier:@"my-shop-tag-cell"];
        if (nil == tagCell) {
            tagCell = [[StoreTagsCell alloc] initWithReuseIdentifier:@"my-shop-tag-cell"];
        }
        
        NSString *tagsString = _storeIntroduction.features;
        tagCell.tagsString = tagsString;
        
        return tagCell;
    }
    
    /*
    
    switch (indexPath.row)
    {
        case 0:
            cell.titleLabel.text = @"店铺地址";
            cell.inputField.text = _storeIntroduction.inn_address;
            [cell setTextFieldBlock:^(NSString *info) {
                _storeIntroduction.inn_address = info;
            }];
            break;
        case 1:
            cell.titleLabel.text = @"联系座机";
            cell.inputField.text = _storeIntroduction.inner_telephone;
            cell.inputField.keyboardType = UIKeyboardTypeNumberPad;
            [cell setTextFieldBlock:^(NSString *info) {
                _storeIntroduction.inner_telephone = info;
            }];
            break;
        case 2:
            cell.titleLabel.text = @"联系人";
            cell.inputField.text = _storeIntroduction.bank_account_name;
            [cell setTextFieldBlock:^(NSString *info) {
                _storeIntroduction.bank_account_name = info;
            }];
            break;
        case 3:
            cell.titleLabel.text = @"联系手机";
            cell.inputField.text = _storeIntroduction.inner_moblie_number;
            cell.inputField.keyboardType = UIKeyboardTypeNumberPad;
            [cell setTextFieldBlock:^(NSString *info) {
                _storeIntroduction.inner_moblie_number = info;
            }];
            break;
        case 4:
        {
            StoreTagsCell *tagCell = (StoreTagsCell *)[tableView dequeueReusableCellWithIdentifier:@"my-shop-tag-cell"];
            if (nil == tagCell) {
                tagCell = [[StoreTagsCell alloc] initWithReuseIdentifier:@"my-shop-tag-cell"];
            }
            
            NSString *tagsString = _storeIntroduction.features;
            tagCell.tagsString = tagsString;
            
            return tagCell;
        }
            break;
    }
     */
    

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section && 0 == indexPath.row)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGRect f = [cell convertRect:cell.bounds toView:self.view.superview.superview];
        
        UIPopoverController *pc = [QYSPopMenusViewController popverController:self menus:@[@"拍照",@"相册"]];
        [pc presentPopoverFromRect:f inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (101 == textView.tag)
    {
        self.shopDescription = textView.text;
    }
    
    Class tv_class = [UITableViewCell class];
    
    UIView *cv = textView.superview;
    while (cv)
    {
        if ([cv isKindOfClass:tv_class])
        {
            NSIndexPath *idx = [self.tableView indexPathForCell:(UITableViewCell *)cv];
            [self.tableView reloadRowsAtIndexPaths:@[idx] withRowAnimation:UITableViewRowAnimationNone];
            
            break;
        }
        
        cv = cv.superview;
    }
}

#pragma mark - QYSPopMenusViewControllerDelegate

- (void)popMenusViewController:(QYSPopMenusViewController *)controller didSelectRowAtIndex:(NSNumber *)index
{
    [controller.popverController dismissPopoverAnimated:NO];
    
    UIImagePickerController *c = [[UIImagePickerController alloc] init];
    c.allowsEditing = YES;
    c.delegate = self;
    
    if (0 == [index intValue])
    {
        c.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:c animated:YES completion:nil];
    }
    else
    {
        c.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CGRect f = [cell convertRect:cell.bounds toView:self.view.superview.superview];
        
        UIPopoverController *pc = [[UIPopoverController alloc] initWithContentViewController:c];
        pc.popoverContentSize = CGSizeMake(350, self.view.bounds.size.height);
        [pc presentPopoverFromRect:f inView:self.view.superview.superview permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
}

#pragma mark -

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage *aImage = [image compressedImage];
        self.avatarImage = aImage;
        
        UITableViewCell *avartarCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UIImageView *imageView = (UIImageView *)[avartarCell viewWithTag:1];
        imageView.image = aImage;
    }];
}

#pragma mark - Actions

-(void)save:(id)sender {
    QYSMyShopSettingsCell *addressCell  = (QYSMyShopSettingsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSString *address = addressCell.inputField.text ;
    
    
    QYSMyShopSettingsCell *inner_telephone_cell  = (QYSMyShopSettingsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    NSString *telephone = inner_telephone_cell.inputField.text;
    
    QYSMyShopSettingsCell *bank_account_name_cell  = (QYSMyShopSettingsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    NSString *linkMan = bank_account_name_cell.inputField.text;
    
    QYSMyShopSettingsCell *inner_moblie_number_cell  = (QYSMyShopSettingsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    NSString *mobile = inner_moblie_number_cell.inputField.text;
    
    StoreTagsCell *tagCell = (StoreTagsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
    NSArray *tags = tagCell.tokenFieldView.tokenField.tokenTitles;
    
    QYSMyShopSettingsTextViewCell *introduceCell = (QYSMyShopSettingsTextViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
    NSString *introduce  = introduceCell.inputField.text;
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //显示的文字
    self.HUD.labelText = @"";
    //细节文字
    self.HUD.detailsLabelText = @"正在修改店铺设置...";
    //是否有庶罩
    self.HUD.dimBackground = YES;
    [self.HUD show:YES];
    
    [[StoreSettingService sharedStoreSettingService] storeSetterWithAvatar:_avatarImage address:address telephone:telephone linkMan:linkMan mobile:mobile storeIntroduce:introduce storeTag:tags complete:^{
        [self.HUD setHidden:YES];
        JDStatusBarNotificationSuccess(@"店铺信息修改成功");
    } error:^(NSString *error) {
        [self.HUD setHidden:YES];
        JDStatusBarNotificationError(error);
    }];
}

@end
