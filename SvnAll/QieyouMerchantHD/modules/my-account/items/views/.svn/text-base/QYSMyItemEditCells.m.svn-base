//
//  QYSMyItemEditCells.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/18.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSMyItemEditCells.h"

#pragma mark - QYSMyItemEditCell

@implementation QYSMyItemEditCell

+ (CGFloat)heightForCell
{
    return 60.0;
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
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)infoDict
{
    
}

@end

#pragma mark - QYSMyItemEditCoversCell

#pragma mark QYSEditImagesCollectCell

@interface QYSEditImagesCollectCell : UICollectionViewCell

@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UIButton *btnRemove;
@property (nonatomic, assign) BOOL isLast;

@end

@implementation QYSEditImagesCollectCell

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_isLast)
    {
        _btnRemove.userInteractionEnabled = NO;
        _btnRemove.alpha = 0.0;
    }
    else
    {
        _btnRemove.userInteractionEnabled = YES;
        _btnRemove.alpha = 1.0;
    }
}

@end

#pragma mark QYSMyItemEditCoversCell

@interface QYSMyItemEditCoversCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation QYSMyItemEditCoversCell

+ (CGFloat)heightFor4Cell:(int)imagesCount
{
    return ceilf((imagesCount+1)/4.0)*106.0+40.0;
}

+ (CGFloat)heightForCell:(int)imagesCount
{
    return ceilf((imagesCount+1)/3.0)*106.0+40.0;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc] init];
        [flow_layout setItemSize:CGSizeMake(106, 106)];
        [flow_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow_layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        
        _imagesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow_layout];
        _imagesCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _imagesCollectionView.backgroundColor = [UIColor whiteColor];
        _imagesCollectionView.scrollEnabled = NO;
        [_imagesCollectionView registerClass:[QYSEditImagesCollectCell class] forCellWithReuseIdentifier:@"images-cell"];
        [self.contentView addSubview:_imagesCollectionView];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_imagesCollectionView);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_imagesCollectionView]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imagesCollectionView]|" options:0 metrics:nil views:vds]];
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    _imagesCollectionView.delegate = self;
    _imagesCollectionView.dataSource = self;
    [_imagesCollectionView reloadData];
}

- (void)btnRemoveClick:(UIButton *)sender
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(myItemEditCellDidClickRemoveImageButton:index:)])
    {
        [_actDelegate performSelector:@selector(myItemEditCellDidClickRemoveImageButton:index:) withObject:self withObject:@(sender.tag-100)];
    }
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYSEditImagesCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"images-cell" forIndexPath:indexPath];
    cell.btnRemove.tag = indexPath.row+100;
    [cell.btnRemove removeTarget:self action:@selector(btnRemoveClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnRemove addTarget:self action:@selector(btnRemoveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_images.count <= indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"macc-item-add-new"];
        cell.isLast = YES;
    }
    else
    {
        cell.imageView.image = _images[indexPath.row];
        cell.isLast = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(myItemEditCellDidClickNewImageButton:)])
    {
        [_actDelegate performSelector:@selector(myItemEditCellDidClickNewImageButton:) withObject:self];
    }
}

@end

#pragma mark - QYSMyItemEditOptionsCell

@implementation QYSMyItemEditOptionsCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = FONT_NORMAL;
        _titleLabel.textColor = COLOR_TEXT_BLACK;
        [self.contentView addSubview:_titleLabel];
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _valueLabel.font = FONT_NORMAL;
        _valueLabel.textColor = COLOR_TEXT_GRAY;
        _valueLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_valueLabel];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"macc-item-add-assory"]];
        self.accessoryView = iv;
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_titleLabel, _valueLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_titleLabel(100)]-[_valueLabel]-25-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_valueLabel]|" options:0 metrics:nil views:vds]];
        
    }
    return self;
}

@end

#pragma mark - QYSMyItemEditEditableCell

@implementation QYSMyItemEditEditableCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
    }
    return self;
}

@end

#pragma mark - QYSMyItemEditTextViewCell

@implementation QYSMyItemEditTextViewCell

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
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
        
        _inputField = [[UITextView alloc] init];
        _inputField.translatesAutoresizingMaskIntoConstraints = NO;
        _inputField.font = FONT_NORMAL;
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

@end

