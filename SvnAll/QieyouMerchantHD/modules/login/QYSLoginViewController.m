//
//  QYSLoginViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/7/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSLoginViewController.h"
#import "LoginingAnimateView.h"


@interface QYSLoginViewController ()

@property (nonatomic, strong) UITextField *tfUsername;
@property (nonatomic, strong) UITextField *tfPassword;

@property (nonatomic, assign) CGPoint viewCenter;
@property (nonatomic, strong) UIButton *btn_login;
@property (nonatomic, strong) UIButton *btn_find_pwd;
@property (nonatomic, strong) LoginingAnimateView *loginingView;

@end

@implementation QYSLoginViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _tfUsername = nil;
    _tfPassword = nil;
    _btn_login = nil;
    _btn_find_pwd =nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    // Do any additional setup after loading the view. //434x344
    
    self.view.layer.cornerRadius = 8.0;
    self.view.layer.masksToBounds = YES;
    
    UILabel *lb_title = [[UILabel alloc] initWithFrame:CGRectMake(-1, -1, 436, 345)];
    lb_title.translatesAutoresizingMaskIntoConstraints = NO;
    lb_title.layer.borderColor = COLOR_MAIN_BORDER_GRAY.CGColor;
    lb_title.layer.borderWidth = 0.5;
    lb_title.backgroundColor = COLOR_MAIN_WHITE;
    lb_title.textColor = COLOR_TEXT_GRAY;
    lb_title.textAlignment = NSTextAlignmentCenter;
    lb_title.font = FONT_WITH_SIZE(25);
    lb_title.text = @"且游登录";
    [self.view addSubview:lb_title];
    
    UIView *input_view = [[UIView alloc] init];
    input_view.backgroundColor = COLOR_MAIN_WHITE;
    input_view.translatesAutoresizingMaskIntoConstraints = NO;
    input_view.layer.cornerRadius = 5.0;
    input_view.layer.masksToBounds = YES;
    [self.view addSubview:input_view];
    
    {
        UIImageView *left_v;
        
        self.tfUsername = [[UITextField alloc] init];
        _tfUsername.translatesAutoresizingMaskIntoConstraints = NO;
        _tfUsername.placeholder = @"请输入用户名";
        [input_view addSubview:_tfUsername];
        
        left_v = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lg-icon-02"]];
        left_v.frame = CGRectMake(0, 0, 25, 25);
        left_v.contentMode = UIViewContentModeCenter;
        _tfUsername.leftView = left_v;
        _tfUsername.leftViewMode = UITextFieldViewModeAlways;
        _tfUsername.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tfUsername.keyboardType = UIKeyboardTypeNumberPad;
        
        UIView *line = [[UIView alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = COLOR_HEX2RGB(0xd4d4d4);
        [input_view addSubview:line];
        
        self.tfPassword = [[UITextField alloc] init];
        _tfPassword.translatesAutoresizingMaskIntoConstraints = NO;
        _tfPassword.placeholder = @"请输入密码";
        _tfPassword.secureTextEntry = YES;
        [input_view addSubview:_tfPassword];
        
        left_v = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lg-icon-01"]];
        left_v.frame = CGRectMake(0, 0, 25, 25);
        left_v.contentMode = UIViewContentModeCenter;
        _tfPassword.leftView = left_v;
        _tfPassword.leftViewMode = UITextFieldViewModeAlways;
        _tfPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        NSDictionary *vds2 = NSDictionaryOfVariableBindings(_tfUsername, line, _tfPassword);
        [input_view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-38-[_tfUsername]-38-|" options:0 metrics:nil views:vds2]];
        [input_view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[line]-|" options:0 metrics:nil views:vds2]];
        [input_view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-38-[_tfPassword]-38-|" options:0 metrics:nil views:vds2]];
        [input_view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_tfUsername][line(0.5)]" options:0 metrics:nil views:vds2]];
        [input_view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(0.5)][_tfPassword]|" options:0 metrics:nil views:vds2]];
        
        [input_view addConstraint:[NSLayoutConstraint constraintWithItem:line
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:input_view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0.0]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    
    self.btn_find_pwd = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_find_pwd.translatesAutoresizingMaskIntoConstraints = NO;
    self.btn_find_pwd.titleLabel.font = FONT_WITH_SIZE(20);
    self.btn_find_pwd.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.btn_find_pwd setTitleColor:COLOR_TEXT_GRAY forState:UIControlStateNormal];
    [self.btn_find_pwd setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.btn_find_pwd addTarget:self action:@selector(btnFindPwdClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn_find_pwd];
    
    self.btn_login = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_login.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btn_login setTitle:@"登 录" forState:UIControlStateNormal];
    [self.btn_login setBackgroundImage:[[UIImage imageNamed:@"btn-bg-orange"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [self.btn_login addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn_login];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(lb_title, _btn_find_pwd, input_view, _btn_login);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(-1)-[lb_title]-(-1)-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_btn_find_pwd(100)]-20-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-41-[input_view]-41-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-41-[_btn_login]-41-|" options:0 metrics:nil views:vds]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-1)-[lb_title(69)]-32-[input_view]-36-[_btn_login(44)]-31-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-23-[_btn_find_pwd(25)]" options:0 metrics:nil views:vds]];
    
    
    UIButton *btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_close setImage:[UIImage imageNamed:@"lg-btn-close"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
    btn_close.frame = CGRectMake(23, 23, 29, 25);
    [self.view addSubview:btn_close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)onKeyboardShow:(NSNotification *)notify
{
    if (!_viewCenter.x)
    {
        _viewCenter = self.view.center;
    }
    
    CGPoint p = _viewCenter;
    p.y -= 150;
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.view.center = p;
                     }];
}

- (void)onKeyboardHide:(NSNotification *)notify
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.view.center = _viewCenter;
                     }];
}

#pragma mark -

- (void)btnCloseClick:(UIButton *)sender
{
    if (_closeBlock)
    {
        _closeBlock(self);
    }
}

-(void)forbidUI {
    if ([_tfPassword isFirstResponder]) {
        [_tfPassword resignFirstResponder];
    }
    
    if ([_tfUsername isFirstResponder]) {
        [_tfUsername resignFirstResponder];
    }
    
    if (_btn_find_pwd.userInteractionEnabled) {
        self.btn_find_pwd.userInteractionEnabled = NO;
    }
    if (_tfUsername.userInteractionEnabled) {
        self.tfUsername.userInteractionEnabled = NO;
    }
    
    if (_tfPassword.userInteractionEnabled) {
        [self.tfPassword setUserInteractionEnabled:NO];
    }
    
    if (nil == _loginingView) {
        self.loginingView = [[LoginingAnimateView alloc] initWithFrame:_btn_login.bounds];
    }
    [self.btn_login setTitle:@"" forState:UIControlStateNormal];
    [self.btn_login setBackgroundColor:[UIColor lightGrayColor]];
    [self.btn_login addSubview:_loginingView];
}

-(void)activateUI {
    if (!_tfUsername.userInteractionEnabled) {
        [self.tfUsername setUserInteractionEnabled:YES];
    }
    
    if (!_tfPassword.userInteractionEnabled) {
        [self.tfPassword setUserInteractionEnabled:YES];
    }
    
    if (!_btn_find_pwd.userInteractionEnabled) {
        [self.btn_login setUserInteractionEnabled:YES];
    }
    
    if (nil != _loginingView) {
        [_loginingView removeFromSuperview];
    }
    
    [self.btn_login setTitle:@"登 录" forState:UIControlStateNormal];
    [self.btn_login setBackgroundImage:[[UIImage imageNamed:@"btn-bg-orange"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    
}

- (void)btnLoginClick:(UIButton *)sender
{
    
    NSString *account = _tfUsername.text;
    NSString *password = _tfPassword.text;
    
    //开启登录动画，禁止其他按钮操作
    
    [LoginService loginWithAccount:account password:password doing:^{
        [self forbidUI];
    } complete:^(LoginResponseObject *loginResponseObject) {
        if (_loginCompleteBlock) {
            [self activateUI];
            _loginCompleteBlock(self, nil);
        }
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
        [self activateUI];
    }];
}

- (void)btnFindPwdClick:(UIButton *)sender
{
    NSString *showInfo = @"请联系且游客服进行修改密码 \n 客服电话：";
    NSString *info = [showInfo addString:kQieyouServiceTEL];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:info  delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
    [alertView show];
    [alertView bk_setDidDismissBlock:^(UIAlertView *alertV, NSInteger index) {
        
    }];
}

@end
