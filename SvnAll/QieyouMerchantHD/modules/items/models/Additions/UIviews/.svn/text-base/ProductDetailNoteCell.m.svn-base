//
//  ProductNoteCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/26.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductDetailNoteCell.h"

#define kMargin 10

@interface ProductDetailNoteCell ()
@property (nonatomic, strong) UILabel *noteLabel;
@end

@implementation ProductDetailNoteCell

-(id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.noteLabel = [UILabel LabelWithFrame:CGRectMake(21, kMargin, frame.size.width - 2 * 21, frame.size.height - 2 * kMargin) text:@"" textColor:[UIColor colorForHexString:@"#868686"] font:15.0f textAlignment:NSTextAlignmentLeft];
        self.noteLabel.numberOfLines = 0;
        self.noteLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self.bgImageView addSubview:_noteLabel];
    }
    return self;
}


-(void) setNote:(NSString *)note {
    self.noteLabel.text = note;
    
}

+(CGFloat) heightForCellWithNote:(NSString *)note {
    
    CGFloat noteHeight = [ProductDetailNoteCell labelCustomeHeight:note];
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
