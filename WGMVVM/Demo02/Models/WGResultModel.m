//
//  WGResultModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGResultModel.h"

@implementation WGResultModel

+ (instancetype)resultWithSuccess:(BOOL)success message:(NSString *)message dataModel:(id)dataModel{
    
    return [[self alloc] initWithSuccess:success message:message dataModel:dataModel];
}

- (instancetype)initWithSuccess:(BOOL)success message:(NSString *)message dataModel:(id)dataModel{
    
    self = [super init];
    if (self) {
        self.success = success;
        self.message = message;
        self.dataModel = dataModel;
    }
    return self;
}

@end
