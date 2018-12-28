//
//  WGUserModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGUserModel.h"

@implementation WGUserModel

+ (instancetype)userModelWithUsername:(NSString *)username password:(NSString *)password logined:(BOOL)logined{
    
    return [[self alloc] initWithUsername:username password:password logined:logined];
}

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password logined:(BOOL)logined{
    
    self = [super init];
    if (self) {
        self.userName = username;
        self.passWord = password;
        self.logined = logined;
    }
    return self;
}


@end
