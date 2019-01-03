//
//  WGNewLoginViewController.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGNewLoginViewController.h"

@interface WGNewLoginViewController ()

@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) WGNewLoginViewModel *viewModel;

@end

@implementation WGNewLoginViewController

//-(instancetype)initWithLoginViewModel:(WGNewLoginViewModel *)viewModel{
//    if (self = [super init]) {
//        self.viewModel = viewModel;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.pwdField];
    [self.view addSubview:self.loginBtn];
    
    [self bindViewModel];
}

- (void)bindViewModel{
    
    self.accountField.text = self.viewModel.user.userModel.userName;
    self.pwdField.text = self.viewModel.user.userModel.passWord;
    RAC(self.viewModel.user.userModel,userName) = self.accountField.rac_textSignal;
    RAC(self.viewModel.user.userModel,passWord) = self.pwdField.rac_textSignal;
    
    // 监听登录按钮点击
//    self.loginBtn.rac_command = self.viewModel.loginCommand;
    
    // 监听登录按钮点击
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        // 执行登录事件
        [self.viewModel.loginCommand execute:nil];
    }];
    
    @weakify(self)
    [self.viewModel.loginCommand.executing subscribeNext:^(NSNumber * _Nullable x) {
        
        @strongify(self)
        BOOL end = [x boolValue];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = end;
        if (end) {
            [LoadingTool showTo:self.view];
        } else {
            [LoadingTool hideFrom:self.view];
        }
    }];
    
    //订阅信号,接收收据
    [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(WGResultModel *model) {

        @strongify(self)

        [self.accountField resignFirstResponder];
        [self.pwdField resignFirstResponder];

        if (model.success) {

            UIViewController *vc = [[WGControllerPush WGControllerPushShare] getViewControllerWithConName:@"WGHomeViewController" paramType:WGPushProperty param:@{@"property":@{@"user":self.viewModel.user}}];
            [UIApplication sharedApplication].delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
            [[UIApplication sharedApplication].delegate.window makeKeyWindow];
        } else {
            [LoadingTool showMessage:model.message toView:[UIApplication sharedApplication].keyWindow];
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

- (WGNewLoginViewModel *)viewModel{
    if (!_viewModel) {

        _viewModel = [WGNewLoginViewModel loginViewModelWithUser:[WGUser userWithService:[[WGServices alloc] init] userModel:[WGUserModel userModelWithUsername:@"hanjiang" password:@"123456" logined:NO]]];
    }
    return _viewModel;
}

@end
