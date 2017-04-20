//
//  StoreIntroductionCell.m
//  QieyouMerchant
//
//  Created by 李赛强 on 14/12/4.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import "StoreIntroductionCell.h"

@interface StoreIntroductionCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation StoreIntroductionCell

-(id) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (frame.size.height - 15) / 2, 15, 15)];
        [self.contentView addSubview:_iconImageView];
        
        self.contentLabel = [UILabel LabelWithFrame:CGRectMake(41, (frame.size.height - 15)/2, frame.size.width - 70, 15) text:@"" textColor:[UIColor colorForHexString:@"#666666"] font:15.0f textAlignment:NSTextAlignmentLeft];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self.contentView addSubview:_contentLabel];
    }
    
    return self;
}

-(void) setIconName:(NSString *)iconName {
    self.iconImageView.image = [UIImage imageNamed:iconName];
}

-(void) setContent:(NSString *)content {
    self.contentLabel.text = content;
}

+(CGFloat) heightForCell:(NSString *)content {
    return 2 * 23 + [StoreIntroductionCell labelCustomeHeight:content];
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


@interface StoreIntroductionNoteCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation StoreIntroductionNoteCell

-(id) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentLabel = [UILabel LabelWithFrame:CGRectMake(21, 10, 400 - 2 *21, frame.size.height - 2 * 10) text:@"" textColor:[UIColor colorForHexString:@"#8e8e8e"] font:15.0f textAlignment:NSTextAlignmentLeft];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

-(void) setContent:(NSString *)content {
    self.contentLabel.text = content;
}

+(CGFloat) heightForCell:(NSString *)content {
    return 2 * 10 + [StoreIntroductionNoteCell labelCustomeHeight:content];
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