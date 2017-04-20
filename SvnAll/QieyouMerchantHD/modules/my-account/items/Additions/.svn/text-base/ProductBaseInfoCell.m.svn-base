//
//  ProductBaseInfoCell.m
//  QieYouShop
//
//  Created by 李赛强 on 15/4/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "ProductBaseInfoCell.h"

@interface ProductBaseInfoCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ProductBaseInfoCell

-(void)dealloc {
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [UILabel LabelWithFrame:CGRectMake(20, 25, 65, 15)
                                             text:@""
                                        textColor:[UIColor colorForHexString:@"#333333"]
                                             font:15.0f
                                    textAlignment:NSTextAlignmentLeft];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 0.5f, 62.0f)];
        line.backgroundColor = [UIColor colorForHexString:@"#e2e2e2"];
        [self.contentView addSubview:line];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(110 + 18, 0, 400 - 110 - 2 * 18, 62.0f)];
        self.textField.font = [UIFont systemFontOfSize:14.0f];
        self.textField.textColor = [UIColor colorForHexString:@"#333333"];
        self.textField.delegate = self;
        [self.contentView addSubview:_textField];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_textField];
        
    }
    return self;
}

-(void) setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

-(void) setPlaceHolder:(NSString *)placeHolder {
    self.textField.placeholder = placeHolder;
}

-(void) setKeyboardType:(UIKeyboardType)keyboardType {
    self.textField.keyboardType = keyboardType;
}

-(void) setContent:(NSString *)content {
    self.textField.text = content;
}

- (void)textFieldChanged:(id)sender {
    NSLog(@"%@",_textField.text);
    if (self.productBaseInfoBlock) {
        self.productBaseInfoBlock(_textField.text);
    }
}



@end
