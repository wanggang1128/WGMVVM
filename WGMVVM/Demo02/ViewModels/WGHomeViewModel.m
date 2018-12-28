//
//  WGHomeViewModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/28.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGHomeViewModel.h"

@implementation WGHomeViewModel

+ (instancetype)homeViewModelWithHomeModel:(WGHomeModel *)homeModel{
    
    return [[self alloc] initWithHomeModel:homeModel];
}

- (instancetype)initWithHomeModel:(WGHomeModel *)homeModel;{
    
    self = [super init];
    if (self) {
        
        self.homeModel = homeModel;
        
        self.logoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [[self.homeModel.user logoutSignal] logAll];
        }];
    }
    return self;
}

@end
