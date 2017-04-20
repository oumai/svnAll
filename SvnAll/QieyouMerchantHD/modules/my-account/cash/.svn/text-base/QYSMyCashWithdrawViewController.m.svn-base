//
//  QYSMyCashWithdrawViewController.m
//  QieYouShop
//
//  Created by Vincent on 2/13/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSMyCashWithdrawViewController.h"
#import <BlocksKit/BlocksKit+UIKit.h>

@interface QYSMyCashWithdrawViewController ()

@property (nonatomic, strong) UITextField *tfMoney;
@property (nonatomic, strong) UILabel *totalCapitalLabel;
@property (nonatomic, strong) UILabel *availableLabel;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *balance;
@property (nonatomic, strong) UILabel *lb_filed4;
@property (nonatomic, strong) UIButton *btn_submit;

@end

@implementation QYSMyCashWithdrawViewController

-(void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[DrawMoneyService sharedDrawMoneyService] bankrollComplete:^(NSString *account, NSString *balance) {

        self.totalCapitalLabel.text = [NSString stringWithFormat:@"￥%@", account];//[@"￥ " addString:account];
        self.availableLabel.text = [NSString stringWithFormat:@"￥%@", balance];
        self.account = account;
        self.balance = balance;
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTheme];
    
    UILabel *lb_field0 = [[UILabel alloc] init];
    lb_field0.translatesAutoresizingMaskIntoConstraints = NO;
    lb_field0.textColor = COLOR_TEXT_GRAY;
    lb_field0.font = [UIFont systemFontOfSize:15.0];
    lb_field0.text = @"资产总览";
    [self.view addSubview:lb_field0];
    
    UIView *line = [[UIView alloc] init];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.backgroundColor = COLOR_HEX2RGB(0xd2d2d2);
    [self.view addSubview:line];
    
    UILabel *lb_filed1 = [[UILabel alloc] init];
    lb_filed1.translatesAutoresizingMaskIntoConstraints = NO;
    lb_filed1.textColor = COLOR_HEX2RGB(0x686868);
    lb_filed1.font = [UIFont systemFontOfSize:16.0];
    lb_filed1.text = @"总资产";
    [self.view addSubview:lb_filed1];
    
    self.totalCapitalLabel = [[UILabel alloc] init];
    _totalCapitalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _totalCapitalLabel.textColor = COLOR_HEX2RGB(0xd93229);
    _totalCapitalLabel.font = FONT_WITH_SIZE(18);
    _totalCapitalLabel.text = @"";
    [self.view addSubview:_totalCapitalLabel];
    
    UIView *line2 = [[UIView alloc] init];
    line2.translatesAutoresizingMaskIntoConstraints = NO;
    line2.backgroundColor = COLOR_HEX2RGB(0xd2d2d2);
    [self.view addSubview:line2];
    
    UILabel *lb_filed2 = [[UILabel alloc] init];
    lb_filed2.translatesAutoresizingMaskIntoConstraints = NO;
    lb_filed2.textColor = COLOR_HEX2RGB(0x686868);
    lb_filed2.font = [UIFont systemFontOfSize:16.0];
    lb_filed2.text = @"可提取金额";
    [self.view addSubview:lb_filed2];
    
    self.availableLabel = [[UILabel alloc] init];
    _availableLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _availableLabel.textColor = COLOR_HEX2RGB(0x1c8973);
    _availableLabel.font = FONT_WITH_SIZE(18);
    _availableLabel.text = @"";
    [self.view addSubview:_availableLabel];
    
    UIView *line3 = [[UIView alloc] init];
    line3.translatesAutoresizingMaskIntoConstraints = NO;
    line3.backgroundColor = COLOR_HEX2RGB(0xd2d2d2);
    [self.view addSubview:line3];
    
    UILabel *lb_filed3 = [[UILabel alloc] init];
    lb_filed3.translatesAutoresizingMaskIntoConstraints = NO;
    lb_filed3.textColor = COLOR_HEX2RGB(0x686868);
    lb_filed3.font = [UIFont systemFontOfSize:16.0];
    lb_filed3.text = @"输入要提取的金额";
    [self.view addSubview:lb_filed3];
    
    self.tfMoney = [[UITextField alloc] init];
    _tfMoney.translatesAutoresizingMaskIntoConstraints = NO;
    _tfMoney.layer.borderColor = COLOR_HEX2RGB(0xd3d3d3).CGColor;
    _tfMoney.layer.borderWidth = 0.5;
    _tfMoney.layer.masksToBounds = YES;
    _tfMoney.backgroundColor = [UIColor whiteColor];
    _tfMoney.keyboardType = UIKeyboardTypeNumberPad;
    _tfMoney.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 14, 0)];
    _tfMoney.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_tfMoney];
    
    self.btn_submit = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_submit.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btn_submit setTitle:@"提交申请" forState:UIControlStateNormal];
    self.btn_submit.titleLabel.font = FONT_WITH_SIZE(18);
    [self.btn_submit setBackgroundImage:[[UIImage imageNamed:@"btn-bg-orange2"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [self.btn_submit setBackgroundImage:[[UIImage imageNamed:@"bar-bg-gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateDisabled];
    [self.btn_submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn_submit];
    
    self.lb_filed4 = [[UILabel alloc] init];
    self.lb_filed4.translatesAutoresizingMaskIntoConstraints = NO;
    self.lb_filed4.textColor = COLOR_HEX2RGB(0xc11016);
    self.lb_filed4.font = FONT_NORMAL_14;
    self.lb_filed4.text = @"(提示：请输入不大于当前额度的数值)";
    [self.view addSubview:_lb_filed4];
    
    NSDictionary *vds = NSDictionaryOfVariableBindings(lb_field0,line,lb_filed1,_totalCapitalLabel,line2,lb_filed2,_availableLabel,line3,lb_filed3,_tfMoney,_btn_submit,_lb_filed4);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[lb_field0]-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line]|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[lb_filed1]-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_totalCapitalLabel]-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-7-[line2]-11-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[lb_filed2]-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_availableLabel]-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-7-[line3]-11-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[lb_filed3]-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_tfMoney]-150-[_btn_submit(180)]-40-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_lb_filed4]-|" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lb_field0(59.5)][line(0.5)]-[lb_filed1(30)]-[_totalCapitalLabel(30)]-[line2(0.5)]-[lb_filed2(30)]-[_availableLabel(30)]-[line3(0.5)]-[lb_filed3(30)]-[_tfMoney(52)]-[_lb_filed4(20)]" options:0 metrics:nil views:vds]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_btn_submit(44)]" options:0 metrics:nil views:vds]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_btn_submit
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_tfMoney
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_tfMoney];
}

