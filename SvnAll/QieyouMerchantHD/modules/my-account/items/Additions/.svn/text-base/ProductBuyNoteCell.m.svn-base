//
//  ProductBuyNoteCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductBuyNoteCell.h"



@interface ProductBuyNoteCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SQTextView *textView;



@end

@implementation ProductBuyNoteCell

-(void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel LabelWithFrame:CGRectMake(20, 25, 65, 15)
                                             text:@"购买须知"
                                        textColor:[UIColor colorForHexString:@"#333333"]
                                             font:15.0f
                                    textAlignment:NSTextAlignmentLeft];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 0.5f, 180.0f)];
        line.backgroundColor = [UIColor colorForHexString:@"#e2e2e2"];
        [self.contentView addSubview:line];
        
        self.textView = [[SQTextView alloc] initWithFrame:CGRectMake(110 + 18, 18, 400 - 110 - 2 * 18, 180.0f - 36.0f)];
        self.textView.font = [UIFont systemFontOfSize:14.0f];
        self.textView.placeholder = @"请输入购买须知";
        self.textView.textColor = [UIColor colorForHexString:@"#333333"];
        [self.contentView addSubview:_textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChanged:) name:UITextViewTextDidChangeNotification object:_textView];
        

    }
    return self;
}

-(void) setBuyNote:(NSString *)buyNote {
    self.textView.text = buyNote;
}

-(void)textViewChanged:(id)sender {
    if (self.productBuyNoteBlock) {
        self.productBuyNoteBlock(_textView.text);
    }
}

@end
