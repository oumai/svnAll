//
//  QYSUpdateNameViewController.m
//  QieYouShop
//
//  Created by 李赛强 on 15/3/22.
//  Copyright (c) 2015年 CoderFly. All rights reserved.
//

#import "QYSUpdateNameViewController.h"

@interface QYSUpdateNameViewController ()

@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation QYSUpdateNameViewController

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"账号设置";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack target:self action:@selector(btnBackClick)];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" target:self action:@selector(finish:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTheme];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 36)];
    
    self.textFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 360, 36)];
    self.textFiled.font = [UIFont systemFontOfSize:14.0f];
    self.textFiled.textColor = [UIColor lightGrayColor];
    self.textFiled.placeholder = @"请输入要修改的昵称";
    self.textFiled.text = _name;
    self.textFiled.layer.borderColor = [UIColor grayColor].CGColor;
    self.textFiled.layer.borderWidth = 0.5f;
    self.textFiled.leftViewMode = UITextFieldViewModeAlways;
    self.textFiled.leftView = leftView;
    [self.view addSubview:_textFiled];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 60, 15);
    [self.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.rightButton addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    self.errorLabel = [UILabel LabelWithFrame:CGRectMake(0, 70, 400, 14) text:@"最多只能输入10个字符" textColor:[UIColor redColor] font:14.0f textAlignment:NSTextAlignmentCenter];
    self.errorLabel.hidden = YES;
    [self.view addSubview:_errorLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_textFiled];

}

- (void)textFieldChanged:(id)sender {
    NSLog(@"%@",_textFiled.text);
    self.errorLabel.hidden = _textFiled.text.length <= 10;
    self.rightButton.enabled = _textFiled.text.length <= 10;
}

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)finish:(id)sender {
    [[AccountSettingService sharedAccountSettingService] updateInfo:_textFiled.text accountUpdateType:AccountUpdateTypeNickName complete:^{
        JDStatusBarNotificationSuccess(@"修改昵称成功");
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSString *error) {
        JDStatusBarNotificationError(error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
