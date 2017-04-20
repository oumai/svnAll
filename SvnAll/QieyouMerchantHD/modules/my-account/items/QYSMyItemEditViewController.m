//
//  QYSMyItemEditViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/18.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyItemEditViewController.h"
#import "QYSMyItemEditCells.h"
#import "QYSPopMenusViewController.h"
#import "ELCImagePickerHeader.h"
#import "UIViewController+SQPopupViewController.h"
#import "GoodCategoriesViewController.h"
#import "CalendarViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "QYSItemDetailsViewController.h"

@interface QYSMyItemEditViewController () <UITextViewDelegate, QYSMyItemEditCellDelegate, QYSPopMenusViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ELCImagePickerControllerDelegate,GoodCategoriesViewControllerDelegate,CalendarViewControllerDelegate>

@property (nonatomic, copy) NSString *itemIntroduce;
@property (nonatomic, copy) NSString *buyRule;
@property (nonatomic, strong) QYSMyItemEditCoversCell *iconCell;
@property (nonatomic, strong) QYSMyItemEditIntroduceCell *detailIconCell;
@property (nonatomic, strong) UITableViewCell *selectedCell;
@property (nonatomic, strong) NSMutableArray *productImageArray;
@property (nonatomic, strong) NSMutableArray *productDetailImageArray;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) NSString *cateString;
@property (nonatomic, strong) NSString *timeString ;

@end

@implementation QYSMyItemEditViewController

