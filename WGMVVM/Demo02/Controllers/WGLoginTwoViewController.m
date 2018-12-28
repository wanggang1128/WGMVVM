//
//  WGLoginTwoViewController.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGLoginTwoViewController.h"
#import "WGHomeViewModel.h"

@interface WGLoginTwoViewController ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) WGHomeViewModel *viewModel;

@end

@implementation WGLoginTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WGLoginTwoViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
    
    [self bindViewModel];
}

- (void)createView{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setTitle:@"退出" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.leftButton = leftButton;
}

- (void)bindViewModel{
    
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self.viewModel.logoutCommand execute:nil];
    }];
    
    [self.viewModel.logoutCommand.executing subscribeNext:^(NSNumber * _Nullable x) {
        BOOL show = [x boolValue];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = show;

        if (show) {
            [LoadingTool showTo:self.view];
        }else{
            [LoadingTool hideFrom:self.view];
        }
    }];
    
    [self.viewModel.logoutCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        WGResultModel *model = (WGResultModel *)x;
        
        if (model.success) {
            
            UIViewController *vc = [[WGControllerPush WGControllerPushShare] getViewControllerWithConName:@"WGNewLoginViewController" paramType:WGPushNoParam param:nil];
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
            [window makeKeyWindow];
        }else{
            
            [LoadingTool showMessage:model.message toView:[UIApplication sharedApplication].keyWindow];
        }
    }];
}

-(WGHomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [WGHomeViewModel homeViewModelWithHomeModel:[WGHomeModel homeWithWGUser:self.user]];
    }
    return _viewModel;
}

@end
