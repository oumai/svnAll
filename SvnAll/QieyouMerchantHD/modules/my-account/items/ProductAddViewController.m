//
//  ProductAddViewController.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductAddViewController.h"
#import "ProductTitleImagesCell.h"
#import "ProductBaseInfoCell.h"
#import "ProductNoteCell.h"
#import "ProductBuyNoteCell.h"
#import "ProductCateCell.h"
#import "ProductTimeCell.h"
#import "QYSPopMenusViewController.h"
#import "ELCImagePickerHeader.h"
#import "ProductCategoryViewController.h"
#import "ProductTimeViewController.h"
#import "QYSItemDetailsViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ProductAddManager.h"



@interface ProductAddViewController ()<UITableViewDataSource,UITableViewDelegate,QYSPopMenusViewControllerDelegate,ELCImagePickerControllerDelegate,UIImagePickerControllerDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleImages;
@property (nonatomic, strong) NSMutableArray *noteImages;
//@property (nonatomic, strong) NSMutableDictionary *infoDict;

@property (nonatomic, strong) UIPopoverController *titleImagePopover;
@property (nonatomic, strong) UIPopoverController *noteImagePopover;
@property (nonatomic, strong) UIPopoverController *categoryPopover;

@property (nonatomic, strong) ELCImagePickerController *titleImagePicker;
@property (nonatomic, strong) ELCImagePickerController *noteImagePicker;

@property (nonatomic, strong) UIImagePickerController *titleImagesPickerViewController;
@property (nonatomic, strong) UIImagePickerController *noteImagesPickerViewController;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) ProductAddManager *addManager;


@end

@implementation ProductAddViewController

+ (UINavigationController *)navController
{
    ProductAddViewController *c = [[ProductAddViewController alloc] init];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"新增商品";
        self.titleImages = [NSMutableArray new];
        self.noteImages = [NSMutableArray new];
        self.addManager = [ProductAddManager sharedProductAddManager];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTheme];
    
    //UITableView init
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 400.0f, 770 - 64.0f)];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorColor = COLOR_MAIN_BORDER_GRAY;
        [self.view addSubview:_tableView];
    }
   
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400, 70.0)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 10, v.bounds.size.width-40, 44.0);
    [btn setTitle:@"提交上架" forState:UIControlStateNormal];
    [btn setBackgroundImage:[[UIImage imageNamed:@"btn-bg-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(beginToUpload) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
    
    UILabel *lb_tips = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.frame.origin.y+btn.frame.size.height+10, v.bounds.size.width, 15)];
    //lb_tips.text = @"提交，暂不上架(加入到下架商品中)";
    lb_tips.textColor = COLOR_HEX2RGB(0xc0a355);
    lb_tips.textAlignment = NSTextAlignmentCenter;
    lb_tips.font = FONT_NORMAL_13;
    [v addSubview:lb_tips];
    
    self.tableView.tableFooterView = v;
    
    
}

#pragma mark - Actions

-(void)beginToUpload {
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    self.HUD.labelText = @"正在上架商品...";
    [self.HUD show:YES];
    
    NSMutableDictionary *_infoDict = [_addManager findInfoDict];
    
    CategoryTitle *categoryTitle = _infoDict[kProductCidKey];
    CategoryList *categoryList = _infoDict[kProductCcidKey];
    [[ProductService sharedProductService] uploadProductWithTitleImages:_infoDict[kProductTitleImageKey]
                                                             noteImages:_infoDict[kProductNoteImagesKey]
                                                                    cid:categoryTitle.id
                                                                   ccid:categoryList.category_id
                                                            productName:_infoDict[kProductNameKey]
                                                                  price:_infoDict[kProductPriceKey]
                                                                  count:_infoDict[kProductSellCountKey]
                                                                   note:_infoDict[kProductNoteKey]
                                                                buyNote:_infoDict[kProductBuyNoteKey]
                                                                endTime:_infoDict[kProductTimeKey]
                                                                yongjin:_infoDict[kProductYongjinKey]
                                                               complete:^(NSString *productId) {
                                                                   [self.HUD hide:YES];
                                                                   [QYSPopupView hideAll:^{
                                                                       [_addManager removeAll];
                                                                       UINavigationController *nc = [QYSItemDetailsViewController navController];
                                                                       
                                                                       QYSItemDetailsViewController *c = (QYSItemDetailsViewController *)(nc.topViewController);
                                                                 
                                                                       c.productId = productId;
                                                                       c.title = @"商品详情";
                                                                       c.backgroundImage = nil;
                                                                       [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nc animated:NO completion:^{
                                                                           [c showBackgroundLayerWithAnimate];
                                                                       }];
                                                                       
                                                                   }];
                                                                  
                                                               } error:^(NSString *error) {
                                                                   [self.HUD hide:YES];
                                                               }];
}

