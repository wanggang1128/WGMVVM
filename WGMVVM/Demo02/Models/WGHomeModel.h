//
//  WGHomeModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/28.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGHomeModel : NSObject

@property (nonatomic, strong) WGUser *user;

+ (instancetype)homeWithWGUser:(WGUser *)user;
- (instancetype)initWithWGUser:(WGUser *)user;

- (RACSignal *)friendSignalWithPage:(NSInteger)page count:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
