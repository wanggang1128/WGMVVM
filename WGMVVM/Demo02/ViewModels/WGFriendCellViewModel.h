//
//  WGFriendCellViewModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/29.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGFriendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGFriendCellViewModel : NSObject

@property (strong, nonatomic) WGFriendModel *friendModel;

+ (instancetype)friendCellViewModel:(WGFriendModel *)model;
- (instancetype)initWithFriendModel:(WGFriendModel *)model;

@end

NS_ASSUME_NONNULL_END
