//
//  WGResult.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGResult.h"

@implementation WGResult

+ (instancetype)resultWithSuccess:(BOOL)success message:(NSString *)message responseObject:(id)responseObject{
    
    return [[self alloc] initWithSuccess:success message:message responseObject:responseObject];
}

- (instancetype)initWithSuccess:(BOOL)success message:(NSString *)message responseObject:(id)responseObject{
    
    self = [super init];
    if (self) {
        self.success = success;
        self.message = message;
        self.responseObject = responseObject;
    }
    return self;
}

@end