- (void)textFieldChanged:(id)sender {
    NSLog(@"%@",_tfMoney.text);
    NSString *money = _tfMoney.text;
    if (![NSString isPureFloatValue:money] && ![NSString isPureIntValue:money]) {
        self.lb_filed4.text = @"(提示：当前输入金额不合法)";
        self.btn_submit.enabled = NO;
        return;
    }
    
    if ([money floatValue] > [_balance floatValue]) {
        self.lb_filed4.text = @"(提示：提现金额不能大于当前可提现额度)";
        self.btn_submit.enabled = NO;
        return;
    }
    
    self.lb_filed4.text = @"(提示：请输入不大于当前额度的数值)";
    self.btn_submit.enabled = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submit:(id)sender {
    NSString *submitMoney = _tfMoney.text;
    if ([submitMoney isBlank]) {
        JDStatusBarNotificationError(@"请输入要提取的金额");
        return;
    }
    
    if ([submitMoney floatValue] > [_balance floatValue]) {
        JDStatusBarNotificationError(@"提现金额不能大于当前可提现额度");
        return;
    }
    
    
    NSString *string = [NSString stringWithFormat:@"您确定提现%@元吗？",submitMoney];
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确实", nil];
    [alerView show];
    
    [alerView bk_setWillDismissBlock:^(UIAlertView *alertView, NSInteger index) {
        switch (index) {
            case 1:
            {
                [[DrawMoneyService sharedDrawMoneyService] submitDrawMoneyWith:submitMoney totolMoney:[NSString stringWithFormat:@"%@",_balance] complete:^{
                    JDStatusBarNotificationSuccess(@"提现成功，等待审核");
                    _tfMoney.text = @"";
                    [[DrawMoneyService sharedDrawMoneyService] bankrollComplete:^(NSString *account, NSString *balance) {
                        self.totalCapitalLabel.text = [NSString stringWithFormat:@"￥%@", account];//[@"￥ " addString:account];
                        self.availableLabel.text = [NSString stringWithFormat:@"￥%@", balance];
                        self.account = account;
                        self.balance = balance;
                    } error:^(NSString *error) {
                        JDStatusBarNotificationError(error);
                    }];
                } error:^(NSString *error) {
                    JDStatusBarNotificationError(error);
                }];
            }
                break;
                
            default:
                break;
        }
    }];
}

@end
