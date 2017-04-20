//
//  ProductTitleImagesCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductTitleImagesCell.h"

@interface ProductTitleImageDetailCell : UICollectionViewCell
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UIButton *btnRemove;
@property (nonatomic, assign) BOOL isLast;

@end

@implementation ProductTitleImageDetailCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = COLOR_MAIN_WHITE;
        
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_imageView];
        
        UIButton *btn_del = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_del.translatesAutoresizingMaskIntoConstraints = NO;
        [btn_del setImage:[UIImage imageNamed:@"macc-item-add-remove"] forState:UIControlStateNormal];
        [self.contentView addSubview:btn_del];
        _btnRemove = btn_del;
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_imageView, btn_del);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_imageView]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[btn_del(20)]-3-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[btn_del(20)]" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_isLast) {
        _btnRemove.userInteractionEnabled = NO;
        _btnRemove.alpha = 0.0;
    }else {
        _btnRemove.userInteractionEnabled = YES;
        _btnRemove.alpha = 1.0;
    }
}


@end


@interface ProductTitleImagesCell()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *imagesCollectionView;
@property (nonatomic, strong) NSMutableArray *tImages;

@end

@implementation ProductTitleImagesCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc] init];
        [flow_layout setItemSize:CGSizeMake(106, 106)];
        [flow_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow_layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        
        self.imagesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow_layout];
        self.imagesCollectionView.backgroundColor = [UIColor whiteColor];
        self.imagesCollectionView.scrollEnabled = NO;
        self.imagesCollectionView.delegate = self;
        self.imagesCollectionView.dataSource = self;
        [self.imagesCollectionView registerClass:[ProductTitleImageDetailCell class] forCellWithReuseIdentifier:@"image-cell"];
        [self.contentView addSubview:_imagesCollectionView];
    }
    return self;
}


-(void) setTitleImages:(NSArray *)titleImages {
    if (nil == _tImages) {
        self.tImages = [NSMutableArray new];
    }
    
    if (nil != titleImages && [titleImages count] > 0) {
        
        if ([_tImages count] > 0) {
            [_tImages removeAllObjects];
        }
        self.tImages = [titleImages mutableCopy];
    }

    UIImage *addImage = [UIImage imageNamed:@"macc-item-add-new"];
    [self.tImages insertObject:addImage atIndex:[_tImages count]];
    
    self.imagesCollectionView.frame = CGRectMake(0, 0, 400, [ProductTitleImagesCell heightForCellWithImage:_tImages]);
   
    [self.imagesCollectionView reloadData];
}

#pragma mark - Actions

- (void)btnRemoveClick:(UIButton *)sender {
    NSInteger index = sender.tag - 100;
    [self.tImages removeObjectAtIndex:index];
    [self.imagesCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
    if (self.reloadProductTitleImageCell) {
        self.reloadProductTitleImageCell(YES, index);
    }
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_tImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {    
    ProductTitleImageDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image-cell" forIndexPath:indexPath];
    cell.btnRemove.tag = indexPath.row+100;
    [cell.btnRemove removeTarget:self action:@selector(btnRemoveClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnRemove addTarget:self action:@selector(btnRemoveClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.imageView.image = _tImages[indexPath.row];
    cell.isLast = (_tImages.count - 1 == indexPath.row) ? YES : NO;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [_tImages count] - 1) {
        if (self.productAddBlock) {
            self.productAddBlock();
        }
        return;
    }
    
    if (self.productImagesClicedBlock) {
        self.productImagesClicedBlock(indexPath.row);
    }
}

#pragma mark - Cell height

+(CGFloat) heightForCellWithImage:(NSArray *)images; {
    
    NSInteger count = (nil == images || [images count] == 0) ? 0 : [images count];
    if (count + 1 <= 3) {
        return 139.0f;
    }else {
        return 278.0f;
    }
}

@end