+ (UINavigationController *)navController
{
    QYSMyItemEditViewController *c = [[QYSMyItemEditViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (NSMutableArray *)productImageArray
{
    if (_productImageArray == nil) {
        _productImageArray = [NSMutableArray array];
    }
    return _productImageArray;
}

- (NSMutableArray *)productDetailImageArray
{
    if (_productDetailImageArray == nil) {
        _productDetailImageArray = [NSMutableArray array];
    }
    return _productDetailImageArray;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.title = @"新增商品";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    self.tableView.separatorColor = COLOR_MAIN_BORDER_GRAY;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400, 70.0)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 10, v.bounds.size.width-40, 44.0);
    [btn setTitle:@"提交上架" forState:UIControlStateNormal];
    [btn setBackgroundImage:[[UIImage imageNamed:@"btn-bg-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(beginToUpload) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
    
    UILabel *lb_tips = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y+btn.frame.size.height+10, v.bounds.size.width, 15)];
    lb_tips.text = @"提交，暂不上架(加入到下架商品中)";
    lb_tips.textColor = COLOR_HEX2RGB(0xc0a355);
    lb_tips.textAlignment = NSTextAlignmentCenter;
    lb_tips.font = FONT_NORMAL_13;
    [v addSubview:lb_tips];
    
    self.tableView.tableFooterView = v;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    
    if (0 == section)
    {
        num = 1;
    }
    else if (1 == section)
    {
        num = 1;
    }
    else if (2 == section)
    {
        num = 6;
    }
    else if (3 == section)
    {
        num = 1;
    }
    
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = 0.0;
    
    if (0 == indexPath.section)
    {
        h = [QYSMyItemEditCoversCell heightForCell:(int)self.productImageArray.count];
    }
    else if (1 == indexPath.section || 3 == indexPath.section)
    {
        h = [QYSMyItemEditOptionsCell heightForCell];
    }
    else if (2 == indexPath.section)
    {
        if (4 == indexPath.row)
        {
            h = [QYSMyItemEditCoversCell heightFor4Cell:(int)self.productDetailImageArray.count] + 40;
            
        }
        else if (5 == indexPath.row)
        {
            h = [QYSMyItemEditTextViewCell heightForCell:_buyRule];
        }
        else
        {
            h = [QYSMyItemEditEditableCell heightForCell];
        }
    }
    
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section == 3)
    {
        return 20.0;
    }
    
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (3 == section)
    {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20.0)];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 5.0, self.view.bounds.size.width-20.0, 15.0)];
        lb.textColor = COLOR_TEXT_RED;
        lb.font = FONT_NORMAL_13;
        lb.text = @"提示：有效期一旦设定将不能修改";
        
        [v addSubview:lb];
        
        return v;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYSMyItemEditCell *cell = nil;
    
    if (0 == indexPath.section)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"my-item-edit-covers-cell"];
        if (!cell)
        {
            cell = [[QYSMyItemEditCoversCell alloc] initWithReuseIdentifier:@"my-item-edit-covers-cell"];
        }
        
        [(QYSMyItemEditCoversCell *)cell setActDelegate:self];
        
        [(QYSMyItemEditCoversCell *)cell setImages:self.productImageArray];
        self.iconCell = (QYSMyItemEditCoversCell *)cell;
        
    }
    else if (1 == indexPath.section)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"my-item-edit-options-cell"];
        if (!cell)
        {
            cell = [[QYSMyItemEditOptionsCell alloc] initWithReuseIdentifier:@"my-item-edit-options-cell"];
        }
        
        QYSMyItemEditOptionsCell *cc = (QYSMyItemEditOptionsCell *)cell;
        cc.titleLabel.text = @"商品类别";
        cc.valueLabel.text = @"美食饕餮";
    }
    else if (2 == indexPath.section)
    {
        if (4 == indexPath.row)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"my-item-edit-info-cell"];
            if (!cell)
            {
                cell = [[QYSMyItemEditIntroduceCell alloc] initWithReuseIdentifier:@"my-item-edit-info-cell"];
            }
            
            QYSMyItemEditIntroduceCell *cc = (QYSMyItemEditIntroduceCell *)cell;
            cc.actDelegate = self;
            cc.titleLabel.text = @"商品介绍";
            cc.inputField.text = _itemIntroduce;
            cc.inputField.tag = 101;
            cc.inputField.delegate = self;
            cc.images = self.productDetailImageArray;
            self.detailIconCell = cc;
            
            return cell;
        }
        else if (5 == indexPath.row)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"my-item-edit-textview-cell"];
            if (!cell)
            {
                cell = [[QYSMyItemEditTextViewCell alloc] initWithReuseIdentifier:@"my-item-edit-textview-cell"];
            }
            
            QYSMyItemEditTextViewCell *cc = (QYSMyItemEditTextViewCell *)cell;
            cc.titleLabel.text = @"购买须知";
            cc.inputField.text = _buyRule;
            cc.inputField.tag = 102;
            cc.inputField.delegate = self;
            
            return cell;
        }
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"my-item-edit-editable-cell"];
        if (!cell)
        {
            cell = [[QYSMyItemEditEditableCell alloc] initWithReuseIdentifier:@"my-item-edit-editable-cell"];
        }
        
        QYSMyItemEditEditableCell *cc = (QYSMyItemEditEditableCell *)cell;
        
        switch (indexPath.row)
        {
            case 0:
                cc.titleLabel.text = @"商品名称";
                cc.inputField.placeholder = @"商品名称";
                break;
                
            case 1:
                cc.titleLabel.text = @"商品价格";
                cc.inputField.placeholder = @"商品价格  ";
                cc.inputField.keyboardType = UIKeyboardTypeNumberPad;
                break;
                
            case 2:
                cc.titleLabel.text = @"可售数量";
                cc.inputField.placeholder = @"可售数量";
                break;
                
            case 3:
                cc.titleLabel.text = @"佣金设置";
                cc.inputField.placeholder = @"佣金设置";
                break;
        }
    }
    else if (3 == indexPath.section)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"my-item-edit-options-cell"];
        if (!cell)
        {
            cell = [[QYSMyItemEditOptionsCell alloc] initWithReuseIdentifier:@"my-item-edit-options-cell"];
        }
        
        QYSMyItemEditOptionsCell *cc = (QYSMyItemEditOptionsCell *)cell;
        cc.titleLabel.text = @"有效期";
        cc.valueLabel.text = @"3个月";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        GoodCategoriesViewController *viewController = [[GoodCategoriesViewController alloc] init];
        viewController.delegate = self;
        [self presentPopupViewController:viewController animationType:MJPopupViewAnimationSlideLeftLeft dismissed:^{
            
        }];
    }else if (indexPath.section == 3 && indexPath.row == 0) {
        CalendarViewController *viewController = [[CalendarViewController alloc] init];
        viewController.delegate = self;
        [self presentPopupViewController:viewController animationType:MJPopupViewAnimationSlideLeftLeft dismissed:^{
            
        }];
    }
}