#pragma mark - UITableViewDelegate DataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4.0f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2 || section == 3) {
        return 10.0f;
    }
    
    return 0.0f;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400.0f, 10.0f)];
    view.backgroundColor = [UIColor colorForHexString:@"#f0efed"];
    return view;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 6;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
    }
    return 0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *infoDict = [_addManager findInfoDict];
    
    if (indexPath.section == 0) {
        return [ProductTitleImagesCell heightForCellWithImage:infoDict[kProductTitleImageKey]];
    }else if (indexPath.section == 2) {
        if (indexPath.row == 5) {
            return 180.0f;
        }else if (indexPath.row == 4) {
           return [ProductNoteCell heightForCellWithImages:infoDict[kProductNoteImagesKey]];
        }
    }
    return 60.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *infoDict = [_addManager findInfoDict];
    
    switch (indexPath.section) {
        case 0:
        {
            ProductTitleImagesCell *cell = [[ProductTitleImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"product_title_images_cell"];
            cell.titleImages = infoDict[kProductTitleImageKey];
            
            __weak ProductTitleImagesCell *weakSelf = cell;
            [cell setProductAddBlock:^{
                CGRect popLocation = CGRectMake(0, 0, weakSelf.frame.size.width, weakSelf.frame.size.height);
                
                
                self.titleImagePopover = [QYSPopMenusViewController popverController:self menus:@[@"拍照",@"相册"]];
                
                [_titleImagePopover presentPopoverFromRect:popLocation inView:weakSelf permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            }];
            
            [cell setProductImagesClicedBlock:^(NSInteger index) {
                
            }];
            
            [cell setReloadProductTitleImageCell:^(BOOL finished, NSInteger index) {
                [self.titleImages removeObjectAtIndex:index];
                [infoDict setObject:_titleImages forKey:kProductTitleImageKey];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
            }];
            
            
            return cell;
        }
            break;
        case 1:
        {
            ProductCateCell *cell = [[ProductCateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"product_category_cell"];
            CategoryTitle *categoryTitle = infoDict[kProductCidKey];
            CategoryTitle *categoryList = infoDict[kProductCcidKey];
            
            if (categoryList.name.length == 0  && categoryTitle.name.length == 0) {
                cell.cateContent = @"默认";
            }else {
                cell.cateContent = [[categoryTitle.name addString:@","] addString:categoryList.name];
            }
            
            return cell;
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                ProductBaseInfoCell *cell = [[ProductBaseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info_cell_0"];
                cell.title = @"商品名称";
                cell.placeHolder = @"请输入商品名称";
                cell.content = infoDict[kProductNameKey];
                
                [cell setProductBaseInfoBlock:^(NSString *info) {
                    [infoDict setObject:info forKey:kProductNameKey];

                }];
                
                return cell;
            }else if (indexPath.row == 1) {
                ProductBaseInfoCell *cell = [[ProductBaseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info_cell_1"];
                cell.title = @"商品价格";
                cell.placeHolder = @"请输入商品价格";
                cell.keyboardType = UIKeyboardTypeNumberPad;
                cell.content = infoDict[kProductPriceKey];
                [cell setProductBaseInfoBlock:^(NSString *info) {
                    [infoDict setObject:info forKey:kProductPriceKey];
                }];
                
                return cell;
            }else if (indexPath.row == 2) {
                ProductBaseInfoCell *cell = [[ProductBaseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info_cell_2"];
                cell.title = @"可售数量";
                cell.placeHolder = @"请输入可售数量";
                cell.keyboardType = UIKeyboardTypeNumberPad;
                cell.content = infoDict[kProductSellCountKey];
                
                [cell setProductBaseInfoBlock:^(NSString *info) {
                    [infoDict setObject:info forKey:kProductSellCountKey];
                }];
                
                return cell;
            }else if (indexPath.row == 3) {
                ProductBaseInfoCell *cell = [[ProductBaseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info_cell_3"];
                cell.title = @"佣金设置";
                cell.placeHolder = @"请输入商品佣金";
                cell.keyboardType = UIKeyboardTypeNumberPad;
                cell.content = infoDict[kProductYongjinKey];
                [cell setProductBaseInfoBlock:^(NSString *info) {
                    [infoDict setObject:info forKey:kProductYongjinKey];
                }];
                return cell;
            }else if (indexPath.row == 4) {
                ProductNoteCell *cell = [[ProductNoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info_cell_4"];
                cell.noteImages = infoDict[kProductNoteImagesKey];
                cell.note = infoDict[kProductNoteKey];
                
                [cell setProductNoteBlock:^(NSString *note) {
                    [infoDict setObject:note forKey:kProductNoteKey];
                }];
                __weak ProductNoteCell *weakSelf = cell;
                [cell setProductNoteImagesAddBlock:^{
                    CGRect popLocation = CGRectMake(0, 0, weakSelf.frame.size.width, weakSelf.frame.size.height);
                    
                    
                    self.noteImagePopover = [QYSPopMenusViewController popverController:self menus:@[@"拍照",@"相册"]];
                    
                    [_noteImagePopover presentPopoverFromRect:popLocation inView:weakSelf permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                }];
                
                [cell setReloadProductNoteImageCell:^(BOOL finised, NSInteger index) {
                    [self.noteImages removeObjectAtIndex:index];
                    [infoDict setObject:_noteImages forKey:kProductNoteImagesKey];
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
                
                return cell;
            }else if (indexPath.row == 5) {
                ProductBuyNoteCell *cell = [[ProductBuyNoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info_cell_buy_note"];
                cell.buyNote = infoDict[kProductBuyNoteKey];
                
                [cell setProductBuyNoteBlock:^(NSString *buyNote) {
                    [infoDict setObject:buyNote forKey:kProductBuyNoteKey];
                }];
                
                return cell;
            }
            
        }
            break;
        case 3:
        {
            ProductTimeCell *cell = [[ProductTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info_time_cell"];
            cell.timeString = infoDict[kProductTimeKey];
            return cell;
        }
            break;
    }
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *infoDict = [_addManager findInfoDict];
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        CGRect f = [cell convertRect:cell.bounds toView:self.view.superview.superview];
        
        ProductCategoryViewController *viewController = [[ProductCategoryViewController alloc] init];
        
        [viewController setDismissBlock:^(ProductCategoryViewController *viewController) {
            [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
        [viewController setProductCategoryClickedBlock:^(ProductCategoryViewController *viewController,CategoryTitle *categoryTitle, CategoryList *categoryList) {
            [viewController dismissViewControllerAnimated:YES completion:^{
                
                [infoDict setObject:categoryTitle forKey:kProductCidKey];
                [infoDict setObject:categoryList forKey:kProductCcidKey];
                
                //刷新商品类别的数据
                ProductCateCell *cateCell = (ProductCateCell *)[tableView cellForRowAtIndexPath:indexPath];
                NSString *cidVaule = categoryTitle.name;
                NSString *ccidvalue = categoryList.name;
                cateCell.cateContent = [[cidVaule addString:@","] addString:ccidvalue];
            }];
        }];
        
        UIPopoverController *pc = [[UIPopoverController alloc] initWithContentViewController:viewController];
        pc.popoverContentSize = CGSizeMake(350.0f, 500.0f);
        [pc presentPopoverFromRect:f inView:self.view.superview.superview permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
        return;
    }else if (indexPath.section == 3 && indexPath.row == 0) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        CGRect f = [cell convertRect:cell.bounds toView:self.view.superview.superview];
        
        ProductTimeViewController *viewController = [[ProductTimeViewController alloc] init];
        
        [viewController setProductTimeViewClickedBlock:^(ProductTimeViewController *viewController, NSString *timeInfo) {
            [viewController dismissViewControllerAnimated:YES completion:^{
                [infoDict setObject:timeInfo forKey:kProductTimeKey];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }];
        
        [viewController setDismissBlock:^(ProductTimeViewController *viewController) {
            [viewController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        
        UIPopoverController *pc = [[UIPopoverController alloc] initWithContentViewController:viewController];
        pc.popoverContentSize = CGSizeMake(350.0f, 500.0f);
        [pc presentPopoverFromRect:f inView:self.view.superview.superview permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
}

#pragma mark - QYSPopMenusViewControllerDelegate

- (void)popMenusViewController:(QYSPopMenusViewController *)controller didSelectRowAtIndex:(NSNumber *)index
{
    [controller.popverController dismissPopoverAnimated:NO];
    
    if (controller.popverController == _titleImagePopover) {
        self.titleImagePicker = [[ELCImagePickerController alloc] initImagePicker];
        self.titleImagePicker.maximumImagesCount = 5 - self.titleImages.count;
        self.titleImagePicker.returnsOriginalImage = YES;
        self.titleImagePicker.returnsImage = YES;
        self.titleImagePicker.onOrder = YES;
        self.titleImagePicker.imagePickerDelegate = self;
        if (0 == [index intValue]){
            self.titleImagesPickerViewController = [[UIImagePickerController alloc] init];
            self.titleImagesPickerViewController.allowsEditing = YES;
            self.titleImagesPickerViewController.delegate = self;
            self.titleImagesPickerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:_titleImagesPickerViewController animated:YES completion:nil];
        } else {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            CGRect f = [cell convertRect:cell.bounds toView:self.view.superview.superview];
            
            UIPopoverController *pc = [[UIPopoverController alloc] initWithContentViewController:_titleImagePicker];
            pc.popoverContentSize = CGSizeMake(350, self.view.bounds.size.height);
            [pc presentPopoverFromRect:f inView:self.view.superview.superview permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
        }
    }else {
        self.noteImagePicker = [[ELCImagePickerController alloc] initImagePicker];
        self.noteImagePicker.maximumImagesCount = 29 - self.noteImages.count;
        self.noteImagePicker.returnsOriginalImage = YES;
        self.noteImagePicker.returnsImage = YES;
        self.noteImagePicker.onOrder = YES;
        self.noteImagePicker.imagePickerDelegate = self;
        if (0 == [index intValue]){
            self.noteImagesPickerViewController = [[UIImagePickerController alloc] init];
            self.noteImagesPickerViewController.allowsEditing = YES;
            self.noteImagesPickerViewController.delegate = self;
            self.noteImagesPickerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:_noteImagesPickerViewController animated:YES completion:nil];
        } else {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:2]];
            CGRect f = [cell convertRect:cell.bounds toView:self.view.superview.superview];
            
            UIPopoverController *pc = [[UIPopoverController alloc] initWithContentViewController:_noteImagePicker];
            pc.popoverContentSize = CGSizeMake(350, self.view.bounds.size.height);
            [pc presentPopoverFromRect:f inView:self.view.superview.superview permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
        }
    }
}

#pragma mark -

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSMutableDictionary *infoDict = [_addManager findInfoDict];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage *aImage = [image compressedImage];
        if (picker == _titleImagesPickerViewController) {
            //刷新TitleImagesCell
            ProductTitleImagesCell *cell = (ProductTitleImagesCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [self.titleImages addObjectsFromArray:@[aImage]];
            cell.titleImages = _titleImages;
            [infoDict setObject:_titleImages forKey:kProductTitleImageKey];
            
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            return ;
        }
        //刷新noteImagesCell
        ProductNoteCell *cell = (ProductNoteCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:2]];
        [self.noteImages addObjectsFromArray:@[aImage]];
        cell.noteImages = _noteImages;
        [infoDict setObject:_noteImages forKey:kProductNoteImagesKey];
        
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
    }];
}


#pragma mark - ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    NSMutableDictionary *infoDict = [_addManager findInfoDict];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                [images addObject:[image compressedImage]];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                [images addObject:[image compressedImage]];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    
    if (picker == _titleImagePicker) {
        
        //刷新TitleImagesCell
        ProductTitleImagesCell *cell = (ProductTitleImagesCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [self.titleImages addObjectsFromArray:images];
        cell.titleImages = _titleImages;
        [infoDict setObject:_titleImages forKey:kProductTitleImageKey];
        
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    }else if (picker == _noteImagePicker) {
        
        //刷新noteImagesCell
        ProductNoteCell *cell = (ProductNoteCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:2]];
        [self.noteImages addObjectsFromArray:images];
        cell.noteImages = _noteImages;
        [infoDict setObject:_noteImages forKey:kProductNoteImagesKey];
        
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
        
    }

}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
