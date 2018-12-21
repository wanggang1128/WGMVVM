//
//  LoginViewModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/21.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel()

@end

@implementation LoginViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initialBind];
    }
    return self;
}

- (void)initialBind{
    
    // 监听账号的属性值改变，把他们聚合成一个信号。
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.accountModel, account),RACObserve(self.accountModel, pwd)] reduce:^id(NSString *account,NSString *pwd){
        
        return @(account.length && pwd.length);
    }];
    
    // 处理登录业务逻辑
    _LoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"点击了登录");
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            // 模仿网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@"登录成功"];
                
                // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
        return signal;
    }];
    
    // 监听登录产生的数据
    [_LoginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        if ([x isEqualToString:@"登录成功"]) {
            NSLog(@"登录成功");
        }
    }];
    
    // 监听登录状态
    [[_LoginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x isEqualToNumber:@(YES)]) {
            
            // 正在登录ing...
            // 用蒙版提示
            NSLog(@"正在登陆...");
        }else
        {
            // 登录成功
            // 隐藏蒙版
            NSLog(@"登陆成功");;
        }
    }];
}

-(AccountModel *)accountModel{
    if (!_accountModel) {
        _accountModel = [[AccountModel alloc] init];
    }
    return _accountModel;
}

@end
