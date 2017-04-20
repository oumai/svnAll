//
//  QYSMyItemEditCells.h
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/18.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYSMyItemEditCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *infoDict;

+ (CGFloat)heightForCell;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@interface QYSMyItemEditCoversCell : QYSMyItemEditCell

+ (CGFloat)heightForCell:(int)imagesCount;
+ (CGFloat)heightFor4Cell:(int)imagesCount;

@property (nonatomic, assign) id actDelegate;
@property (nonatomic, readonly) UICollectionView *imagesCollectionView;
@property (nonatomic, strong) NSArray *images;

@end

@interface QYSMyItemEditOptionsCell : QYSMyItemEditCell

@property (nonatomic, strong) NSArray *options;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *valueLabel;

@end

@interface QYSMyItemEditEditableCell : QYSMyItemEditCell

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UITextField *inputField;

@end

@interface QYSMyItemEditTextViewCell : QYSMyItemEditCell

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UITextView *inputField;

+ (CGFloat)heightForCell:(id)content;

@end

@interface QYSMyItemEditIntroduceCell : QYSMyItemEditCell

@property (nonatomic, assign) id actDelegate;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UITextView *inputField;
@property (nonatomic, readonly) UICollectionView *imagesCollectionView;
@property (nonatomic, strong) NSArray *images;

+ (CGFloat)heightForCell:(id)content imagesCount:(int)imagesCount;

@end

@protocol QYSMyItemEditCellDelegate <NSObject>

@optional
- (void)myItemEditCellDidClickRemoveImageButton:(QYSMyItemEditCell *)cell index:(NSNumber *)index;

- (void)myItemEditCellDidClickNewImageButton:(QYSMyItemEditCell *)cell;

@end
