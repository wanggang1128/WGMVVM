//
//  WGNewLoginViewModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGUser.h"


NS_ASSUME_NONNULL_BEGIN

@interface WGNewLoginViewModel : NSObject

@property (nonatomic, strong) WGUser *user;
@property (nonatomic, strong) RACCommand *loginCommand;

+ (instancetype)loginViewModelWithUser:(WGUser *)user;

- (instancetype)initWithWGUser:(WGUser *)user;

@end

NS_ASSUME_NONNULL_END
