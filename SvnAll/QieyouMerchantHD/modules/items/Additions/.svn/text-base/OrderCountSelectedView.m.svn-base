//
//  OrderCountSelectedView.m
//  QieyouMerchant
//
//  Created by 李赛强 on 15/1/28.
//  Copyright (c) 2015年 lisaiqiang. All rights reserved.
//

#import "OrderCountSelectedView.h"

#define kButtonDefaultWidth 30
#define KMargin 8

@interface OrderCountSelectedView ()<UITextFieldDelegate>

@property (nonatomic, copy) void (^orderCountSelectedBlock)(NSInteger count);
@property (nonatomic, copy) void (^orderCountSelectedErrorBlock)(NSString *error);
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *reduceButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) NSInteger defaultCount;

@end

@implementation OrderCountSelectedView

-(void)dealloc {
    _addButton = nil;
    _reduceButton = nil;
    _textField = nil;
    _orderCountSelectedBlock = nil;
    _orderCountSelectedErrorBlock = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(id) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.defaultCount = 1;
        self.reduceButton = [UIButton BUttonTitleWithFrame:CGRectMake(0, 0, kButtonDefaultWidth, kButtonDefaultWidth) bgImageNormal:@"order_count_reduce" bgImageHightlighted:@"order_count_reduce" tag:0 target:self action:@selector(reduceButtonClicked:)];
        [self.reduceButton setBackgroundImage:[UIImage imageNamed:@"order_count_not_reduce"] forState:UIControlStateDisabled];
        self.reduceButton.enabled = NO;
        
        self.addButton = [UIButton BUttonTitleWithFrame:CGRectMake(frame.size.width - kButtonDefaultWidth, 0, kButtonDefaultWidth, kButtonDefaultWidth) bgImageNormal:@"order_count_add" bgImageHightlighted:@"order_count_add" tag:1 target:self action:@selector(addButtonClicked:)];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(kButtonDefaultWidth + KMargin, 0, frame.size.width - 2 * (kButtonDefaultWidth + KMargin), kButtonDefaultWidth)];
        self.textField.text = [NSString stringWithFormat:@"%zd",_defaultCount];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.font = [UIFont systemFontOfSize:12.0f];
        self.textField.textColor = [UIColor colorForHexString:@"#878787"];
        self.textField.backgroundColor = [UIColor clearColor];
        self.textField.layer.borderColor = [UIColor colorForHexString:@"#a0a0a0"].CGColor;
        self.textField.layer.borderWidth = 0.5f;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.delegate = self;
        [self addSubview:_textField];
        [self addSubview:_reduceButton];
        [self addSubview:_addButton];
        
        //增加监听事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_textField];
    }
    return self;
}

-(void) orderCountSelectedWithCount:(void(^)(NSInteger count))block {
    self.orderCountSelectedBlock = block;
}

-(void) orderCountSelectedError:(void(^)(NSString *error))block {
    self.orderCountSelectedErrorBlock = block;
}

-(void)reloadDateInView:(UIView *)view {
    [view addSubview:self];
}

- (void)textFieldChanged:(id)sender {
    
    NSString *countString = _textField.text;
    NSLog(@"%@",countString);
    if (![NSString isPureIntValue:countString] || [countString integerValue] > _stockCount || [countString integerValue] == 0) {
        if (self.productCountIsNotValidBlock) {
            self.productCountIsNotValidBlock();
        }
    }
}


#pragma mark - Actions

-(void)reduceButtonClicked:(UIButton *)button {
    self.defaultCount -= 1;
    self.reduceButton.enabled = _defaultCount == 1 ? NO : YES;
    self.textField.text = [NSString stringWithFormat:@"%zd",_defaultCount];
    if (self.orderCountSelectedBlock) {
        self.orderCountSelectedBlock(_defaultCount);
    }
}

-(void)addButtonClicked:(UIButton *)button {
    self.defaultCount += 1;
    self.reduceButton.enabled = _defaultCount == 1 ? NO : YES;
    self.textField.text = [NSString stringWithFormat:@"%zd",_defaultCount];
    
    if (self.defaultCount > _stockCount) {
        if (self.productCountIsNotValidBlock) {
            self.productCountIsNotValidBlock();
        }
        return;
    }
    
    if (self.orderCountSelectedBlock) {
        self.orderCountSelectedBlock(_defaultCount);
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger count = [newString integerValue];
    if (count == 0) {
        self.defaultCount = 1;
        self.reduceButton.enabled = _defaultCount == 1 ? NO : YES;
        if (self.orderCountSelectedBlock) {
            self.orderCountSelectedBlock(_defaultCount);
        }
    }else {
        self.defaultCount = count;
        self.reduceButton.enabled = _defaultCount == 1 ? NO : YES;
        if (self.orderCountSelectedBlock) {
            self.orderCountSelectedBlock(_defaultCount);
        }
    }
    return YES;
}




@end
