//
//  QYSPostCodeViewController.m
//  QieYouShop
//
//  Created by LiYongQiang on 15/2/7.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSPostCodeViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface QYSPostCodeViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *tfCode;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation QYSPostCodeViewController

- (void)loadView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 540, 619)];
    v.backgroundColor = COLOR_MAIN_WHITE;
    v.layer.cornerRadius = 5.0;
    v.layer.masksToBounds = YES;
    
    self.view = v;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pc-navbar-bg"]];
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:iv];
    
    UILabel *lb_title = [[UILabel alloc] init];
    lb_title.translatesAutoresizingMaskIntoConstraints = NO;
    lb_title.text = @"快速验码";
    lb_title.font = FONT_WITH_SIZE(21);
    lb_title.textColor = COLOR_TEXT_BLACK;
    lb_title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb_title];
    
    UIButton *btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_close.frame = CGRectMake(0, 0, 32, 32);
    btn_close.center = CGPointMake(25, 22);
    [btn_close setImage:[UIImage imageNamed:@"pc-btn-close"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_close];
    
    self.tfCode = [[UITextField alloc] init];
    _tfCode.translatesAutoresizingMaskIntoConstraints = NO;
    _tfCode.backgroundColor = COLOR_MAIN_WHITE;
    _tfCode.font = FONT_WITH_SIZE(30.0);
    _tfCode.placeholder = @"请输入验证码";
    _tfCode.delegate = self;
    [self.view addSubview:_tfCode];
    
    UIButton *btn_clear = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_clear.frame = CGRectMake(0, 0, 22, 22);
    [btn_clear setImage:[UIImage imageNamed:@"pc-btn-clear"] forState:UIControlStateNormal];
    [btn_clear addTarget:self action:@selector(btnClearClick) forControlEvents:UIControlEventTouchUpInside];
    _tfCode.rightView = btn_clear;
    _tfCode.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *btns_view = [[UIView alloc] init];
    btns_view.translatesAutoresizingMaskIntoConstraints = NO;
    btns_view.backgroundColor = COLOR_HEX2RGB(0x756f7c);
    [self.view addSubview:btns_view];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(lb_title, _tfCode, btns_view,iv);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[iv]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[lb_title]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-25-[_tfCode]-25-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[btns_view]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[iv(45)]" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_title(45)][_tfCode(110)][btns_view]|" options:0 metrics:nil views:vds]];
    
    UIButton *btn;
    UIImage *btn_im = [[UIImage imageNamed:@"pc-btn-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    for (int i=0;i<4;i++)
    {
        for (int j=0;j<3;j++)
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(j*161+j*11+16, i*99+i*11+16, 163, 101);
            btn.tag = i*3+j;
            btn.titleLabel.font = [UIFont systemFontOfSize:60.0];
            [btn setTitleColor:COLOR_MAIN_WHITE forState:UIControlStateNormal];
            [btn setTitle:[NSString stringWithFormat:@"%d",i*3+j+1] forState:UIControlStateNormal];
            [btn setBackgroundImage:btn_im forState:UIControlStateNormal];
            [btns_view addSubview:btn];
            
            if (9 == btn.tag)
            {
                [btn setTitle:@"" forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"pc-btn-delete"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnDeleteClick) forControlEvents:UIControlEventTouchUpInside];
            }
            else if (10 == btn.tag)
            {
                [btn setTitle:@"0" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnNumericClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            else if (11 == btn.tag)
            {
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:30];
                [btn setTitle:@"确认发送" forState:UIControlStateNormal];
                [btn setBackgroundImage:[[UIImage imageNamed:@"pc-btn-bg-yellow"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnSendClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [btn addTarget:self action:@selector(btnNumericClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (NSString *)code
{
    return _tfCode.text;
}

#pragma mark -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

#pragma mark - buttons event

- (void)btnCloseClick
{
    if (self.closeBlock)
    {
        self.closeBlock(self);
    }
}

- (void)btnClearClick
{
    _tfCode.text = @"";
}

- (void)btnNumericClick:(UIButton *)sender
{
    if (_tfCode.text.length >= 12)
    {
        [JDStatusBarNotification showWithStatus:@"最多只能输入12位" dismissAfter:1.5f styleName:JDStatusBarStyleWarning];
        return;
    }
    
    _tfCode.text = [NSString stringWithFormat:@"%@%@", _tfCode.text, sender.titleLabel.text];
}

- (void)btnDeleteClick
{
    if (0 == _tfCode.text.length)
    {
        return;
    }
    
    _tfCode.text = [_tfCode.text substringToIndex:_tfCode.text.length-1];
}

- (void)btnSendClick:(UIButton *)sender
{
    NSString *code = _tfCode.text;
    if (code.length == 0) {
        JDStatusBarNotificationError(@"请输入验证码");
        return;
    }
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //显示的文字
    self.HUD.labelText = @"";
    //细节文字
    self.HUD.detailsLabelText = @"正在验码...";
    //是否有庶罩
    self.HUD.dimBackground = YES;
    [self.HUD show:YES];
    
    [[QuickVerifyService sharedQuickVerifyService] quickVerify:code login:^{
        
    } complete:^(NSString *data) {
        [self.HUD hide:YES];
        if (self.submitBlock)
        {
            self.submitBlock(self,data);
        }
    } error:^(NSString *error) {
        [self.HUD hide:YES];
        JDStatusBarNotificationError(error);
    }];
    
   
}

@end
