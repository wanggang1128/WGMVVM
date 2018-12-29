//
//  WGFriendCellViewModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/29.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGFriendCellViewModel.h"

@implementation WGFriendCellViewModel

+ (instancetype)friendCellViewModel:(WGFriendModel *)model{
    
    return [[self alloc] initWithFriendModel:model];
}
- (instancetype)initWithFriendModel:(WGFriendModel *)model{
    
    self = [super init];
    if (self) {
        
        self.friendModel = model;
    }
    return self;
}


@end
