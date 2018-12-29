//
//  WGHomeModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/28.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGHomeModel.h"
#import "WGFriendModel.h"

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

-(RACSignal *)friendSignalWithPage:(NSInteger)page count:(NSInteger)count{
    
    return [[self.user.service friendSignalWithPage:page andCount:count] map:^id _Nullable(WGResult *result) {
        
        //转换为模型数据
        return [WGResultModel resultWithSuccess:result.success message:result.message dataModel:[result.responseObject linq_select:^id(id item) {
            return [WGFriendModel firendModelWithInfoDic:item];
        }]];
    }];
}

@end
