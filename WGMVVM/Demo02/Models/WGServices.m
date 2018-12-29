//
//  WGServices.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGServices.h"

@implementation WGServices

//登录
- (RACSignal *)loginSignal:(NSString *)userName passWord:(NSString *)passWord{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //调取后台登录接口
        [NetworkingTool postWithPath:K_Service_Login parameters:@{@"userName": userName, @"passWord": passWord} completion:^(BOOL success, NSString *message, id responseObject){
            
            [subscriber sendNext:[WGResult resultWithSuccess:success message:message responseObject:responseObject]];
            [subscriber sendCompleted];
            
        }];
        
        RACDisposable *disposable = [RACDisposable disposableWithBlock:^{
            //完成后清理不需要的资源
        }];
        return disposable;
    }];
    return signal;
}

//登出
- (RACSignal *)logoutSignal:(NSString *)userName passWord:(NSString *)passWord{
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //调登出接口
        [NetworkingTool postWithPath:K_Service_Logout parameters:@{@"userName": userName, @"passWord": passWord} completion:^(BOOL success, NSString *message, id responseObject) {
            
            [subscriber sendNext:[WGResult resultWithSuccess:success message:message responseObject:responseObject]];
            [subscriber sendCompleted];

        }];
        
        return [RACDisposable disposableWithBlock:^{
            //登出后的对应处理
        }];
        
    }];
}

//朋友列表
- (RACSignal *)friendSignalWithPage:(NSInteger)page andCount:(NSInteger)count{
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //调后台接口
        [NetworkingTool postWithPath:K_Service_PageFriends parameters:@{@"page": @(page), @"count": @(count)} completion:^(BOOL success, NSString *message, id responseObject) {
            
            [subscriber sendNext:[WGResult resultWithSuccess:success message:message responseObject:responseObject]];
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            //完成后清理不需要的资源
        }];
    }];
}














@end
