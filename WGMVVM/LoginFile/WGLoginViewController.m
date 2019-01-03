//
//  WGLoginViewController.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/21.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGLoginViewController.h"
#import "LoginViewModel.h"


@interface WGLoginViewController ()

@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) LoginViewModel *loginViewModel;

@end

@implementation WGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.pwdField];
    [self.view addSubview:self.loginBtn];
    
    [self bindModel];
}

// 视图模型绑定
- (void)bindModel
{
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给accountModel赋值
    RAC(self.loginViewModel.accountModel, account) = _accountField.rac_textSignal;
    RAC(self.loginViewModel.accountModel, pwd) = _pwdField.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
    
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        // 执行登录事件
        [self.loginViewModel.LoginCommand execute:nil];
    }];
    
    // 监听登录状态
    [[self.loginViewModel.LoginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x isEqualToNumber:@(YES)]) {
            
            // 正在登录...
            // 用蒙版提示
            [LoadingTool showTo:self.view];
        }else
        {
            // 登录完成
            // 隐藏蒙版
            
            [LoadingTool hideFrom:self.view];
        }
    }];
    
    // 监听登录产生的数据
    [self.loginViewModel.LoginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        [self.accountField resignFirstResponder];
        [self.pwdField resignFirstResponder];
        
        if ([x isEqualToString:@"登录成功"]) {
            
            [LoadingTool showMessage:@"登录成功" toView:[UIApplication sharedApplication].keyWindow];

            
        }else{
            
        }
        
    }];
}

-(UITextField *)accountField{
    if (!_accountField) {
        _accountField = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, SCREEN_Width-30, 40)];
        _accountField.backgroundColor = [UIColor whiteColor];
    }
    return _accountField;
}

-(UITextField *)pwdField{
    if (!_pwdField) {
        _pwdField = [[UITextField alloc] initWithFrame:CGRectMake(15, 200, SCREEN_Width-30, 40)];
        _pwdField.backgroundColor = [UIColor whiteColor];
    }
    return _pwdField;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 300, SCREEN_Width-30, 40)];
        _loginBtn.backgroundColor = [UIColor yellowColor];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _loginBtn;
}

- (LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

@end