#pragma mark - QYSMyItemEditIntroduceCell

@interface QYSMyItemEditIntroduceCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation QYSMyItemEditIntroduceCell

+ (CGFloat)heightForCell:(id)content imagesCount:(int)imagesCount
{
    CGFloat h = 0.0;
    CGSize s = [content sizeWithAttributes:@{NSFontAttributeName:FONT_NORMAL}];
    
    if (s.height < 15)
    {
        h = 60.0;
    }
    else if (s.height > 200.0)
    {
        h = 200.0;
    }
    else
    {
        h = s.height+16.0;
    }
    
    h += ceilf((imagesCount+1)/3.0)*106.0+40.0;
    
    return h;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
        
        UIView *right_v = [[UIView alloc] init];
        right_v.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:right_v];
        
        _inputField = [[UITextView alloc] init];
        _inputField.translatesAutoresizingMaskIntoConstraints = NO;
        _inputField.font = FONT_NORMAL;
        _inputField.textColor = COLOR_TEXT_GRAY;
        [right_v addSubview:_inputField];
        
        UIView *line2 = [[UIView alloc] init];
        line2.translatesAutoresizingMaskIntoConstraints = NO;
        line2.backgroundColor = COLOR_MAIN_BORDER_GRAY;
        [right_v addSubview:line2];
        
        UILabel *lb_tips = [[UILabel alloc] init];
        lb_tips.translatesAutoresizingMaskIntoConstraints = NO;
        lb_tips.font = FONT_WITH_SIZE(12.0);
        lb_tips.textColor = COLOR_TEXT_RED;
        lb_tips.text = @"请在此处增加详情图片";
        [right_v addSubview:lb_tips];
        
        UICollectionViewFlowLayout *flow_layout = [[UICollectionViewFlowLayout alloc] init];
        [flow_layout setItemSize:CGSizeMake(41, 41)];
        [flow_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flow_layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _imagesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow_layout];
        _imagesCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _imagesCollectionView.backgroundColor = [UIColor whiteColor];
        _imagesCollectionView.scrollEnabled = NO;
        [_imagesCollectionView registerClass:[QYSEditImagesCollectCell class] forCellWithReuseIdentifier:@"images-cell"];
        [right_v addSubview:_imagesCollectionView];
        
        NSDictionary *vds = NSDictionaryOfVariableBindings(_titleLabel, line, right_v, _inputField,lb_tips, _imagesCollectionView,line2);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_titleLabel(90)]-[line(0.5)]-[right_v]-|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLabel(20)]" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[line]|" options:0 metrics:nil views:vds]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[right_v]|" options:0 metrics:nil views:vds]];
        
        [right_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_inputField]-|" options:0 metrics:nil views:vds]];
        [right_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line2]|" options:0 metrics:nil views:vds]];
        [right_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_imagesCollectionView]-|" options:0 metrics:nil views:vds]];
        [right_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[lb_tips]-|" options:0 metrics:nil views:vds]];
        [right_v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_inputField]-[line2(0.5)]-[lb_tips]-[_imagesCollectionView]-|" options:0 metrics:nil views:vds]];
        
        [right_v addConstraint:[NSLayoutConstraint constraintWithItem:line2
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:right_v
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:0.0]];
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    _imagesCollectionView.delegate = self;
    _imagesCollectionView.dataSource = self;
    [_imagesCollectionView reloadData];
}

- (void)btnRemoveClick:(UIButton *)sender
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(myItemEditCellDidClickRemoveImageButton:index:)])
    {
        [_actDelegate performSelector:@selector(myItemEditCellDidClickRemoveImageButton:index:) withObject:self withObject:@(sender.tag-100)];
    }
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYSEditImagesCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"images-cell" forIndexPath:indexPath];
    cell.btnRemove.tag = indexPath.row+100;
    [cell.btnRemove removeTarget:self action:@selector(btnRemoveClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnRemove addTarget:self action:@selector(btnRemoveClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_images.count <= indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"macc-item-add-new"];
        cell.isLast = YES;
    }
    else
    {
        cell.imageView.image = _images[indexPath.row];
        cell.isLast = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(myItemEditCellDidClickNewImageButton:)])
    {
        [_actDelegate performSelector:@selector(myItemEditCellDidClickNewImageButton:) withObject:self];
    }
}

@end