#pragma mark - CalendarViewControllerDelegate

-(void)calendarViewControllerDismiss:(CalendarViewController *)viewController {
    [viewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];
}

-(void)calendarViewController:(CalendarViewController *)viewController calendar:(NSDate *)date {
    [viewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];
    NSString *selectedDateString = [NSString stringFromDate:date];
    
    QYSMyItemEditOptionsCell *cc = (QYSMyItemEditOptionsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    self.timeString = selectedDateString;
    cc.valueLabel.text = _timeString;
}

#pragma mark - GoodCategoriesViewControllerDelegate

-(void)goodCategoriesViewController:(GoodCategoriesViewController *)viewController cate:(NSString *)cate cateDetail:(NSString *)cateDetail {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];
    NSArray *array = @[cate,cateDetail];
    NSString *string = [array componentsJoinedByString:@","];
    QYSMyItemEditOptionsCell *cc = (QYSMyItemEditOptionsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    self.cateString = string;
    cc.valueLabel.text = _cateString;
}

-(void)goodCategoriesViewControllerDismiss:(GoodCategoriesViewController *)viewController {
    [viewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];
}

- (void)myItemEditCellDidClickRemoveImageButton:(QYSMyItemEditCell *)cell index:(NSNumber *)index
{
    
    if (self.selectedCell == self.iconCell) {
        [self.productImageArray removeObjectAtIndex:[index integerValue]];
        [self.iconCell setImages:self.productImageArray];
        if (self.productImageArray.count < 3) {
            [self.tableView reloadData];
        }
        return;
    }
    
    [self.productDetailImageArray removeObjectAtIndex:[index integerValue]];
    [self.detailIconCell setImages:self.productDetailImageArray];
    if (self.productDetailImageArray.count % 4 == 3 || self.productDetailImageArray.count % 4 == 0) {
        [self.tableView reloadData];
    }
    
}

- (void)myItemEditCellDidClickNewImageButton:(QYSMyItemEditCell *)cell
{
    self.selectedCell =  cell;
    
    CGRect popLocation = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    
    
    UIPopoverController *pc = [QYSPopMenusViewController popverController:self menus:@[@"拍照",@"相册"]];
    
    [pc presentPopoverFromRect:popLocation inView:cell permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
}

#pragma mark - QYSPopMenusViewControllerDelegate

- (void)popMenusViewController:(QYSPopMenusViewController *)controller didSelectRowAtIndex:(NSNumber *)index
{
    [controller.popverController dismissPopoverAnimated:NO];
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 29 - self.productDetailImageArray.count;
    if (self.selectedCell == self.iconCell) {
        elcPicker.maximumImagesCount = 5 - self.productImageArray.count; //Set the maximum number of images to select to 100
    }
    
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    
    elcPicker.imagePickerDelegate = self;
    
    if (0 == [index intValue]){
        
    } else {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CGRect f = [cell convertRect:cell.bounds toView:self.view.superview.superview];
        
        UIPopoverController *pc = [[UIPopoverController alloc] initWithContentViewController:elcPicker];
        pc.popoverContentSize = CGSizeMake(350, self.view.bounds.size.height);
        [pc presentPopoverFromRect:f inView:self.view.superview.superview permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
}

#pragma mark - ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                [images addObject:image];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    if (self.selectedCell == self.iconCell) {
        [self.productImageArray addObjectsFromArray:images];
        [self.iconCell setImages:self.productImageArray];
        [self.tableView reloadData];
        return;
    }
    [self.productDetailImageArray addObjectsFromArray:images];
    [self.iconCell setImages:self.productDetailImageArray];
    
    [self.tableView reloadData];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (101 == textView.tag)
    {
        self.itemIntroduce = textView.text;
    }
    else if (102 == textView.tag)
    {
        self.buyRule = textView.text;
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

-(void)beginToUpload {
    
    
    
}

@end
