//
//  WGFriendModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/29.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGFriendModel.h"

@implementation WGFriendModel

+ (instancetype)firendModelWithInfoDic:(NSDictionary *)dic{
    
    return [[self alloc] initWithInfoDic:dic];
}

- (instancetype)initWithInfoDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        self.uin = [dic[@"uin"] stringValue];
        self.name = dic[@"name"];
        self.img = dic[@"img"];
    }
    return self;
}

@end
