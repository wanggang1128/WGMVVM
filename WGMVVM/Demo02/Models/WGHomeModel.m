//
//  WGHomeModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/28.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGHomeModel.h"

@implementation WGHomeModel

+ (instancetype)homeWithWGUser:(WGUser *)user{
    
    return [[self alloc] initWithWGUser:user];
}

- (instancetype)initWithWGUser:(WGUser *)user{
    
    self = [super init];
    if (self) {
        self.user = user;
    }
    return self;
}

@end
