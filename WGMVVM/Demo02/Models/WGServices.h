//
//  WGServices.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGServices : NSObject

//登录
- (RACSignal *)loginSignal:(NSString *)userName passWord:(NSString *)passWord;

//登出
- (RACSignal *)logoutSignal:(NSString *)userName passWord:(NSString *)passWord;

//朋友列表
- (RACSignal *)friendSignalWithPage:(NSInteger)page andCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
