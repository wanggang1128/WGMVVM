//
//  WGHomeViewModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/28.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGHomeViewModel : NSObject

@property (nonatomic, strong) WGHomeModel *homeModel;
@property (nonatomic, strong) RACCommand *logoutCommand;

+ (instancetype)homeViewModelWithHomeModel:(WGHomeModel *)homeModel;
- (instancetype)initWithHomeModel:(WGHomeModel *)homeModel;

@end

NS_ASSUME_NONNULL_END
