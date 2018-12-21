//
//  LoginViewModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/21.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "AccountModel.h"
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic, strong) AccountModel *accountModel;

// 是否允许登录的信号
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *LoginCommand;

@end

NS_ASSUME_NONNULL_END
