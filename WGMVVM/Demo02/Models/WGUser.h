//
//  WGUser.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGUserModel.h"
#import "WGResult.h"
#import "WGServices.h"
#import "WGResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGUser : NSObject

@property (nonatomic, strong, readonly) WGServices *service;
@property (nonatomic, strong) WGUserModel *userModel;

@property (nonatomic, assign, readonly) BOOL validOfUserName;
@property (nonatomic, assign, readonly) BOOL validOfPassWord;


+ (instancetype)userWithService:(WGServices *)service userModel:(WGUserModel *)userModel;
- (instancetype)initWithService:(WGServices *)service userModel:(WGUserModel *)userModel;

- (RACSignal *)loginSignal;
- (RACSignal *)logoutSignal;

@end

NS_ASSUME_NONNULL_END
