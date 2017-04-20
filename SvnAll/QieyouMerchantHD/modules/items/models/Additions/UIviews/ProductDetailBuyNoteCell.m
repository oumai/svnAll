//
//  ProductDetailBuyNoteCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/27.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductDetailBuyNoteCell.h"

#define kMargin 10

@interface ProductDetailBuyNoteCell ()
@property (nonatomic, strong) UILabel *buyNoteLabel;
@end

@implementation ProductDetailBuyNoteCell

-(id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.buyNoteLabel = [UILabel LabelWithFrame:CGRectMake(21, kMargin, frame.size.width - 2 * 21, frame.size.height - 2 * kMargin) text:@"" textColor:[UIColor colorForHexString:@"#868686"] font:15.0f textAlignment:NSTextAlignmentLeft];
        self.buyNoteLabel.numberOfLines = 0;
        self.buyNoteLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self.bgImageView addSubview:_buyNoteLabel];
    }
    return self;
}


-(void) setBuynote:(NSString *)buynote {
    self.buyNoteLabel.text = buynote;
}

+(CGFloat) heightForCellWithNote:(NSString *)note {
    
    CGFloat noteHeight = [ProductDetailBuyNoteCell labelCustomeHeight:note];
    return noteHeight + 2 * kMargin;
}

+(CGFloat) labelCustomeHeight:(NSString *)string {
    UILabel *label = [[UILabel alloc] init];
    label.text = string;
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = [UIColor colorForHexString:@"#686868"];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize constraint = CGSizeMake(609.0f - 2 * 21, 20000.0f);
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height =MAX(size.height, 40.0f);
    return height ;
}

@end
