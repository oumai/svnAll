//
//  ProductDetailNoteImagesCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/26.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductDetailNoteImagesCell.h"
#import "MJPhoto.h"

#define kMargin 10

@interface ProductDetailNoteItemCell : UITableViewCell
@property (nonatomic, strong) UIImageView *noteImageView;
@end

@implementation ProductDetailNoteItemCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.noteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (380 - 370) / 2, 609 - 2 * 21, 370)];
        [self.contentView addSubview:_noteImageView];
    }
    return self;
}

@end

@interface ProductDetailNoteImagesCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *noteImages;
@property (nonatomic, strong) NSMutableArray *mjPhotos;
@end

@implementation ProductDetailNoteImagesCell

-(id) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.noteImages = [NSMutableArray new];
        self.mjPhotos = [NSMutableArray new];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(21, kMargin, 609 - 2 * 21, frame.size.height - 2 *kMargin)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.scrollEnabled = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.bgImageView.userInteractionEnabled = YES;
        [self.bgImageView addSubview:_tableView];
    }
    
    return self;
}

-(void) setNoteImagesString:(NSString *)noteImagesString {
    if (nil == noteImagesString || noteImagesString.length == 0) {
        return;
    }
    
    NSArray *images = [NSString imagesArrayFromString:noteImagesString];
    if (nil == _noteImages) {
        self.noteImages = [NSMutableArray new];
    }
    
    if ([_noteImages count] > 0) {
        [_noteImages removeAllObjects];
    }
    
    self.noteImages = [images mutableCopy];
    
    if (nil == _mjPhotos) {
        self.mjPhotos = [NSMutableArray new];
    }
    
    if ([_mjPhotos count] > 0) {
        [_mjPhotos removeAllObjects];
    }
    
    for (NSString *imageUrl in _noteImages) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:kImageUrl(imageUrl)];
        [self.mjPhotos addObject:photo];
    }
    
    [self.tableView reloadData];
}

+(CGFloat) heightForCellWithImageCount:(NSInteger)imageCount {
    return 2 * kMargin + 380 * imageCount;
}

#pragma mark - UItableViewDelegate DataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_noteImages count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 380.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"note_images_cell";
    ProductDetailNoteItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ProductDetailNoteItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *imageUrl = _noteImages[indexPath.row];
    kSetIntenetImageWith(cell.noteImageView, imageUrl);
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.productNoteImagesClikedBlock) {
        self.productNoteImagesClikedBlock(_mjPhotos, indexPath.row);
    }
}

@end
