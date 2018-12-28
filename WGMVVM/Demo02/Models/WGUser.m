//
//  WGUser.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGUser.h"

@implementation WGUser

+ (instancetype)userWithService:(WGServices *)service userModel:(WGUserModel *)userModel{
    
    return [[self alloc] initWithService:service userModel:userModel];
}

- (instancetype)initWithService:(WGServices *)service userModel:(WGUserModel *)userModel{
    
    self = [super init];
    if (self) {
        _service = service;
        self.userModel = userModel;
    }
    return self;
}

- (RACSignal *)loginSignal{
    
    return [[self.service loginSignal:self.userModel.userName passWord:self.userModel.passWord] map:^id _Nullable(WGResult *result) {
        
        self.userModel.logined = result.success && [result.responseObject[@"code"] integerValue] == 0;
        
        //转为模型数据
        return [WGResultModel resultWithSuccess:result.success?[result.responseObject[@"code"] integerValue] == 0 : result.success message:result.success?result.responseObject[@"message"] : result.message dataModel:[WGUser userWithService:self.service userModel:[WGUserModel userModelWithUsername:result.responseObject[@"userName"] password:result.responseObject[@"passWord"] logined:result.success && [result.responseObject[@"code"] integerValue] == 0]]];
        
    }];
}

- (BOOL)isValid:(NSString *)str{
    
    /*
     定一个规则：由字母、数字和_组成的6-16位字符串
     */
    NSString *regularStr = @"[a-zA-Z0-9_]{6,16}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", regularStr];
    return [predicate evaluateWithObject:str];
}


-(BOOL)validOfUserName{
    
    return [self isValid:self.userModel.userName];
}

- (BOOL)validOfPassWord{
    return [self isValid:self.userModel.passWord];
}

@end
