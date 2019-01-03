//
//  WGNewLoginViewModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGNewLoginViewModel.h"

@implementation WGNewLoginViewModel

+ (instancetype)loginViewModelWithUser:(WGUser *)user{
    
    return [[self alloc] initWithWGUser:user];
}

- (instancetype)initWithWGUser:(WGUser *)user{
    
    self = [super init];
    if (self) {
        
        self.user = user;
        
         //创建有效的用户名密码信号
        @weakify(self);
        RACSignal *validUS = [[RACObserve(self.user.userModel, userName) map:^id _Nullable(id  _Nullable value) {
            @strongify(self);
            return @(self.user.validOfUserName);
        }] distinctUntilChanged];
        
        [validUS subscribeNext:^(id  _Nullable x) {
            BOOL isYes = [x boolValue];
            if (isYes) {
                //可点击
            }else{
                //不可点击
            }
        }];
        
        RACSignal *validPS = [[RACObserve(self.user.userModel, passWord) map:^id _Nullable(id  _Nullable value) {
            @strongify(self);
            return @(self.user.validOfPassWord);
        }] distinctUntilChanged];
        
        //合并有效的用户名密码信号作为控制登录按钮可用的信号
        RACSignal *validUP = [RACSignal combineLatest:@[validUS, validPS] reduce:^id _Nonnull(id first, id second){
            
            return @([first boolValue] && [second boolValue]);
        }];
        
        self.loginCommand = [[RACCommand alloc] initWithEnabled:validUP signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            @strongify(self);
            return [[self.user loginSignal] logAll];
        }];
    }
    return self;
}

@end
