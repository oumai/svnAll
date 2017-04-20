//
//  ProductNoteCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductNoteCell.h"

@interface ProductNoteImageDetailCell : UICollectionViewCell
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UIButton *btnRemove;
@property (nonatomic, assign) BOOL isLast;

@end

@implementation ProductNoteImageDetailCell

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

@interface ProductNoteCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SQTextView *textView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) NSMutableArray *tImages;
@property (nonatomic, strong) UICollectionView *imagesCollectionView;

@end

@implementation ProductNoteCell

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel LabelWithFrame:CGRectMake(20, 25, 65, 15)
                                             text:@"商品介绍"
                                        textColor:[UIColor colorForHexString:@"#333333"]
                                             font:15.0f
                                    textAlignment:NSTextAlignmentLeft];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLabel];
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 0.5f, 111.0f)];
        self.line.backgroundColor = [UIColor colorForHexString:@"#e2e2e2"];
        [self.contentView addSubview:_line];
        
        self.textView = [[SQTextView alloc] initWithFrame:CGRectMake(110 + 18, 18, 400 - 110 - 2 * 18, 111.0f - 36.0f)];
        self.textView.font = [UIFont systemFontOfSize:14.0f];
        self.textView.placeholder = @"请输入商品详情";
        self.textView.textColor = [UIColor colorForHexString:@"#333333"];
        [self.contentView addSubview:_textView];

        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(110.0f, 111.0f, 400 - 110.0f, 0.5f)];
        line1.backgroundColor = [UIColor colorForHexString:@"#e2e2e2"];
        [self.contentView addSubview:line1];
        
        UILabel *imageTitleLabel = [UILabel LabelWithFrame:CGRectMake(110 + 18, 111.0 + 20, 125, 12.0f) text:@"请在此处增加商品详情图片" textColor:[UIColor colorForHexString:@"#d76e66"] font:10.0f textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:imageTitleLabel];
        
        UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc] init];
        [flow_layout setItemSize:CGSizeMake(42, 42)];
        [flow_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow_layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.imagesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow_layout];
        self.imagesCollectionView.backgroundColor = [UIColor whiteColor];
        self.imagesCollectionView.scrollEnabled = NO;
        self.imagesCollectionView.delegate = self;
        self.imagesCollectionView.dataSource = self;
        [self.imagesCollectionView registerClass:[ProductNoteImageDetailCell class] forCellWithReuseIdentifier:@"note_images-cell"];
        [self.contentView addSubview:_imagesCollectionView];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:_textView];
        
    }
    
    return self;
}

-(void)textViewChanged:(id)sender {
    if (self.productNoteBlock) {
        self.productNoteBlock(_textView.text);
    }
}

-(void) setNote:(NSString *)note {
    self.textView.text = note;
}

-(void) setNoteImages:(NSArray *)noteImages {
    
    //动态处理
    CGFloat height = [ProductNoteCell heightForCellWithImages:noteImages];
    self.line.frame = CGRectMake(110.0f, 0, 0.5f, height);
    
    
    if (nil == _tImages) {
        self.tImages = [NSMutableArray new];
    }
    
    if (nil != noteImages && [noteImages count] > 0) {
        
        if ([_tImages count] > 0) {
            [_tImages removeAllObjects];
        }
        self.tImages = [noteImages mutableCopy];
    }
    
    UIImage *addImage = [UIImage imageNamed:@"macc-item-add-new"];
    [self.tImages insertObject:addImage atIndex:[_tImages count]];
    
    self.imagesCollectionView.frame = CGRectMake(110 + 18, 111.0f + 40, 400 - 110 - 36, height - 161);
    
    [self.imagesCollectionView reloadData];
    
    
}

#pragma mark - Actions

- (void)btnRemoveClick:(UIButton *)sender {
    NSInteger index = sender.tag - 100;
    [self.tImages removeObjectAtIndex:index];
    [self.imagesCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
    if (self.reloadProductNoteImageCell) {
        self.reloadProductNoteImageCell(YES, index);
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
    ProductNoteImageDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"note_images-cell" forIndexPath:indexPath];
    cell.btnRemove.tag = indexPath.row+100;
    [cell.btnRemove removeTarget:self action:@selector(btnRemoveClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnRemove addTarget:self action:@selector(btnRemoveClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.imageView.image = _tImages[indexPath.row];
    cell.isLast = (_tImages.count - 1 == indexPath.row) ? YES : NO;
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 7.8;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [_tImages count] - 1) {
        if (self.productNoteImagesAddBlock) {
            self.productNoteImagesAddBlock();
        }
        return;
    }
    
    if (self.productNoteImagesClickedBlock) {
        self.productNoteImagesClickedBlock(indexPath.row);
    }
}

+(CGFloat)heightForCellWithImages:(NSArray *)images {
    
    NSInteger count = (nil == images || [images count] == 0) ? 0 : [images count];
    
    if (count + 1 <= 5) {
         return 111.0f + 58 + 50;
    }else if (count + 1 <= 10) {
        return 111.0f + 58 + 50 * 2;
    }else if (count + 1 <= 15) {
        return 111.0f + 58 + 50 * 3;
    }else if (count + 1 <= 20) {
        return 111.0f + 58.0f + 50 * 4;
    }else if (count + 1 <= 25) {
        return 111.0f + 58.0f + 50 * 5;
    }else if (count + 1 <= 30) {
        return 111.0f + 58.0f + 50 * 6;
    }
    
    return .0f;
}

@end
